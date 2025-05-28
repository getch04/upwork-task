import 'package:flutter/material.dart';
import 'package:upwork_task/core/constants/app_strings.dart';
import 'package:upwork_task/features/settings/domain/models/app_theme_data.dart';

class ThemeConstants {
  static const List<AppThemeData> themes = [
    AppThemeData(
      mode: ThemeMode.system,
      label: AppStrings.system,
      icon: Icons.brightness_auto,
      description: AppStrings.followSystemTheme,
    ),
    AppThemeData(
      mode: ThemeMode.light,
      label: AppStrings.light,
      icon: Icons.light_mode,
      description: AppStrings.lightColorScheme,
    ),
    AppThemeData(
      mode: ThemeMode.dark,
      label: AppStrings.dark,
      icon: Icons.dark_mode,
      description: AppStrings.darkColorScheme,
    ),
  ];
}
