import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class GradientOrbBackground extends StatelessWidget {
  final ColorScheme colorScheme;

  const GradientOrbBackground({super.key, required this.colorScheme});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Base gradient
        _AnimatedGradient(colorScheme: colorScheme),

        // Floating orbs
        ...List.generate(
          3,
          (i) => _AnimatedOrb(
            color:
                [
                  colorScheme.primary,
                  colorScheme.secondary,
                  colorScheme.tertiary,
                ][i],
            index: i,
          ),
        ),
      ],
    );
  }
}

class _AnimatedGradient extends StatelessWidget {
  final ColorScheme colorScheme;

  const _AnimatedGradient({required this.colorScheme});

  @override
  Widget build(BuildContext context) {
    return Animate(
      effects: [
        FadeEffect(duration: 1200.ms),
        CustomEffect(
          duration: 8.seconds,
          curve: Curves.easeInOut,
          builder: (context, value, child) {
            return DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment(
                    cos(value * 2 * pi) * 0.2,
                    sin(value * 2 * pi) * 0.2,
                  ),
                  end: Alignment(
                    -cos(value * 2 * pi) * 0.2,
                    -sin(value * 2 * pi) * 0.2,
                  ),
                  colors: [
                    colorScheme.primaryContainer.withOpacity(0.7),
                    colorScheme.surfaceContainerHighest.withOpacity(0.8),
                    colorScheme.secondaryContainer.withOpacity(0.6),
                  ],
                ),
              ),
              child: const SizedBox.expand(),
            );
          },
        ),
      ],
      onComplete: (controller) => controller.repeat(),
    );
  }
}

class _AnimatedOrb extends StatelessWidget {
  final Color color;
  final int index;

  const _AnimatedOrb({required this.color, required this.index});

  @override
  Widget build(BuildContext context) {
    final random = Random(index);
    final size = 160.0 + random.nextDouble() * 80;

    return Positioned(
      left: random.nextDouble() * MediaQuery.of(context).size.width,
      top: random.nextDouble() * MediaQuery.of(context).size.height,
      child: Animate(
        effects: [
          FadeEffect(duration: 1600.ms),
          ScaleEffect(
            duration: 8.seconds,
            begin: const Offset(0.8, 0.8),
            end: const Offset(1.2, 1.2),
            curve: Curves.easeInOut,
          ),
          MoveEffect(
            duration: 12.seconds,
            begin: const Offset(-40, -20),
            end: const Offset(40, 20),
            curve: Curves.easeInOut,
          ),
        ],
        onComplete: (controller) => controller.repeat(reverse: true),
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                color.withOpacity(0.2),
                color.withOpacity(0.1),
                color.withOpacity(0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
