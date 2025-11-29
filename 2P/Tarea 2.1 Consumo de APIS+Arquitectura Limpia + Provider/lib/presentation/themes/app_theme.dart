import 'package:flutter/material.dart';

/// Tema principal de la aplicación con estilo Game of Thrones
class AppTheme {
  // Colores principales - Inspirados en Game of Thrones
  static const Color primaryColor = Color(0xFF1A1A2E);      // Azul oscuro profundo
  static const Color secondaryColor = Color(0xFF16213E);    // Azul medianoche
  static const Color accentColor = Color(0xFFE94560);       // Rojo dragón
  static const Color goldColor = Color(0xFFD4AF37);         // Dorado Lannister
  static const Color surfaceColor = Color(0xFF0F3460);      // Azul superficie
  static const Color backgroundColor = Color(0xFF1A1A2E);   // Fondo oscuro
  static const Color cardColor = Color(0xFF16213E);         // Color tarjetas
  static const Color textPrimary = Color(0xFFEAEAEA);       // Texto claro
  static const Color textSecondary = Color(0xFFB0B0B0);     // Texto secundario
  static const Color dividerColor = Color(0xFF2A2A4A);      // Divisores

  // Gradientes
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryColor, secondaryColor],
  );

  static const LinearGradient cardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF1E2A47), Color(0xFF16213E)],
  );

  static const LinearGradient accentGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [accentColor, Color(0xFFB8384E)],
  );

  // Sombras
  static List<BoxShadow> cardShadow = [
    BoxShadow(
      color: Colors.black.withOpacity(0.3),
      blurRadius: 10,
      offset: const Offset(0, 4),
    ),
  ];

  static List<BoxShadow> elevatedShadow = [
    BoxShadow(
      color: accentColor.withOpacity(0.2),
      blurRadius: 15,
      offset: const Offset(0, 5),
    ),
  ];

  // Bordes redondeados
  static BorderRadius smallRadius = BorderRadius.circular(8);
  static BorderRadius mediumRadius = BorderRadius.circular(12);
  static BorderRadius largeRadius = BorderRadius.circular(16);
  static BorderRadius circularRadius = BorderRadius.circular(50);

  // Estilos de texto
  static const TextStyle headingLarge = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: textPrimary,
    letterSpacing: 1.2,
  );

  static const TextStyle headingMedium = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: textPrimary,
  );

  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: textPrimary,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    color: textSecondary,
  );

  static const TextStyle caption = TextStyle(
    fontSize: 12,
    color: textSecondary,
    fontStyle: FontStyle.italic,
  );

  static const TextStyle badge = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  // Tema de la aplicación
  static ThemeData get theme => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: primaryColor,
    scaffoldBackgroundColor: backgroundColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: goldColor,
        letterSpacing: 1.5,
      ),
      iconTheme: IconThemeData(color: goldColor),
    ),
    cardTheme: CardThemeData(
      color: cardColor,
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: mediumRadius),
    ),
    colorScheme: const ColorScheme.dark(
      primary: accentColor,
      secondary: goldColor,
      surface: surfaceColor,
    ),
  );
}

