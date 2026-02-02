import 'package:flutter/material.dart';

/// Paleta de colores de la aplicación con tonos verdes
class AppColors {
  // Colores primarios
  static const Color primary = Color(0xFF2E7D32);       // Verde oscuro
  static const Color primaryLight = Color(0xFF4CAF50); // Verde medio
  static const Color primaryDark = Color(0xFF1B5E20);  // Verde muy oscuro
  
  // Colores de acento
  static const Color accent = Color(0xFF81C784);       // Verde claro
  static const Color accentLight = Color(0xFFA5D6A7);  // Verde muy claro
  
  // Colores de fondo
  static const Color background = Color(0xFFF5F5F5);   // Gris muy claro
  static const Color surface = Colors.white;
  static const Color cardBackground = Colors.white;
  
  // Colores de texto
  static const Color textPrimary = Color(0xFF212121);   // Casi negro
  static const Color textSecondary = Color(0xFF757575);  // Gris
  static const Color textOnPrimary = Colors.white;
  
  // Colores de estado
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFE53935);
  static const Color warning = Color(0xFFFFA726);
  
  // Colores de iconos
  static const Color iconCall = Color(0xFF4CAF50);     // Verde para llamar
  static const Color iconEmail = Color(0xFF1976D2);    // Azul para email
  static const Color iconEdit = Color(0xFFFFA726);     // Naranja para editar
  static const Color iconDelete = Color(0xFFE53935);   // Rojo para eliminar
  static const Color iconFavorite = Color(0xFFE91E63); // Rosa para favorito
  
  // Colores de navegación
  static const Color navBarBackground = Colors.white;
  static const Color navBarSelected = Color(0xFF2E7D32);
  static const Color navBarUnselected = Color(0xFF9E9E9E);
  
  // Sombras
  static const Color shadow = Color(0x1A000000);
  
  // Bordes
  static const Color border = Color(0xFFE0E0E0);
  static const Color divider = Color(0xFFEEEEEE);
}
