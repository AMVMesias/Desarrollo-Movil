import 'package:flutter/material.dart';

class CampoTexto extends StatelessWidget {
  final String etiqueta;
  final TextEditingController? controlador;
  const CampoTexto({Key? key, required this.etiqueta, this.controlador}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controlador,
      decoration: InputDecoration(labelText: etiqueta),
    );
  }
}
