import 'package:flutter/material.dart';

class AppThemeData {
  final ThemeMode mode;
  final String label;
  final IconData icon;
  final String description;

  const AppThemeData({
    required this.mode,
    required this.label,
    required this.icon,
    required this.description,
  });
}
