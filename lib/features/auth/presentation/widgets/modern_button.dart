import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class ModernButton extends StatefulWidget {
  final bool isLoading;
  final VoidCallback? onPressed;

  const ModernButton({
    super.key,
    required this.isLoading,
    required this.onPressed,
  });

  @override
  State<ModernButton> createState() => _ModernButtonState();
}

class _ModernButtonState extends State<ModernButton>
    with SingleTickerProviderStateMixin {
  final bool _hovered = false;
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedContainer(
        duration: 200.ms,
        curve: Curves.easeOut,
        height: 56,
        transform:
            Matrix4.identity()..scale(
              _pressed
                  ? 0.95
                  : _hovered
                  ? 1.02
                  : 1.0,
            ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              colorScheme.primary,
              colorScheme.secondary,
              colorScheme.primary,
            ],
            stops: const [0.0, 0.5, 1.0],
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: colorScheme.primary.withValues(
                alpha: _hovered ? 0.3 : 0.2,
              ),
              blurRadius: _hovered ? 16 : 8,
              spreadRadius: _hovered ? 2 : 0,
              offset: const Offset(0, 4),
            ),
            BoxShadow(
              color: Colors.white.withValues(alpha: 0.25),
              blurRadius: 0,
              spreadRadius: 1,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: MaterialButton(
          onPressed: widget.onPressed,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              if (!widget.isLoading && _hovered)
                Positioned.fill(
                  child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.white.withValues(alpha: 0),
                              Colors.white.withValues(alpha: 0.2),
                              Colors.white.withValues(alpha: 0),
                            ],
                            stops: const [0.35, 0.5, 0.65],
                            transform: GradientRotation(pi / 4),
                          ),
                        ),
                      )
                      .animate(onPlay: (controller) => controller.repeat())
                      .shimmer(
                        duration: 2.seconds,
                        color: Colors.white.withValues(alpha: 0.1),
                      ),
                ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child:
                    widget.isLoading
                        ? Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              height: 24,
                              width: 24,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.5,
                                valueColor: AlwaysStoppedAnimation(
                                  colorScheme.onPrimary.withValues(alpha: 0.9),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              'Signing In...',
                              style: GoogleFonts.quicksand(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: colorScheme.onPrimary.withValues(
                                  alpha: 0.9,
                                ),
                              ),
                            ),
                          ],
                        )
                        : Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            FaIcon(
                              FontAwesomeIcons.rightToBracket,
                              size: 16,
                              color: colorScheme.onPrimary,
                            ),
                            const SizedBox(width: 12),
                            Text(
                              'Sign In',
                              style: GoogleFonts.quicksand(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: colorScheme.onPrimary,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ],
                        ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
