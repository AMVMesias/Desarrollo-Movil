import 'package:flutter/material.dart';
import 'esquema_color.dart';

// Define el estilo del AppBar (barra superior)
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
