import 'dart:io';
import 'package:flutter/material.dart';
import '../../temas/app_colors.dart';
import '../molecules/molecules.dart';

/// Organismo: Tile de contacto completo
class ContactTile extends StatelessWidget {
  final String name;
  final String? phone;
  final String? email;
  final String? imageUrl;
  final bool isFavorite;
  final VoidCallback onTap;
  final VoidCallback onFavoritePressed;
  final VoidCallback? onCallPressed;
  final VoidCallback? onEmailPressed;
  final VoidCallback onEditPressed;
  final VoidCallback onDeletePressed;

  const ContactTile({
    super.key,
    required this.name,
    this.phone,
    this.email,
    this.imageUrl,
    required this.isFavorite,
    required this.onTap,
    required this.onFavoritePressed,
    this.onCallPressed,
    this.onEmailPressed,
    required this.onEditPressed,
    required this.onDeletePressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          children: [
            // Avatar
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
            // Info
            ContactInfo(name: name, phone: phone),
            // Actions
            ContactActionButtons(
              isFavorite: isFavorite,
              hasPhone: phone != null && phone!.isNotEmpty,
              hasEmail: email != null && email!.isNotEmpty,
              onFavoritePressed: onFavoritePressed,
              onCallPressed: onCallPressed,
              onEmailPressed: onEmailPressed,
              onEditPressed: onEditPressed,
              onDeletePressed: onDeletePressed,
            ),
          ],
        ),
      ),
    );
  }
}

/// Organismo: Dial Pad completo
class DialPad extends StatelessWidget {
  final TextEditingController controller;
  final StateSetter setDialogState;
  final VoidCallback onCall;
  final VoidCallback onCancel;

  const DialPad({
    super.key,
    required this.controller,
    required this.setDialogState,
    required this.onCall,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
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
            controller.text.isEmpty ? 'Ingresa un número' : controller.text,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: controller.text.isEmpty
                  ? AppColors.textSecondary
                  : AppColors.textPrimary,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 16),
        // Grid de botones
        _buildDialPadGrid(),
        // Acciones
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              onPressed: onCancel,
              child: const Text('Cancelar'),
            ),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.iconCall,
                foregroundColor: Colors.white,
              ),
              onPressed: controller.text.isEmpty ? null : onCall,
              icon: const Icon(Icons.call),
              label: const Text('Llamar'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDialPadGrid() {
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
                _buildDialButton(buttons[row * 3 + col]),
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

  Widget _buildDialButton(String digit) {
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

/// Organismo: Índice alfabético
class AlphabetIndex extends StatelessWidget {
  final Function(String)? onLetterTap;

  const AlphabetIndex({super.key, this.onLetterTap});

  @override
  Widget build(BuildContext context) {
    final letters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'.split('');
    return Container(
      width: 16,
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: letters.map((letter) => Expanded(
          child: GestureDetector(
            onTap: () => onLetterTap?.call(letter),
            child: Center(
              child: Text(
                letter,
                style: TextStyle(
                  fontSize: 8,
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        )).toList(),
      ),
    );
  }
}

/// Organismo: Lista vacía con mensaje
class EmptyStateWidget extends StatelessWidget {
  final IconData icon;
  final String message;
  final VoidCallback? onRetry;

  const EmptyStateWidget({
    super.key,
    required this.icon,
    required this.message,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 64, color: AppColors.textSecondary),
          const SizedBox(height: 16),
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.textSecondary, fontSize: 16),
          ),
          if (onRetry != null) ...[
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: onRetry,
              child: const Text('Reintentar'),
            ),
          ],
        ],
      ),
    );
  }
}
