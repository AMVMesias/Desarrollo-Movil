import 'package:flutter/material.dart';
import 'esquema_color.dart';

class TemaBotones{
  static final botonPrincipal = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: ColorApp.primaio,
      foregroundColor: ColorApp.textoClaro,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),

      ),
  );

  static final botonSecundario = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      backgroundColor: Colors.white,
      foregroundColor: ColorApp.primaio,
      padding: EdgeInsets.symmetric(horizontal: 28, vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      side: BorderSide(
        color: ColorApp.primaio,
      ),

    ),
  );

}