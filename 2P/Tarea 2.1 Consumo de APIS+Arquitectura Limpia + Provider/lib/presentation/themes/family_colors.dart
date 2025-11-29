import 'package:flutter/material.dart';
import 'app_theme.dart';

/// Colores específicos para cada familia de Game of Thrones
class FamilyColors {
  // Casas principales
  static const Color stark = Color(0xFF607D8B);          // Gris acero (Invierno se acerca)
  static const Color lannister = Color(0xFFD4AF37);      // Dorado (Escucha mi rugido)
  static const Color targaryen = Color(0xFFE94560);      // Rojo dragón (Fuego y Sangre)
  static const Color baratheon = Color(0xFFFFD700);      // Amarillo dorado (Nuestra es la furia)
  static const Color greyjoy = Color(0xFF37474F);        // Gris oscuro (Nosotros no sembramos)
  static const Color tyrell = Color(0xFF4CAF50);         // Verde (Crecer fuerte)
  static const Color martell = Color(0xFFFF9800);        // Naranja (Nunca doblegado, nunca roto)
  static const Color tully = Color(0xFF2196F3);          // Azul (Familia, Deber, Honor)
  static const Color arryn = Color(0xFF03A9F4);          // Azul cielo (Tan alto como el honor)
  static const Color bolton = Color(0xFFD32F2F);         // Rojo sangre (Nuestras hojas están afiladas)
  static const Color frey = Color(0xFF795548);           // Marrón (Nosotros aguantamos)

  /// Obtiene el color de una familia basándose en su nombre
  static Color getColorByFamily(String family) {
    final familyLower = family.toLowerCase();

    if (familyLower.contains('stark')) return stark;
    if (familyLower.contains('lannister')) return lannister;
    if (familyLower.contains('targaryen')) return targaryen;
    if (familyLower.contains('baratheon')) return baratheon;
    if (familyLower.contains('greyjoy')) return greyjoy;
    if (familyLower.contains('tyrell')) return tyrell;
    if (familyLower.contains('martell')) return martell;
    if (familyLower.contains('tully')) return tully;
    if (familyLower.contains('arryn')) return arryn;
    if (familyLower.contains('bolton')) return bolton;
    if (familyLower.contains('frey')) return frey;

    // Color por defecto si no se reconoce la familia
    return AppTheme.accentColor;
  }

  /// Mapa de todas las familias y sus colores
  static Map<String, Color> get familyMap => {
    'Stark': stark,
    'Lannister': lannister,
    'Targaryen': targaryen,
    'Baratheon': baratheon,
    'Greyjoy': greyjoy,
    'Tyrell': tyrell,
    'Martell': martell,
    'Tully': tully,
    'Arryn': arryn,
    'Bolton': bolton,
    'Frey': frey,
  };
}

