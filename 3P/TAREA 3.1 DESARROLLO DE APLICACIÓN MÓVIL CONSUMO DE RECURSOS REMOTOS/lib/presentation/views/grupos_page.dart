import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../temas/app_colors.dart';
import '../providers/contacto_providers.dart';
import '../widgets/widgets.dart';
import '../../domain/entities/contacto.dart';

/// Página de grupos de contactos
class GruposPage extends ConsumerWidget {
  const GruposPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gruposAsync = ref.watch(gruposProvider);
    final contactosAsync = ref.watch(contactoProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Grupos'),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _mostrarDialogoCrearGrupo(context, ref),
        backgroundColor: AppColors.accent,
        child: const Icon(Icons.group_add, color: Colors.white),
      ),
      body: gruposAsync.when(
        data: (grupos) {
          if (grupos.isEmpty) {
            return const EmptyStateWidget(
              icon: Icons.group_outlined,
              message: 'No hay grupos\nToca + para crear uno',
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: grupos.length,
            itemBuilder: (_, index) {
              final grupo = grupos[index];
              return _buildGrupoTile(context, ref, grupo, contactosAsync);
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => EmptyStateWidget(
          icon: Icons.error_outline,
          message: 'Error: $e',
          onRetry: () => ref.read(gruposProvider.notifier).cargar(),
        ),
      ),
    );
  }

  Widget _buildGrupoTile(
    BuildContext context,
    WidgetRef ref,
    GrupoData grupo,
    AsyncValue<List<Contacto>> contactosAsync,
  ) {
    final cantidadContactos = grupo.contactoIds.length;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () => _mostrarDetalleGrupo(context, ref, grupo, contactosAsync),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Icono del grupo con color
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Color(grupo.color).withAlpha(50),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.group,
                  color: Color(grupo.color),
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              // Info del grupo
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      grupo.nombre,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    if (grupo.descripcion.isNotEmpty)
                      Text(
                        grupo.descripcion,
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 13,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    Text(
                      '$cantidadContactos contacto${cantidadContactos == 1 ? '' : 's'}',
                      style: TextStyle(
                        color: Color(grupo.color),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              // Botón eliminar
              IconButton(
                icon: const Icon(Icons.delete_outline, color: AppColors.error),
                onPressed: () => _confirmarEliminar(context, ref, grupo),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _mostrarDialogoCrearGrupo(BuildContext context, WidgetRef ref) {
    final nombreCtrl = TextEditingController();
    final descripcionCtrl = TextEditingController();
    int colorSeleccionado = 0xFF4CAF50;

    final colores = [
      0xFF4CAF50, // Verde
      0xFF2196F3, // Azul
      0xFFFF9800, // Naranja
      0xFF9C27B0, // Púrpura
      0xFFE91E63, // Rosa
      0xFF00BCD4, // Cyan
      0xFF795548, // Marrón
      0xFF607D8B, // Gris azulado
    ];

    showDialog(
      context: context,
      builder: (_) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Row(
            children: [
              Icon(Icons.group_add, color: Color(colorSeleccionado)),
              const SizedBox(width: 8),
              const Text('Nuevo Grupo'),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nombreCtrl,
                decoration: const InputDecoration(
                  labelText: 'Nombre del grupo *',
                  hintText: 'Ej: Familia, Trabajo, Amigos...',
                ),
                autofocus: true,
              ),
              const SizedBox(height: 12),
              TextField(
                controller: descripcionCtrl,
                decoration: const InputDecoration(
                  labelText: 'Descripción (opcional)',
                ),
              ),
              const SizedBox(height: 16),
              // Selector de color
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: colores.map((color) {
                  final isSelected = color == colorSeleccionado;
                  return GestureDetector(
                    onTap: () => setState(() => colorSeleccionado = color),
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: Color(color),
                        shape: BoxShape.circle,
                        border: isSelected
                            ? Border.all(color: Colors.white, width: 3)
                            : null,
                        boxShadow: isSelected
                            ? [BoxShadow(color: Color(color), blurRadius: 8)]
                            : null,
                      ),
                      child: isSelected
                          ? const Icon(Icons.check, color: Colors.white, size: 20)
                          : null,
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                if (nombreCtrl.text.trim().isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('El nombre es obligatorio')),
                  );
                  return;
                }
                ref.read(gruposProvider.notifier).agregar(
                  nombreCtrl.text.trim(),
                  descripcion: descripcionCtrl.text.trim(),
                  color: colorSeleccionado,
                );
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Grupo "${nombreCtrl.text}" creado')),
                );
              },
              child: const Text('Crear'),
            ),
          ],
        ),
      ),
    );
  }

  void _confirmarEliminar(BuildContext context, WidgetRef ref, GrupoData grupo) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Eliminar grupo'),
        content: Text('¿Seguro que deseas eliminar el grupo "${grupo.nombre}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
            onPressed: () {
              ref.read(gruposProvider.notifier).eliminar(grupo.id);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Grupo "${grupo.nombre}" eliminado')),
              );
            },
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );
  }

