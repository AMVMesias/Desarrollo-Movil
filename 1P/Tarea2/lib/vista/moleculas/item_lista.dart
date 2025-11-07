import 'package:flutter/material.dart';
import '../../temas/esquema_color.dart';

/// Molécula: Item de lista para experiencia o educación
class ItemLista extends StatelessWidget {
  final String titulo;
  final String subtitulo;
  final String periodo;
  final String? descripcion;
  final IconData icono;

  const ItemLista({
    Key? key,
    required this.titulo,
    required this.subtitulo,
    required this.periodo,
    this.descripcion,
    required this.icono,
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: ColorApp.secundario.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icono,
              color: ColorApp.secundario,
              size: 20,
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
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: ColorApp.textoOscuro,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitulo,
                  style: TextStyle(
                    fontSize: 14,
                    color: ColorApp.textoOscuro.withOpacity(0.7),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  periodo,
                  style: TextStyle(
                    fontSize: 12,
                    color: ColorApp.textoOscuro.withOpacity(0.5),
                  ),
                ),
                if (descripcion != null && descripcion!.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Text(
                    descripcion!,
                    style: TextStyle(
                      fontSize: 13,
                      color: ColorApp.textoOscuro.withOpacity(0.7),
                      height: 1.4,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
