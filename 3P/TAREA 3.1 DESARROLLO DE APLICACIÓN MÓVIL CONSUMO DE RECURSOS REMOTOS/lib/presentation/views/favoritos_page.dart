import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import '../providers/contacto_providers.dart';
import '../temas/app_colors.dart';
import '../../domain/entities/contacto.dart';

/// Página de contactos favoritos
class FavoritosPage extends ConsumerWidget {
  const FavoritosPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoritosAsync = ref.watch(favoritosProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favoritos'),
        elevation: 0,
      ),
      body: favoritosAsync.when(
        data: (favoritos) {
          if (favoritos.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.star_border, size: 64, color: AppColors.textSecondary),
                  const SizedBox(height: 16),
                  Text(
                    'No hay favoritos\nMarca contactos con ⭐ para verlos aquí',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: AppColors.textSecondary, fontSize: 16),
                  ),
                ],
              ),
            );
          }
          
          return ListView.separated(
            itemCount: favoritos.length,
            separatorBuilder: (_, __) => const Divider(height: 1, indent: 72),
            itemBuilder: (_, i) => _buildFavoritoTile(context, ref, favoritos[i]),
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
                onPressed: () => ref.read(favoritosProvider.notifier).cargar(),
                child: const Text('Reintentar'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFavoritoTile(BuildContext context, WidgetRef ref, Contacto contacto) {
    return ListTile(
      leading: CircleAvatar(
        radius: 24,
        backgroundColor: AppColors.accent.withAlpha(50),
        backgroundImage: contacto.foto.isNotEmpty ? FileImage(File(contacto.foto)) : null,
        child: contacto.foto.isEmpty
            ? Text(
                contacto.nombre.isNotEmpty ? contacto.nombre[0].toUpperCase() : '?',
                style: const TextStyle(
                  color: AppColors.primary,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              )
            : null,
      ),
      title: Text(
        contacto.nombre,
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
      subtitle: contacto.telefono.isNotEmpty
          ? Text(contacto.telefono, style: TextStyle(color: AppColors.textSecondary))
          : null,
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Quitar de favoritos
          IconButton(
            icon: const Icon(Icons.star, color: AppColors.iconFavorite),
            onPressed: () async {
              await ref.read(favoritosProvider.notifier).toggleFavorito(contacto);
              ref.read(contactoProvider.notifier).cargar();
            },
          ),
          // Llamar
          if (contacto.telefono.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.phone, color: AppColors.iconCall),
              onPressed: () => _llamar(contacto.telefono),
            ),
          // Email
          if (contacto.email.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.email, color: AppColors.iconEmail),
              onPressed: () => _enviarEmail(contacto.email),
            ),
        ],
      ),
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
}
