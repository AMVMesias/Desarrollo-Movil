import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../temas/esquema_color.dart';

/// Átomo: Campo de texto numérico
class CampoNumerico extends StatelessWidget {
  final String etiqueta;
  final TextEditingController? controlador;
  final String? pista;
  final IconData? icono;

  const CampoNumerico({
    Key? key,
    required this.etiqueta,
    this.controlador,
    this.pista,
    this.icono,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controlador,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      decoration: InputDecoration(
        labelText: etiqueta,
        hintText: pista,
        prefixIcon: Icon(icono ?? Icons.numbers, color: ColorApp.primario),
      ),
    );
  }
}
