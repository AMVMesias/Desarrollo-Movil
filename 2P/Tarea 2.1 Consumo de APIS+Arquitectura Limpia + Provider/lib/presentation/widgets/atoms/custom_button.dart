import 'package:flutter/material.dart';
import '../../themes/app_theme.dart';

/// ATOM: Botón personalizado con gradiente
class CustomButton extends StatelessWidget {
  final String? text;
  final IconData? icon;
  final VoidCallback? onPressed;
  final bool isEnabled;
  final ButtonType type;
  final double? width;
  final double height;

  const CustomButton({
    super.key,
    this.text,
    this.icon,
    this.onPressed,
    this.isEnabled = true,
    this.type = ButtonType.primary,
    this.width,
    this.height = 44,
  });

  @override
  Widget build(BuildContext context) {
    final isDisabled = !isEnabled || onPressed == null;
    
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: width,
      height: height,
      decoration: BoxDecoration(
        gradient: isDisabled ? null : _getGradient(),
        color: isDisabled ? AppTheme.dividerColor : null,
        borderRadius: AppTheme.smallRadius,
        boxShadow: isDisabled ? null : [
          BoxShadow(
            color: _getShadowColor().withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isDisabled ? null : onPressed,
          borderRadius: AppTheme.smallRadius,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null)
                  Icon(
                    icon,
                    size: 20,
                    color: isDisabled 
                        ? AppTheme.textSecondary 
                        : Colors.white,
                  ),
                if (icon != null && text != null) 
                  const SizedBox(width: 8),
                if (text != null)
                  Text(
                    text!,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: isDisabled 
                          ? AppTheme.textSecondary 
                          : Colors.white,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  LinearGradient _getGradient() {
    switch (type) {
      case ButtonType.primary:
        return AppTheme.accentGradient;
      case ButtonType.secondary:
        return const LinearGradient(
          colors: [AppTheme.goldColor, Color(0xFFB8962E)],
        );
      case ButtonType.outline:
        return LinearGradient(
          colors: [
            AppTheme.surfaceColor.withOpacity(0.5),
            AppTheme.surfaceColor.withOpacity(0.3),
          ],
        );
    }
  }

  Color _getShadowColor() {
    switch (type) {
      case ButtonType.primary:
        return AppTheme.accentColor;
      case ButtonType.secondary:
        return AppTheme.goldColor;
      case ButtonType.outline:
        return Colors.transparent;
    }
  }
}

enum ButtonType {
  primary,
  secondary,
  outline,
}
