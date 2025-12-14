import 'package:flutter/material.dart';
import 'color_scheme.dart';
import 'typography.dart';
import 'appbar_theme.dart';
import 'form_theme.dart';
import 'button_theme.dart';

/// General application theme
/// Combines all sub-themes with financial palette
class AppTheme {
  /// Light theme for the app
  static ThemeData light = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.light(
      primary: AppColors.primary,
      secondary: AppColors.accent,
      surface: AppColors.backgroundLight,
      error: AppColors.loss,
      onPrimary: AppColors.textLight,
      onSecondary: AppColors.textDark,
      tertiary: AppColors.gain,
    ),
    textTheme: AppTypography.textTheme,
    appBarTheme: AppBarStyles.style.copyWith(
      backgroundColor: AppColors.primary,
    ),
    elevatedButtonTheme: ButtonStyles.primaryButton,
    outlinedButtonTheme: ButtonStyles.secondaryButton,
    inputDecorationTheme: FormStyles.inputDecoration,
    scaffoldBackgroundColor: AppColors.backgroundLight,
    cardTheme: CardThemeData(
      color: AppColors.card,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.textLight,
    ),
  );

  /// Dark theme for financial market app
  static ThemeData dark = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      primary: AppColors.accent,
      secondary: AppColors.primary,
      surface: AppColors.backgroundDark,
      error: AppColors.loss,
      onPrimary: AppColors.textDark,
      onSecondary: AppColors.textLight,
      tertiary: AppColors.gain,
    ),
    textTheme: AppTypography.textTheme.apply(
      bodyColor: AppColors.textLight,
      displayColor: AppColors.textLight,
    ),
    appBarTheme: AppBarStyles.style.copyWith(
      backgroundColor: AppColors.backgroundDark,
      foregroundColor: AppColors.textLight,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.accent,
        foregroundColor: AppColors.textDark,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    ),
    outlinedButtonTheme: ButtonStyles.secondaryButton,
    inputDecorationTheme: FormStyles.inputDecoration.copyWith(
      filled: true,
      fillColor: AppColors.cardDark,
      labelStyle: const TextStyle(color: AppColors.textLight),
    ),
    scaffoldBackgroundColor: AppColors.backgroundDark,
    cardTheme: CardThemeData(
      color: AppColors.cardDark,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
  );
}
