import 'package:flutter/material.dart';

class ActivityData {
  final String title;
  final String value;
  final String subtitle;
  final IconData icon;
  final double progress;
  final Color color;

  const ActivityData({
    required this.title,
    required this.value,
    required this.subtitle,
    required this.icon,
    required this.progress,
    required this.color,
  });
}
