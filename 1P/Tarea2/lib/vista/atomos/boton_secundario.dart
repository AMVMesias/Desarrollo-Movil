import 'package:flutter/material.dart';

class BotonSecundario extends StatelessWidget {
  final String etiqueta;
  final VoidCallback? onPressed;
  const BotonSecundario({Key? key, required this.etiqueta, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      child: Text(etiqueta),
    );
  }
}
