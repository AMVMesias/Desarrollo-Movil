import 'package:flutter/material.dart';
import 'esquema_color.dart';

class FondosApp{
  static const BoxDecoration degradoPrincipal = BoxDecoration(
    gradient: LinearGradient(colors: [ColorApp.primaio, ColorApp.secundario],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    ),
  );

  static const BoxDecoration fondoBlanco = BoxDecoration(
    color: Colors.white,
  );
  static const BoxDecoration fondoGris = BoxDecoration(
    color: ColorApp.fondo,
  );
}
