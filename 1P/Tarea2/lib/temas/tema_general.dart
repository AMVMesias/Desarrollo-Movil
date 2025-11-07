import 'package:flutter/material.dart';
import 'esquema_color.dart';
import 'tipografia.dart';
import 'tema_appbar.dart';
import 'tema_formulario.dart';
import 'tema_fondo.dart';
import 'tema_botones.dart';

class TemaGeneral{
  static ThemeData claro = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.light(
      primary: ColorApp.primaio,
      secondary: ColorApp.secundario,
      background: ColorApp.fondo,
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
}