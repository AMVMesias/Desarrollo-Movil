import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../themes/app_theme.dart';

/// ATOM: Avatar personalizado con imagen de red y estado de carga
class CustomAvatar extends StatelessWidget {
  final String imageUrl;
  final double size;
  final double borderWidth;
  final Color? borderColor;

  const CustomAvatar({
    super.key,
    required this.imageUrl,
    this.size = 60,
    this.borderWidth = 2,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: borderColor ?? AppTheme.goldColor,
          width: borderWidth,
        ),
        boxShadow: [
          BoxShadow(
            color: (borderColor ?? AppTheme.goldColor).withOpacity(0.3),
            blurRadius: 8,
            spreadRadius: 1,
          ),
        ],
      ),
      child: ClipOval(
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          fit: BoxFit.cover,
          placeholder: (context, url) => Container(
            color: AppTheme.surfaceColor,
            child: const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: AppTheme.goldColor,
              ),
            ),
          ),
          errorWidget: (context, url, error) => Container(
            color: AppTheme.surfaceColor,
            child: const Icon(
              Icons.person,
              color: AppTheme.textSecondary,
            ),
          ),
        ),
      ),
    );
  }
}

