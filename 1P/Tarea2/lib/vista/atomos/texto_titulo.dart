import 'package:flutter/material.dart';

class TextoTitulo extends StatelessWidget {
  final String texto;
  const TextoTitulo(this.texto, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      texto,
      style: Theme.of(context).textTheme.headlineMedium,
      textAlign: TextAlign.center,
    );
  }
}
