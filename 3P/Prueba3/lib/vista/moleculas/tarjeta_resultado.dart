import 'package:flutter/material.dart';
import '../../temas/esquema_color.dart';

/// Molécula: Tarjeta de resultado
class TarjetaResultado extends StatelessWidget {
  final String titulo;
  final String valor;
  final IconData icono;
  final Color? colorFondo;

  const TarjetaResultado({
    Key? key,
    required this.titulo,
    required this.valor,
    required this.icono,
    this.colorFondo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: colorFondo ?? Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: ColorApp.acento.withOpacity(0.3),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icono, color: ColorApp.primario, size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    titulo,
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    valor,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: ColorApp.primario,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
