import 'package:flutter/material.dart';
import 'esquema_color.dart';

/// Tema de los campos de formulario
class TemaFormulario {
  static InputDecorationTheme campoTexto = InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: ColorApp.primario),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: ColorApp.primario.withOpacity(0.5)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: ColorApp.primario, width: 2),
    ),
    labelStyle: const TextStyle(color: ColorApp.primario),
    prefixIconColor: ColorApp.primario,
  );
}
