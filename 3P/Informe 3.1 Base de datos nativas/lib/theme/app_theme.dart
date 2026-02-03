import 'package:flutter/material.dart';

/// Tema de la aplicación - Tonalidad verde
class AppTheme {
  // Colores principales en tonalidad verde
  static const Color primaryGreen = Color(0xFF2E7D32); // Verde oscuro
  static const Color secondaryGreen = Color(0xFF66BB6A); // Verde medio
  static const Color lightGreen = Color(0xFF81C784); // Verde claro
  static const Color paleGreen = Color(0xFFE8F5E9); // Verde muy claro
  static const Color accentGreen = Color(0xFF4CAF50); // Verde acento
  
  static const Color darkGreen = Color(0xFF1B5E20); // Verde muy oscuro
  static const Color successGreen = Color(0xFF43A047); // Verde éxito
  
  // Colores complementarios
  static const Color errorRed = Color(0xFFD32F2F);
  static const Color warningOrange = Color(0xFFFF6F00);
  static const Color infoBlue = Color(0xFF1976D2);
  
  // Tema principal de la aplicación
  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryGreen,
        primary: primaryGreen,
        secondary: secondaryGreen,
        surface: paleGreen,
      ),
      
      // AppBar
      appBarTheme: const AppBarTheme(
        backgroundColor: primaryGreen,
        foregroundColor: Colors.white,
        elevation: 2,
        centerTitle: true,
      ),
      
      // Botones
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryGreen,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primaryGreen,
          side: const BorderSide(color: primaryGreen, width: 2),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        ),
      ),
      
      // Inputs
      inputDecorationTheme: InputDecorationTheme(
        border: const OutlineInputBorder(),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: primaryGreen, width: 2),
        ),
        labelStyle: const TextStyle(color: primaryGreen),
        floatingLabelStyle: const TextStyle(color: primaryGreen),
      ),
      
      // Cards
      cardTheme: const CardThemeData(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
      ),
      
      // Slider
      sliderTheme: SliderThemeData(
        activeTrackColor: primaryGreen,
        thumbColor: primaryGreen,
        overlayColor: primaryGreen.withValues(alpha: 0.2),
        inactiveTrackColor: lightGreen.withValues(alpha: 0.3),
      ),
      
      // Radio buttons
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return primaryGreen;
          }
          return Colors.grey;
        }),
      ),
    );
  }
}
