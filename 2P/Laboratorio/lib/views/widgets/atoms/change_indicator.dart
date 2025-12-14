import 'package:flutter/material.dart';
import '../../../themes/color_scheme.dart';

/// Atom: Price change indicator (up/down)
/// Shows change with arrow and appropriate color
class ChangeIndicator extends StatelessWidget {
  final double change;
  final double changePercent;
  final bool showPercent;
  final bool compact;

  const ChangeIndicator({
    super.key,
    required this.change,
    required this.changePercent,
    this.showPercent = true,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    final isPositive = change >= 0;
    final color = change == 0 
        ? AppColors.neutral 
        : (isPositive ? AppColors.gain : AppColors.loss);
    final icon = change == 0 
        ? Icons.remove 
        : (isPositive ? Icons.arrow_upward : Icons.arrow_downward);

    final changeText = isPositive 
        ? '+${change.toStringAsFixed(2)}' 
        : change.toStringAsFixed(2);
    final percentText = isPositive 
        ? '+${changePercent.toStringAsFixed(2)}%' 
        : '${changePercent.toStringAsFixed(2)}%';

    if (compact) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: color.withOpacity(0.15),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 14, color: color),
            const SizedBox(width: 2),
            Text(
              percentText,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: color),
          const SizedBox(width: 4),
          Text(
            changeText,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          if (showPercent) ...[
            const SizedBox(width: 6),
            Text(
              '($percentText)',
              style: TextStyle(
                color: color.withOpacity(0.8),
                fontSize: 12,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
