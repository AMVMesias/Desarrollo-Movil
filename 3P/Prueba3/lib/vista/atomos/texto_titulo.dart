import 'package:flutter/material.dart';
import '../../temas/esquema_color.dart';

/// Átomo: Texto título
class TextoTitulo extends StatelessWidget {
  final String texto;
  final TextAlign? alineacion;

  const TextoTitulo(this.texto, {Key? key, this.alineacion}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      texto,
      textAlign: alineacion ?? TextAlign.center,
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: ColorApp.primario,
      ),
    );
  }
}

/// Átomo: Texto subtítulo
class TextoSubtitulo extends StatelessWidget {
  final String texto;
  final TextAlign? alineacion;

  const TextoSubtitulo(this.texto, {Key? key, this.alineacion}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      texto,
      textAlign: alineacion ?? TextAlign.center,
      style: TextStyle(
        fontSize: 16,
        color: Colors.grey[700],
      ),
    );
  }
}