  void _mostrarDetalleGrupo(
    BuildContext context,
    WidgetRef ref,
    GrupoData grupo,
    AsyncValue<List<Contacto>> contactosAsync,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        builder: (_, controller) => Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              // Handle
              Container(
                margin: const EdgeInsets.symmetric(vertical: 12),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              // Header del grupo
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: Color(grupo.color).withAlpha(50),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.group, color: Color(grupo.color), size: 28),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            grupo.nombre,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${grupo.contactoIds.length} contactos',
                            style: TextStyle(color: AppColors.textSecondary),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.person_add),
                      color: Color(grupo.color),
                      onPressed: () => _mostrarAgregarContacto(context, ref, grupo, contactosAsync),
                    ),
                  ],
                ),
              ),
              const Divider(height: 24),
              // Lista de contactos del grupo
              Expanded(
                child: contactosAsync.when(
                  data: (todosContactos) {
                    final contactosDelGrupo = todosContactos
                        .where((c) => grupo.contactoIds.contains(c.id))
                        .toList();

                    if (contactosDelGrupo.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.person_off, size: 48, color: AppColors.textSecondary),
                            const SizedBox(height: 8),
                            Text(
                              'No hay contactos en este grupo',
                              style: TextStyle(color: AppColors.textSecondary),
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton.icon(
                              onPressed: () => _mostrarAgregarContacto(context, ref, grupo, contactosAsync),
                              icon: const Icon(Icons.person_add),
                              label: const Text('Agregar contacto'),
                            ),
                          ],
                        ),
                      );
                    }

                    return ListView.builder(
                      controller: controller,
                      itemCount: contactosDelGrupo.length,
                      itemBuilder: (_, i) {
                        final contacto = contactosDelGrupo[i];
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Color(grupo.color).withAlpha(50),
                            child: Text(
                              contacto.nombre[0].toUpperCase(),
                              style: TextStyle(color: Color(grupo.color)),
                            ),
                          ),
                          title: Text(contacto.nombre),
                          subtitle: contacto.telefono.isNotEmpty
                              ? Text(contacto.telefono)
                              : null,
                          trailing: IconButton(
                            icon: const Icon(Icons.remove_circle_outline),
                            color: AppColors.error,
                            onPressed: () {
                              ref.read(gruposProvider.notifier)
                                  .quitarContactoDeGrupo(grupo.id, contacto.id!);
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('${contacto.nombre} quitado del grupo')),
                              );
                            },
                          ),
                        );
                      },
                    );
                  },
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (e, _) => Center(child: Text('Error: $e')),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _mostrarAgregarContacto(
    BuildContext context,
    WidgetRef ref,
    GrupoData grupo,
    AsyncValue<List<Contacto>> contactosAsync,
  ) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Agregar a ${grupo.nombre}'),
        content: SizedBox(
          width: double.maxFinite,
          height: 300,
          child: contactosAsync.when(
            data: (contactos) {
              final disponibles = contactos
                  .where((c) => !grupo.contactoIds.contains(c.id))
                  .toList();

              if (disponibles.isEmpty) {
                return const Center(
                  child: Text('Todos los contactos ya están en este grupo'),
                );
              }

              return ListView.builder(
                shrinkWrap: true,
                itemCount: disponibles.length,
                itemBuilder: (_, i) {
                  final contacto = disponibles[i];
                  return ListTile(
                    leading: CircleAvatar(
                      child: Text(contacto.nombre[0].toUpperCase()),
                    ),
                    title: Text(contacto.nombre),
                    subtitle: contacto.telefono.isNotEmpty
                        ? Text(contacto.telefono)
                        : null,
                    onTap: () {
                      ref.read(gruposProvider.notifier)
                          .agregarContactoAGrupo(grupo.id, contacto.id!);
                      Navigator.pop(context);
                      Navigator.pop(context); // Cierra el bottom sheet también
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('${contacto.nombre} agregado a ${grupo.nombre}')),
                      );
                    },
                  );
                },
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(child: Text('Error: $e')),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
        ],
      ),
    );
  }
}
