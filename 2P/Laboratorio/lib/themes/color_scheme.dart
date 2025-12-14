import 'package:flutter/material.dart';

/// Application color scheme for stock market app
/// Premium financial palette with green/red indicators
class AppColors {
  // Primary colors
  static const Color primary = Color(0xFF1E3A5F);      // Navy blue - Trust
  static const Color secondary = Color(0xFF0D47A1);    // Deep blue
  static const Color accent = Color(0xFFF5A623);        // Gold - Prosperity
  
  // Market indicators
  static const Color gain = Color(0xFF00C853);          // Bright green - Up
  static const Color loss = Color(0xFFFF5252);          // Red - Down
  static const Color neutral = Color(0xFF9E9E9E);       // Gray - No change
  
  // Backgrounds - Light mode
  static const Color backgroundLight = Color(0xFFF8FAFC);
  static const Color backgroundDark = Color(0xFF0D1B2A);
  static const Color card = Color(0xFFFFFFFF);
  static const Color cardDark = Color(0xFF1A2D42);
  
  // Surfaces
  static const Color surface = Color(0xFFF1F5F9);
  static const Color surfaceDark = Color(0xFF1A2D42);
  
  // Text
  static const Color textDark = Color(0xFF1A1A2E);
  static const Color textLight = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFF6B7280);
  
  // Gradients
  static const List<Color> gainGradient = [
    Color(0xFF00C853),
    Color(0xFF69F0AE),
  ];
  
  static const List<Color> lossGradient = [
    Color(0xFFFF5252),
    Color(0xFFFF8A80),
  ];
  
  static const List<Color> primaryGradient = [
    Color(0xFF1E3A5F),
    Color(0xFF3D5A80),
  ];

  // Hero gradient for featured cards
  static const List<Color> heroGradient = [
    Color(0xFF1E3A5F),
    Color(0xFF3D5A80),
    Color(0xFF5C7A99),
  ];
}

