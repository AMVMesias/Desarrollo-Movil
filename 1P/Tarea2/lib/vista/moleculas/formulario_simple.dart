import 'package:flutter/material.dart';
import '../atomos/campo_texto.dart';
import '../atomos/boton_primario.dart';
import '../atomos/boton_secundario.dart';

class FormularioSimple extends StatelessWidget {
  const FormularioSimple({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: 30),
        CampoTexto(etiqueta: 'Usuario'),
        SizedBox(height: 20),
        CampoTexto(etiqueta: 'Contraseña'),
        SizedBox(height: 20),
  BotonPrimario(etiqueta: 'Ingresar', onPressed: () {}),
        SizedBox(height: 10),
  BotonSecundario(etiqueta: 'Ver todos', onPressed: () {}),
      ],
    );
  }
}

