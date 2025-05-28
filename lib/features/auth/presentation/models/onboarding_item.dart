import 'package:flutter/material.dart';

import '../widgets/illustrations/welcome_illustration.dart';

class OnboardingItem {
  final String title;
  final String subtitle;
  final String description;
  final Color backgroundColor;
  final Color textColor;
  final Widget Function(Color color) illustrationBuilder;

  const OnboardingItem({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.backgroundColor,
    required this.textColor,
    required this.illustrationBuilder,
  });

  static const _backgroundColor = Color(
    0xFFE8F3E9,
  ); // Mint/sage green background
  static const _textColor = Color(0xFF1A1D1F); // Dark text color

  static final item = OnboardingItem(
    title: 'Say hi to',
    subtitle: 'your self-',
    description: 'Feel better, sleep better, and all in one app Zest.',
    backgroundColor: _backgroundColor,
    textColor: _textColor,
    illustrationBuilder: (color) => WelcomeIllustration(color: color),
  );
}
