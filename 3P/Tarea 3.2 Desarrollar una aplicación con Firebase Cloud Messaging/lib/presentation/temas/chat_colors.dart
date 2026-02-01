import 'package:flutter/material.dart';

class ChatColors {
  // Colores principales del tema verde minimalista
  static const Color primaryGreen = Color(0xFF25D366); // Verde WhatsApp
  static const Color lightGreen = Color(0xFF34C759); // Verde más claro
  static const Color darkGreen = Color(0xFF128C7E); // Verde oscuro

  // Colores de fondo
  static const Color backgroundColor = Color(0xFFF0F2F5); // Gris muy claro
  static const Color chatBackground = Color(0xFFE5DDD5); // Fondo tipo WhatsApp

  // Colores de mensajes
  static const Color myMessageColor = Color(0xFFDCF8C6); // Verde claro para mis mensajes
  static const Color otherMessageColor = Color(0xFFFFFFFF); // Blanco para otros mensajes

  // Colores de texto
  static const Color primaryText = Color(0xFF1F2937); // Gris oscuro
  static const Color secondaryText = Color(0xFF6B7280); // Gris medio
  static const Color whiteText = Color(0xFFFFFFFF); // Blanco

  // Colores de acentos
  static const Color shadowColor = Color(0x1A000000); // Sombra suave
  static const Color borderColor = Color(0xFFE5E7EB); // Borde claro
}

class ChatTheme {
  static ThemeData get theme => ThemeData(
        primarySwatch: Colors.green,
        primaryColor: ChatColors.primaryGreen,
        scaffoldBackgroundColor: ChatColors.backgroundColor,
        appBarTheme: const AppBarTheme(
          backgroundColor: ChatColors.darkGreen,
          foregroundColor: ChatColors.whiteText,
          elevation: 2,
          titleTextStyle: TextStyle(
            color: ChatColors.whiteText,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(
            color: ChatColors.primaryText,
            fontSize: 16,
          ),
          bodyMedium: TextStyle(
            color: ChatColors.secondaryText,
            fontSize: 14,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: ChatColors.primaryGreen,
            foregroundColor: ChatColors.whiteText,
          ),
        ),
      );
}
