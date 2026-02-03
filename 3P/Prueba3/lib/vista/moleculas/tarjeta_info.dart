import 'package:flutter/material.dart';
import '../../temas/esquema_color.dart';

/// Molécula: Tarjeta de información
class TarjetaInfo extends StatelessWidget {
  final String mensaje;
  final IconData icono;
  final Color? colorFondo;

  const TarjetaInfo({
    Key? key,
    required this.mensaje,
    this.icono = Icons.info_outline,
    this.colorFondo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorFondo ?? ColorApp.superficie.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: ColorApp.primario.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(icono, color: ColorApp.primario),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              mensaje,
              style: const TextStyle(fontSize: 14, color: ColorApp.primario),
            ),
          ),
        ],
      ),
    );
  }
}
