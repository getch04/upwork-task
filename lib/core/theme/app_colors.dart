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

  // Neutral colors
  static const Color background = Color(0xFFF8FAFC);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF1F5F9);

  // Text colors
  static const Color onBackground = Color(0xFF0F172A);
  static const Color onSurface = Color(0xFF1E293B);
  static const Color onSurfaceVariant = Color(0xFF334155);

  // Error colors
  static const Color error = Color(0xFFEF4444);
  static const Color errorContainer = Color(0xFFDC2626);
  static const Color onError = Color(0xFFFFFFFF);
  static const Color onErrorContainer = Color(0xFFFEE2E2);

  // Additional colors
  static const Color outline = Color(0xFFCBD5E1);
  static const Color outlineVariant = Color(0xFFE2E8F0);
  static const Color shadow = Color(0x1E293B40);
  static const Color scrim = Color(0x99000000);

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
      surface: surface,
      onSurface: onSurface,
      surfaceContainerHighest: surfaceVariant,
      onSurfaceVariant: onSurfaceVariant,
      outline: outline,
      outlineVariant: outlineVariant,
      shadow: shadow,
      scrim: scrim,
    );
  }
}
