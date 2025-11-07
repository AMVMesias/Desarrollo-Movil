import 'package:flutter/material.dart';

class BotonPrimario extends StatelessWidget {
  final String etiqueta;
  final VoidCallback? onPressed;
  const BotonPrimario({Key? key, required this.etiqueta, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(etiqueta),
    );
  }
}
