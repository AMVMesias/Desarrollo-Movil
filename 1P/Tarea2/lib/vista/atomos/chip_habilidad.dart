import 'package:flutter/material.dart';
import '../../temas/esquema_color.dart';

/// Átomo: Chip de habilidad
class ChipHabilidad extends StatelessWidget {
  final String texto;

  const ChipHabilidad({
    Key? key,
    required this.texto,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: ColorApp.primaio.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: ColorApp.primaio.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Text(
        texto,
        style: TextStyle(
          color: ColorApp.primaio,
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
