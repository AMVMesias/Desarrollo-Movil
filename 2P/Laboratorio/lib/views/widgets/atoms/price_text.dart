import 'package:flutter/material.dart';
import '../../../themes/color_scheme.dart';

/// Atom: Price text with monetary format
/// Basic reusable component for displaying prices
class PriceText extends StatelessWidget {
  final double price;
  final TextStyle? style;
  final String currency;

  const PriceText({
    super.key,
    required this.price,
    this.style,
    this.currency = '\$',
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      '$currency${price.toStringAsFixed(2)}',
      style: style ?? Theme.of(context).textTheme.headlineMedium?.copyWith(
        fontWeight: FontWeight.bold,
        color: AppColors.textDark,
      ),
    );
  }
}
