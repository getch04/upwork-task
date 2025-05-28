import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

/// A section in the settings screen that groups related settings together.
/// Displays a title and a container with a list of settings tiles.
/// Includes animation effects for a smooth appearance.
class SettingsSection extends StatelessWidget {
  final String title;
  final List<Widget> children;
  final Duration delay;

  const SettingsSection({
    super.key,
    required this.title,
    required this.children,
    required this.delay,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section title
        Text(
          title,
          style: textTheme.titleMedium?.copyWith(
            color: colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        // Container for settings tiles with shadow and rounded corners
        Container(
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: colorScheme.shadow.withOpacity(0.08),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            children: children,
          ),
        ),
      ],
    ).animate(delay: delay).fadeIn(duration: 300.ms).slideY(
          begin: 0.1,
          end: 0,
          duration: 400.ms,
          curve: Curves.easeOutCubic,
        );
  }
}
