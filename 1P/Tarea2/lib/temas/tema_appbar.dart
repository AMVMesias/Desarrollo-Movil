import 'package:flutter/material.dart';
import 'esquema_color.dart';

class TemaAppBar {
  static const AppBarTheme estilo = AppBarTheme(
    backgroundColor: ColorApp.primaio,
    foregroundColor: ColorApp.textoClaro,
    centerTitle: true,
    elevation: 3,
    titleTextStyle: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 20,
      color: ColorApp.textoClaro,

    ),

  );
}