import 'package:flutter/material.dart';

class ResultadoView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final resultado = ModalRoute.of(context)!.settings.arguments.toString();
    return Scaffold(
      appBar: AppBar(
        title: Text("Resultado"),
      ),
      body: Center(
        child: Text(
          resultado,
          style: TextStyle(fontSize: 24),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
