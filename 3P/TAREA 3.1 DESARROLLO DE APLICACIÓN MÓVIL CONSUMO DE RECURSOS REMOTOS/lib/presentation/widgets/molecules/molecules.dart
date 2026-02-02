import 'dart:io';
import 'package:flutter/material.dart';
import '../../temas/app_colors.dart';

/// Molécula: Grupo de botones de acción para un contacto
class ContactActionButtons extends StatelessWidget {
  final bool isFavorite;
  final bool hasPhone;
  final bool hasEmail;
  final VoidCallback onFavoritePressed;
  final VoidCallback? onCallPressed;
  final VoidCallback? onEmailPressed;
  final VoidCallback onEditPressed;
  final VoidCallback onDeletePressed;

  const ContactActionButtons({
    super.key,
    required this.isFavorite,
    required this.hasPhone,
    required this.hasEmail,
    required this.onFavoritePressed,
    this.onCallPressed,
    this.onEmailPressed,
    required this.onEditPressed,
    required this.onDeletePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Favorito
        GestureDetector(
          onTap: onFavoritePressed,
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: Icon(
              isFavorite ? Icons.star : Icons.star_border,
              color: isFavorite ? AppColors.iconFavorite : AppColors.textSecondary,
              size: 22,
            ),
          ),
        ),
        // Llamar
        if (hasPhone && onCallPressed != null)
          GestureDetector(
            onTap: onCallPressed,
            child: const Padding(
              padding: EdgeInsets.all(6),
              child: Icon(Icons.phone, color: AppColors.iconCall, size: 22),
            ),
          ),
        // Email
        if (hasEmail && onEmailPressed != null)
          GestureDetector(
            onTap: onEmailPressed,
            child: const Padding(
              padding: EdgeInsets.all(6),
              child: Icon(Icons.email, color: AppColors.iconEmail, size: 22),
            ),
          ),
        // Menú
        PopupMenuButton(
          icon: const Icon(Icons.more_vert, size: 20),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(minWidth: 24),
          itemBuilder: (context) => [
            const PopupMenuItem(value: 'editar', child: Text('Editar')),
            const PopupMenuItem(
              value: 'eliminar',
              child: Text('Eliminar', style: TextStyle(color: Colors.red)),
            ),
          ],
          onSelected: (value) {
            if (value == 'editar') {
              onEditPressed();
            } else if (value == 'eliminar') {
              onDeletePressed();
            }
          },
        ),
      ],
    );
  }
}

/// Molécula: Información del contacto (nombre + teléfono)
class ContactInfo extends StatelessWidget {
  final String name;
  final String? phone;

  const ContactInfo({
    super.key,
    required this.name,
    this.phone,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            name,
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
            overflow: TextOverflow.ellipsis,
          ),
          if (phone != null && phone!.isNotEmpty)
            Text(
              phone!,
              style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
            ),
        ],
      ),
    );
  }
}

/// Molécula: Avatar con información
class AvatarWithInfo extends StatelessWidget {
  final String? imageUrl;
  final String name;
  final String? subtitle;

  const AvatarWithInfo({
    super.key,
    this.imageUrl,
    required this.name,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 22,
          backgroundColor: AppColors.accent.withAlpha(50),
          backgroundImage: imageUrl != null && imageUrl!.isNotEmpty
              ? FileImage(File(imageUrl!))
              : null,
          child: (imageUrl == null || imageUrl!.isEmpty)
              ? Text(
                  name.isNotEmpty ? name[0].toUpperCase() : '?',
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                )
              : null,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                name,
                style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                overflow: TextOverflow.ellipsis,
              ),
              if (subtitle != null && subtitle!.isNotEmpty)
                Text(
                  subtitle!,
                  style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Molécula: Barra de búsqueda
class SearchBar extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final VoidCallback? onClear;

  const SearchBar({
    super.key,
    required this.controller,
    required this.onChanged,
    this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: 'Buscar',
          hintStyle: TextStyle(color: AppColors.textSecondary),
          prefixIcon: const Icon(Icons.search, color: AppColors.textSecondary),
          suffixIcon: controller.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: onClear,
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
    );
  }
}
