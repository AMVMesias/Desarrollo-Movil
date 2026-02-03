import 'package:flutter/material.dart';
import '../../temas/esquema_color.dart';

/// Átomo: Botón secundario (outline)
class BotonSecundario extends StatelessWidget {
  final String etiqueta;
  final VoidCallback? onPressed;
  final IconData? icono;

  const BotonSecundario({
    Key? key,
    required this.etiqueta,
    this.onPressed,
    this.icono,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: onPressed,
        icon: Icon(icono ?? Icons.refresh),
        label: Text(etiqueta),
        style: OutlinedButton.styleFrom(
          foregroundColor: ColorApp.primario,
          side: const BorderSide(color: ColorApp.primario, width: 2),
          padding: const EdgeInsets.symmetric(vertical: 14),
        ),
      ),
    );
  }
}
