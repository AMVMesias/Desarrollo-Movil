import 'package:flutter/material.dart';
import 'esquema_color.dart';
import 'tipografia.dart';
import 'tema_appbar.dart';
import 'tema_formulario.dart';
import 'tema_botones.dart';

// Tema general que combina todos los sub-temas
// Este es el tema que se usa en MaterialApp
class TemaGeneral {
  static ThemeData claro = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.light(
        primary: ColorApp.primaio,
        secondary: ColorApp.secundario,
        surface: ColorApp.fondo,
        onPrimary: ColorApp.textoClaro,
        onSecondary: Colors.white,
      ),
      textTheme: TipografiaApp.texto,
      appBarTheme: TemaAppBar.estilo,
      elevatedButtonTheme: TemaBotones.botonPrincipal,
      outlinedButtonTheme: TemaBotones.botonSecundario,
      inputDecorationTheme: TemaFormulario.campoTexto,
      scaffoldBackgroundColor: ColorApp.fondo
  );

  // Tema oscuro equivalente al tema claro
  static ThemeData oscuro = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      primary: ColorApp.primaio,
      secondary: ColorApp.secundario,
      surface: const Color(0xFF121212),
      onPrimary: ColorApp.textoClaro,
      onSecondary: ColorApp.textoClaro,
    ),
    textTheme: TipografiaApp.texto.apply(
      bodyColor: ColorApp.textoClaro,
      displayColor: ColorApp.textoClaro,
    ),
    appBarTheme: TemaAppBar.estilo.copyWith(
      backgroundColor: ColorApp.primaio,
      foregroundColor: ColorApp.textoClaro,
    ),
    elevatedButtonTheme: TemaBotones.botonPrincipal,
    outlinedButtonTheme: TemaBotones.botonSecundario,
    inputDecorationTheme: TemaFormulario.campoTexto.copyWith(
      filled: true,
      fillColor: Colors.grey[850],
      labelStyle: const TextStyle(color: ColorApp.textoClaro),
      prefixIconColor: ColorApp.primaio,
    ),
    scaffoldBackgroundColor: const Color(0xFF121212),
  );

}
