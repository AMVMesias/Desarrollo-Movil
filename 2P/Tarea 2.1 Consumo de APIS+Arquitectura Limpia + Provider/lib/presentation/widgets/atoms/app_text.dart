import 'package:flutter/material.dart';
import '../../themes/app_theme.dart';

/// ATOM: Texto personalizado con diferentes estilos
class AppText extends StatelessWidget {
  final String text;
  final TextType type;
  final Color? color;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextAlign? textAlign;

  const AppText({
    super.key,
    required this.text,
    this.type = TextType.body,
    this.color,
    this.maxLines,
    this.overflow,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: _getStyle().copyWith(color: color),
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign,
    );
  }

  TextStyle _getStyle() {
    switch (type) {
      case TextType.headingLarge:
        return AppTheme.headingLarge;
      case TextType.headingMedium:
        return AppTheme.headingMedium;
      case TextType.bodyLarge:
        return AppTheme.bodyLarge;
      case TextType.body:
        return AppTheme.bodyMedium;
      case TextType.caption:
        return AppTheme.caption;
      case TextType.badge:
        return AppTheme.badge;
    }
  }
}

enum TextType {
  headingLarge,
  headingMedium,
  bodyLarge,
  body,
  caption,
  badge,
}
