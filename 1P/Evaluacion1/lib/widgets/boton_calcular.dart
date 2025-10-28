import 'package:flutter/material.dart';

// Átomo
class BotonCalcular extends StatelessWidget {
  final VoidCallback onPressed;

  const BotonCalcular({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text("Calcular"),
    );
  }
}
