import 'package:flutter/material.dart';
import 'esquema_color.dart';

// Define los estilos de texto para toda la aplicación
class TipografiaApp {
  static const TextTheme texto = TextTheme(
      displayLarge: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: ColorApp.textoOscuro),
      headlineMedium: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: ColorApp.textoOscuro),
      titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.normal, color: ColorApp.textoOscuro),
      bodyMedium: TextStyle(fontSize: 16, color: ColorApp.textoOscuro),
      labelLarge: TextStyle( fontSize: 14, fontWeight: FontWeight.w500, color: ColorApp.textoOscuro)
  );
}
