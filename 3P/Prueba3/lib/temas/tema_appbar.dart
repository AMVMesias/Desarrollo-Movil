import 'package:flutter/material.dart';
import 'esquema_color.dart';

/// Tema del AppBar
class TemaAppBar {
  static const AppBarTheme estilo = AppBarTheme(
    backgroundColor: ColorApp.primario,
    foregroundColor: ColorApp.textoClaro,
    elevation: 2,
    centerTitle: true,
    titleTextStyle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: ColorApp.textoClaro,
    ),
  );
}
