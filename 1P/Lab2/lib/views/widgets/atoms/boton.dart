import 'package:flutter/material.dart';

/// Átomo: Botón con opción de ancho completo
class Boton extends StatelessWidget {
  final String texto;
  final VoidCallback? onPressed;
  final bool expanded;
  final ButtonStyle? style;

  const Boton({
    super.key,
    required this.texto,
    this.onPressed,
    this.expanded = false,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    final button = ElevatedButton(
      onPressed: onPressed,
      style: style,
      child: Text(texto),
    );

    if (expanded) {
      return SizedBox(width: double.infinity, child: button);
    }

    return button;
  }
}
