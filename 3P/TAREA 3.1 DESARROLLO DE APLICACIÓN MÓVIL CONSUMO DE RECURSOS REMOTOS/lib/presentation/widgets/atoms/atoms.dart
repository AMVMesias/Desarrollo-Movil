import 'package:flutter/material.dart';
import '../../temas/app_colors.dart';

/// Átomo: Botón de acción circular para contactos
/// Usado para acciones como llamar, email, favorito, etc.
class ActionIconButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  final double size;
  final double padding;

  const ActionIconButton({
    super.key,
    required this.icon,
    required this.color,
    required this.onTap,
    this.size = 22,
    this.padding = 6,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: Icon(icon, color: color, size: size),
      ),
    );
  }
}

/// Átomo: Avatar de contacto
class ContactAvatar extends StatelessWidget {
  final ImageProvider? image;
  final String name;
  final double radius;

  const ContactAvatar({
    super.key,
    this.image,
    required this.name,
    this.radius = 22,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: AppColors.accent.withAlpha(50),
      backgroundImage: image,
      child: image == null
          ? Text(
              name.isNotEmpty ? name[0].toUpperCase() : '?',
              style: TextStyle(
                color: AppColors.primary,
                fontSize: radius * 0.8,
                fontWeight: FontWeight.bold,
              ),
            )
          : null,
    );
  }
}

/// Átomo: Texto de información
class InfoText extends StatelessWidget {
  final String text;
  final bool isPrimary;
  final double? fontSize;

  const InfoText({
    super.key,
    required this.text,
    this.isPrimary = true,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: isPrimary ? AppColors.textPrimary : AppColors.textSecondary,
        fontWeight: isPrimary ? FontWeight.w500 : FontWeight.normal,
        fontSize: fontSize ?? (isPrimary ? 15 : 13),
      ),
      overflow: TextOverflow.ellipsis,
    );
  }
}

/// Átomo: Botón FAB personalizado
class CustomFab extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final String? heroTag;
  final Color? backgroundColor;

  const CustomFab({
    super.key,
    required this.icon,
    required this.onPressed,
    this.heroTag,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: heroTag,
      onPressed: onPressed,
      backgroundColor: backgroundColor ?? AppColors.accent,
      child: Icon(icon, color: Colors.white),
    );
  }
}

/// Átomo: Botón del dial pad
class DialPadButton extends StatelessWidget {
  final String digit;
  final VoidCallback onTap;
  final double size;

  const DialPadButton({
    super.key,
    required this.digit,
    required this.onTap,
    this.size = 60,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(size / 2),
        child: Container(
          width: size,
          height: size,
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
