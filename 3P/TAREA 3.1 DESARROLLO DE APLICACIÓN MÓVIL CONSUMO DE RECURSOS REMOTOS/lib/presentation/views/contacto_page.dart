import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import '../providers/contacto_providers.dart';
import '../temas/app_colors.dart';
import '../widgets/widgets.dart';
import '../../domain/entities/contacto.dart';

/// Página de lista de contactos
class ContactosPage extends ConsumerStatefulWidget {
  const ContactosPage({super.key});

  @override
  ConsumerState<ContactosPage> createState() => _ContactosPageState();
}

class _ContactosPageState extends ConsumerState<ContactosPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final contactosAsync = ref.watch(contactoProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Contactos'),
        elevation: 0,
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Botón para agregar contacto
          FloatingActionButton(
            heroTag: 'addContact',
            onPressed: () => _mostrarDialogoContacto(context, ref, null),
            backgroundColor: AppColors.accent,
            child: const Icon(Icons.add, color: Colors.white),
          ),
          const SizedBox(height: 12),
          // Botón de marcador (dial pad)
          FloatingActionButton(
            heroTag: 'dialPad',
            onPressed: () => _mostrarDialPad(context),
            backgroundColor: AppColors.accent,
            child: const Icon(Icons.dialpad, color: Colors.white),
          ),
        ],
      ),
      body: Column(
        children: [
          // Barra de búsqueda
          Container(
            color: AppColors.primary,
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.shadow,
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: TextField(
                controller: _searchController,
                onChanged: (value) => setState(() => _searchQuery = value),
                decoration: InputDecoration(
                  hintText: 'Buscar',
                  hintStyle: TextStyle(color: AppColors.textSecondary),
                  prefixIcon: const Icon(Icons.search, color: AppColors.textSecondary),
                  suffixIcon: _searchQuery.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () {
                            _searchController.clear();
                            setState(() => _searchQuery = '');
                          },
                        )
                      : Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.tune, color: AppColors.textSecondary),
                              onPressed: () {},
                            ),
                            IconButton(
                              icon: const Icon(Icons.sort_by_alpha, color: AppColors.textSecondary),
                              onPressed: () {},
                            ),
                          ],
                        ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
          ),
          // Lista de contactos
          Expanded(
            child: contactosAsync.when(
              data: (contactos) {
                final filteredContactos = ref.read(contactoProvider.notifier).filtrar(contactos, _searchQuery);
                
                if (filteredContactos.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.person_off, size: 64, color: AppColors.textSecondary),
                        const SizedBox(height: 16),
                        Text(
                          _searchQuery.isEmpty 
                              ? 'No hay contactos\nToca + para agregar uno'
                              : 'No se encontraron resultados',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: AppColors.textSecondary, fontSize: 16),
                        ),
                      ],
                    ),
                  );
                }
                
                return Stack(
                  children: [
                    ListView.separated(
                      padding: const EdgeInsets.only(right: 18),
                      itemCount: filteredContactos.length,
                      separatorBuilder: (_, __) => const Divider(height: 1, indent: 72),
                      itemBuilder: (_, i) => _buildContactoTile(context, ref, filteredContactos[i]),
                    ),
                    // Índice alfabético
                    Positioned(
                      right: 0,
                      top: 0,
                      bottom: 0,
                      child: _buildAlphabetIndex(),
                    ),
                  ],
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, size: 48, color: AppColors.error),
                    const SizedBox(height: 16),
                    Text('Error: $e', style: const TextStyle(color: AppColors.error)),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => ref.read(contactoProvider.notifier).cargar(),
                      child: const Text('Reintentar'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAlphabetIndex() {
    return const AlphabetIndex();
  }

  Widget _buildContactoTile(BuildContext context, WidgetRef ref, Contacto contacto) {
    return ContactTile(
      name: contacto.nombre,
      phone: contacto.telefono,
      email: contacto.email,
      imageUrl: contacto.foto,
      isFavorite: contacto.esFavorito,
      onTap: () => _mostrarDialogoContacto(context, ref, contacto),
      onFavoritePressed: () async {
        await ref.read(contactoProvider.notifier).toggleFavorito(contacto);
        ref.read(favoritosProvider.notifier).cargar();
      },
      onCallPressed: contacto.telefono.isNotEmpty ? () => _llamar(contacto.telefono) : null,
      onEmailPressed: contacto.email.isNotEmpty ? () => _enviarEmail(contacto.email) : null,
      onEditPressed: () => _mostrarDialogoContacto(context, ref, contacto),
      onDeletePressed: () => _confirmarEliminar(context, ref, contacto),
    );
  }

  Future<void> _llamar(String telefono) async {
    // Llamada directa sin abrir el marcador
    await FlutterPhoneDirectCaller.callNumber(telefono);
  }

  Future<void> _enviarEmail(String email) async {
    final uri = Uri.parse('mailto:$email');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  void _confirmarEliminar(BuildContext context, WidgetRef ref, Contacto contacto) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Eliminar contacto'),
        content: Text('¿Estás seguro de eliminar a ${contacto.nombre}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
            onPressed: () async {
              await ref.read(contactoProvider.notifier).eliminar(contacto.id!);
              ref.read(favoritosProvider.notifier).cargar();
              if (context.mounted) Navigator.pop(context);
            },
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );
  }

  void _mostrarDialogoContacto(BuildContext context, WidgetRef ref, Contacto? contacto) {
    final bool esEdicion = contacto != null;
    final nombreCtrl = TextEditingController(text: contacto?.nombre ?? '');
    final descripcionCtrl = TextEditingController(text: contacto?.descripcion ?? '');
    final telefonoCtrl = TextEditingController(text: contacto?.telefono ?? '');
    final emailCtrl = TextEditingController(text: contacto?.email ?? '');
    String fotoPath = contacto?.foto ?? '';

    showDialog(
      context: context,
      builder: (_) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Text(esEdicion ? 'Editar Contacto' : 'Nuevo Contacto'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Avatar
                GestureDetector(
                  onTap: () async {
                    final picker = ImagePicker();
                    final image = await picker.pickImage(source: ImageSource.gallery);
                    if (image != null) {
                      setDialogState(() => fotoPath = image.path);
                    }
                  },
                  child: CircleAvatar(
                    radius: 40,
                    backgroundColor: AppColors.accent.withAlpha(50),
                    backgroundImage: fotoPath.isNotEmpty ? FileImage(File(fotoPath)) : null,
                    child: fotoPath.isEmpty
                        ? const Icon(Icons.camera_alt, size: 32, color: AppColors.primary)
                        : null,
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: nombreCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Nombre *',
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: telefonoCtrl,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText: 'Teléfono',
                    prefixIcon: Icon(Icons.phone),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: emailCtrl,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: descripcionCtrl,
                  maxLines: 2,
                  decoration: const InputDecoration(
                    labelText: 'Descripción',
                    prefixIcon: Icon(Icons.description),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (nombreCtrl.text.trim().isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('El nombre es requerido')),
                  );
                  return;
                }

                final nuevoContacto = Contacto(
                  id: contacto?.id,
                  nombre: nombreCtrl.text.trim(),
                  descripcion: descripcionCtrl.text.trim(),
                  telefono: telefonoCtrl.text.trim(),
                  email: emailCtrl.text.trim(),
                  foto: fotoPath,
                  esFavorito: contacto?.esFavorito ?? false,
                );

                if (esEdicion) {
                  await ref.read(contactoProvider.notifier).actualizar(nuevoContacto);
                } else {
                  await ref.read(contactoProvider.notifier).agregar(nuevoContacto);
                }
                ref.read(favoritosProvider.notifier).cargar();

                if (context.mounted) Navigator.pop(context);
              },
              child: const Text('Guardar'),
            ),
          ],
        ),
      ),
    );
  }

  /// Muestra el dial pad para escribir un número y llamar
  void _mostrarDialPad(BuildContext context) {
    final phoneController = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Row(
            children: [
              Icon(Icons.phone, color: AppColors.iconCall),
              const SizedBox(width: 8),
              const Text('Marcar número'),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Display del número
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.accent.withAlpha(100)),
                ),
                child: Text(
                  phoneController.text.isEmpty ? 'Ingresa un número' : phoneController.text,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: phoneController.text.isEmpty 
                        ? AppColors.textSecondary 
                        : AppColors.textPrimary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 16),
              // Teclado numérico
              _buildDialPadGrid(phoneController, setDialogState),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.iconCall,
                foregroundColor: Colors.white,
              ),
              onPressed: phoneController.text.isEmpty
                  ? null
                  : () {
                      Navigator.pop(context);
                      _llamar(phoneController.text);
                    },
              icon: const Icon(Icons.call),
              label: const Text('Llamar'),
            ),
          ],
        ),
      ),
    );
  }

  /// Construye el grid del teclado numérico
  Widget _buildDialPadGrid(TextEditingController controller, StateSetter setDialogState) {
    final buttons = [
      '1', '2', '3',
      '4', '5', '6',
      '7', '8', '9',
      '*', '0', '#',
    ];

    return Column(
      children: [
        for (int row = 0; row < 4; row++)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              for (int col = 0; col < 3; col++)
                _buildDialButton(
                  buttons[row * 3 + col],
                  controller,
                  setDialogState,
                ),
            ],
          ),
        const SizedBox(height: 8),
        // Botón de borrar
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.backspace_outlined),
              iconSize: 28,
              color: AppColors.error,
              onPressed: () {
                if (controller.text.isNotEmpty) {
                  setDialogState(() {
                    controller.text = controller.text.substring(0, controller.text.length - 1);
                  });
                }
              },
            ),
          ],
        ),
      ],
    );
  }

  /// Construye un botón del dial pad
  Widget _buildDialButton(String digit, TextEditingController controller, StateSetter setDialogState) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: InkWell(
        onTap: () {
          setDialogState(() {
            controller.text += digit;
          });
        },
        borderRadius: BorderRadius.circular(30),
        child: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.accent.withAlpha(30),
          ),
          child: Center(
            child: Text(
              digit,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
