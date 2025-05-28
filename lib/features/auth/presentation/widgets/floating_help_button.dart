import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FloatingHelpButton extends StatefulWidget {
  final ColorScheme colorScheme;

  const FloatingHelpButton({super.key, required this.colorScheme});

  @override
  State<FloatingHelpButton> createState() => _FloatingHelpButtonState();
}

class _FloatingHelpButtonState extends State<FloatingHelpButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: 200.ms,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _hovered
              ? widget.colorScheme.primaryContainer
              : widget.colorScheme.surface,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: widget.colorScheme.shadow..withValues(alpha: 0.2),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: FaIcon(
          FontAwesomeIcons.circleQuestion,
          color: _hovered
              ? widget.colorScheme.onPrimaryContainer
              : widget.colorScheme.onSurface,
          size: 20,
        ),
      ),
    );
  }
}
