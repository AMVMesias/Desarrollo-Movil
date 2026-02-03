import 'package:flutter/material.dart';

/// Átomo: Botón primario
class BotonPrimario extends StatelessWidget {
  final String etiqueta;
  final VoidCallback? onPressed;
  final IconData? icono;

  const BotonPrimario({
    Key? key,
    required this.etiqueta,
    this.onPressed,
    this.icono,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icono ?? Icons.check),
        label: Text(etiqueta),
      ),
    );
  }
}
