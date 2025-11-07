import 'package:flutter/material.dart';
import '../atomos/texto_titulo.dart';
import '../moleculas/formulario_simple.dart';

class PaginaInicio extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mi Tema'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 20),
            TextoTitulo('Bienvenido'),
            SizedBox(height: 30),

            FormularioSimple(),

          ],
        ),
      ),
    );
  }
}
