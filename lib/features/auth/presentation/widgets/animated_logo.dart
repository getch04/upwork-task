import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AnimatedLogo extends StatelessWidget {
  final ColorScheme colorScheme;
  final bool isPasswordVisible;
  final bool isPasswordFocused;
  final bool hasPasswordInput;

  const AnimatedLogo({
    super.key,
    required this.colorScheme,
    this.isPasswordVisible = false,
    this.isPasswordFocused = false,
    this.hasPasswordInput = false,
  });

  String get _getEmoji {
    if (!hasPasswordInput && !isPasswordFocused) {
      return '😊'; // Default happy face
    }
    if (isPasswordVisible) {
      return '👀'; // Peeking eyes when password is visible
    }
    return '🫣'; // Peeking through fingers when typing password
  }

  @override
  Widget build(BuildContext context) {
    return Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: colorScheme.onPrimary,
            boxShadow: [
              BoxShadow(
                color: colorScheme.onPrimary.withOpacity(0.2),
                blurRadius: 24,
                spreadRadius: 8,
              ),
            ],
          ),
          child: Center(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) {
                return ScaleTransition(
                  scale: animation,
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0, 0.5),
                      end: Offset.zero,
                    ).animate(
                      CurvedAnimation(
                        parent: animation,
                        curve: Curves.elasticOut,
                      ),
                    ),
                    child: FadeTransition(opacity: animation, child: child),
                  ),
                );
              },
              child: Text(
                _getEmoji,
                key: ValueKey(_getEmoji),
                style: const TextStyle(fontSize: 64),
              ),
            ),
          ),
        )
        .animate()
        .scale(
          begin: const Offset(0.8, 0.8),
          end: const Offset(1.0, 1.0),
          curve: Curves.elasticOut,
          duration: 1.seconds,
        )
        .shimmer(
          duration: 2.seconds,
          color: colorScheme.onPrimary.withOpacity(0.2),
        )
        .animate(
          onPlay: (controller) => controller.repeat(reverse: true),
          target: hasPasswordInput || isPasswordFocused ? 1.0 : 0.0,
        )
        .scaleXY(
          begin: 1.0,
          end: 1.05,
          duration: 800.ms,
          curve: Curves.easeInOut,
        )
        .then()
        .rotate(
          begin: isPasswordVisible ? -0.05 : 0,
          end: isPasswordVisible ? 0.05 : 0,
          duration: 400.ms,
          curve: Curves.easeInOut,
        );
  }
}
