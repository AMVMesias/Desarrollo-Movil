import 'package:flutter/material.dart';
import 'esquema_color.dart';

// Define el estilo de los campos de texto (TextField)
class TemaFormulario{
  static final campoTexto = InputDecorationTheme(
    filled: true,
    fillColor: ColorApp.secundario,
    labelStyle: TextStyle(
      color: ColorApp.textoClaro,
    ),
    prefixIconColor: ColorApp.exito,

    // Borde cuando el campo no está seleccionado
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: ColorApp.acento,
        width: 2
      ),
      borderRadius: BorderRadius.circular(30),
    ),

    // Borde cuando el campo está seleccionado
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
          color: ColorApp.exito,
          width: 2
      ),
      borderRadius: BorderRadius.circular(30),
    ),
  );
}
