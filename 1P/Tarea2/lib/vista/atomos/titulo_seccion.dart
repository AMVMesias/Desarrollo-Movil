import 'package:flutter/material.dart';
import '../../temas/esquema_color.dart';

/// Átomo: Texto de título de sección
class TituloSeccion extends StatelessWidget {
  final String texto;
  final IconData? icono;

  const TituloSeccion({
    Key? key,
    required this.texto,
    this.icono,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (icono != null) ...[
          Icon(
            icono,
            color: ColorApp.primaio,
            size: 24,
          ),
          const SizedBox(width: 8),
        ],
        Text(
          texto,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: ColorApp.textoOscuro,
          ),
        ),
      ],
    );
  }
}
