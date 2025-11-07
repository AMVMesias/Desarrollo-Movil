import 'package:flutter/material.dart';
import 'esquema_color.dart';

class TemaFormulario{
  static final campoTexto = InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    labelStyle: TextStyle(
      color: ColorApp.textoOscuro,
      //fontWeight: FontWeight.w500,
    ),
    prefixIconColor: ColorApp.primaio,

    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: ColorApp.primaio,
        width: 2
      ),
      borderRadius: BorderRadius.circular(30),

    ),

    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
          color: ColorApp.acento,
          width: 2
      ),
      borderRadius: BorderRadius.circular(30),

    ),
  );
}