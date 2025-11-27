import 'package:flutter/material.dart';
import 'esquema_color.dart';

// Define el estilo de los campos de texto (TextField)
class TemaFormulario{
  static final campoTexto = InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    labelStyle: TextStyle(
      color: ColorApp.textoOscuro,
    ),
    prefixIconColor: ColorApp.primaio,

    // Borde cuando el campo no está seleccionado
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: ColorApp.primaio,
        width: 2
      ),
      borderRadius: BorderRadius.circular(30),
    ),

    // Borde cuando el campo está seleccionado
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
          color: ColorApp.acento,
          width: 2
      ),
      borderRadius: BorderRadius.circular(30),
    ),
  );
}
