import 'package:flutter/material.dart';
import '../../temas/esquema_color.dart';

/// Molécula: Tarjeta de información con icono
class InfoCard extends StatelessWidget {
  final IconData icono;
  final String titulo;
  final String valor;

  const InfoCard({
    Key? key,
    required this.icono,
    required this.titulo,
    required this.valor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ColorApp.fondo,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: ColorApp.secundario.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: ColorApp.primaio.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icono,
              color: ColorApp.primaio,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titulo,
                  style: TextStyle(
                    fontSize: 12,
                    color: ColorApp.textoOscuro.withOpacity(0.6),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  valor,
                  style: TextStyle(
                    fontSize: 15,
                    color: ColorApp.textoOscuro,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
