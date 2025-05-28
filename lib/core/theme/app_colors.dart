import 'package:flutter/material.dart';

class AppColors {
  // Primary colors
  static const Color primary = Color(0xFF6366F1);
  static const Color primaryContainer = Color(0xFF4F46E5);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color onPrimaryContainer = Color(0xFFE0E7FF);

  // Secondary colors
  static const Color secondary = Color(0xFF14B8A6);
  static const Color secondaryContainer = Color(0xFF0D9488);
  static const Color onSecondary = Color(0xFFFFFFFF);
  static const Color onSecondaryContainer = Color(0xFFCCFBF1);

  // Tertiary colors
  static const Color tertiary = Color(0xFFF59E0B);
  static const Color tertiaryContainer = Color(0xFFD97706);
  static const Color onTertiary = Color(0xFFFFFFFF);
  static const Color onTertiaryContainer = Color(0xFFFEF3C7);

  // Neutral colors - Light
  static const Color backgroundLight = Color(0xFFF8FAFC);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color surfaceVariantLight = Color(0xFFF1F5F9);

  // Text colors - Light
  static const Color onBackgroundLight = Color(0xFF0F172A);
  static const Color onSurfaceLight = Color(0xFF1E293B);
  static const Color onSurfaceVariantLight = Color(0xFF334155);

  // Neutral colors - Dark
  static const Color backgroundDark = Color(0xFF1A1C1E);
  static const Color surfaceDark = Color(0xFF1C1C1E);
  static const Color surfaceVariantDark = Color(0xFF2C2C2E);

  // Text colors - Dark
  static const Color onBackgroundDark = Color(0xFFE2E8F0);
  static const Color onSurfaceDark = Color(0xFFF8FAFC);
  static const Color onSurfaceVariantDark = Color(0xFFCBD5E1);

  // Error colors
  static const Color error = Color(0xFFEF4444);
  static const Color errorContainer = Color(0xFFDC2626);
  static const Color onError = Color(0xFFFFFFFF);
  static const Color onErrorContainer = Color(0xFFFEE2E2);

  // Additional colors - Light
  static const Color outlineLight = Color(0xFFCBD5E1);
  static const Color outlineVariantLight = Color(0xFFE2E8F0);
  static const Color shadowLight = Color(0x1E293B40);
  static const Color scrimLight = Color(0x99000000);

  // Additional colors - Dark
  static const Color outlineDark = Color(0xFF475569);
  static const Color outlineVariantDark = Color(0xFF334155);
  static const Color shadowDark = Color(0x3D000000);
  static const Color scrimDark = Color(0x99000000);

  // Gradient colors
  static const List<Color> primaryGradient = [
    Color(0xFF6366F1),
    Color(0xFF4F46E5),
    Color(0xFF4338CA),
  ];

  static const List<Color> surfaceGradient = [
    Color(0xFFFFFFFF),
    Color(0xFFF8FAFC),
    Color(0xFFF1F5F9),
  ];

  static ColorScheme get lightColorScheme {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: primary,
      onPrimary: onPrimary,
      primaryContainer: primaryContainer,
      onPrimaryContainer: onPrimaryContainer,
      secondary: secondary,
      onSecondary: onSecondary,
      secondaryContainer: secondaryContainer,
      onSecondaryContainer: onSecondaryContainer,
      tertiary: tertiary,
      onTertiary: onTertiary,
      tertiaryContainer: tertiaryContainer,
      onTertiaryContainer: onTertiaryContainer,
      error: error,
      onError: onError,
      errorContainer: errorContainer,
      onErrorContainer: onErrorContainer,
      surface: surfaceLight,
      onSurface: onSurfaceLight,
      onSurfaceVariant: onSurfaceVariantLight,
      outline: outlineLight,
      outlineVariant: outlineVariantLight,
      shadow: shadowLight,
      scrim: scrimLight,
      surfaceContainerHighest: surfaceVariantLight,
    );
  }

  static ColorScheme get darkColorScheme {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: primary,
      onPrimary: onPrimary,
      primaryContainer: primaryContainer,
      onPrimaryContainer: onPrimaryContainer,
      secondary: secondary,
      onSecondary: onSecondary,
      secondaryContainer: secondaryContainer,
      onSecondaryContainer: onSecondaryContainer,
      tertiary: tertiary,
      onTertiary: onTertiary,
      tertiaryContainer: tertiaryContainer,
      onTertiaryContainer: onTertiaryContainer,
      error: error,
      onError: onError,
      errorContainer: errorContainer,
      onErrorContainer: onErrorContainer,
      surface: surfaceDark,
      onSurface: onSurfaceDark,
      onSurfaceVariant: onSurfaceVariantDark,
      outline: outlineDark,
      outlineVariant: outlineVariantDark,
      shadow: shadowDark,
      scrim: scrimDark,
      surfaceContainerHighest: surfaceVariantDark,
    );
  }
}
