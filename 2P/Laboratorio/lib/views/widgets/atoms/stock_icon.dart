import 'package:flutter/material.dart';
import '../../../themes/color_scheme.dart';

/// Atom: Stock icon with symbol or logo
/// Shows company logo if available, otherwise shows symbol letters
class StockIcon extends StatelessWidget {
  final String symbol;
  final String? logoUrl;
  final double size;
  final Color? backgroundColor;

  const StockIcon({
    super.key,
    required this.symbol,
    this.logoUrl,
    this.size = 48,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    // Generate color based on symbol for consistency
    final colors = [
      AppColors.primary,
      AppColors.secondary,
      AppColors.accent,
      const Color(0xFF5C6BC0),
      const Color(0xFF26A69A),
      const Color(0xFFEC407A),
    ];
    final colorIndex = symbol.codeUnits.fold(0, (a, b) => a + b) % colors.length;
    final bgColor = backgroundColor ?? colors[colorIndex];

    // If logo URL is available, show the logo
    if (logoUrl != null && logoUrl!.isNotEmpty) {
      return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(size * 0.25),
          boxShadow: [
            BoxShadow(
              color: bgColor.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(size * 0.25),
          child: Image.network(
            logoUrl!,
            width: size,
            height: size,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return _buildLetterIcon(bgColor);
            },
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return _buildLetterIcon(bgColor);
            },
          ),
        ),
      );
    }

    // Fallback: show symbol letters
    return _buildLetterIcon(bgColor);
  }

  Widget _buildLetterIcon(Color bgColor) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            bgColor,
            bgColor.withOpacity(0.7),
          ],
        ),
        borderRadius: BorderRadius.circular(size * 0.25),
        boxShadow: [
          BoxShadow(
            color: bgColor.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Center(
        child: Text(
          symbol.length > 2 ? symbol.substring(0, 2) : symbol,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: size * 0.35,
          ),
        ),
      ),
    );
  }
}
