import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ConfettiOverlay extends StatelessWidget {
  const ConfettiOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    final random = Random();
    return IgnorePointer(
      child: Stack(
        children: List.generate(32, (i) {
          final left = random.nextDouble() * MediaQuery.of(context).size.width;
          final top =
              random.nextDouble() * MediaQuery.of(context).size.height * 0.5;
          final color =
              [
                const Color(0xFFA7C7E7),
                const Color(0xFFD1E8FF),
                const Color(0xFFB8D8F8),
                const Color(0xFFB5EAD7),
                const Color(0xFFF7CAC9),
              ][random.nextInt(5)];
          final size = 8.0 + random.nextDouble() * 12.0;
          final delay = random.nextInt(400);

          return Positioned(
            left: left,
            top: top,
            child: Animate(
              effects: [
                MoveEffect(
                  duration: 1200.ms,
                  begin: Offset.zero,
                  end: Offset(0, 120 + random.nextDouble() * 80),
                  curve: Curves.easeIn,
                  delay: delay.ms,
                ),
                FadeEffect(
                  duration: 400.ms,
                  begin: 1.0,
                  end: 0.0,
                  delay: 900.ms + delay.ms,
                ),
              ],
              child: Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: color.withOpacity(0.3),
                      blurRadius: 8,
                      spreadRadius: 1,
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
