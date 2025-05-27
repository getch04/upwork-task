import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class DecorativePane extends StatelessWidget {
  final ColorScheme colorScheme;

  const DecorativePane({super.key, required this.colorScheme});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 600;

    return Stack(
      children: [
        // Background gradient
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                colorScheme.primaryContainer,
                colorScheme.primary,
                colorScheme.secondary,
              ],
              stops: const [0.0, 0.5, 1.0],
            ),
          ),
        ),

        // Animated patterns
        ...List.generate(
          isMobile ? 12 : 20,
          (i) => _AnimatedPattern(
            index: i,
            color: colorScheme.onPrimary,
            type: _PatternType.values[i % _PatternType.values.length],
          ),
        ),

        // Floating dots
        ...List.generate(
          isMobile ? 15 : 25,
          (i) => _FloatingDot(index: i + 100, color: colorScheme.onPrimary),
        ),

        // Animated lines
        ...List.generate(
          isMobile ? 4 : 8,
          (i) => _AnimatedLine(index: i + 200, color: colorScheme.onPrimary),
        ),
      ],
    );
  }
}

enum _PatternType { circle, square, triangle, diamond, cross }

class _AnimatedPattern extends StatelessWidget {
  final int index;
  final Color color;
  final _PatternType type;

  const _AnimatedPattern({
    required this.index,
    required this.color,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    final random = Random(index);
    final size = 30.0 + random.nextDouble() * 40;
    final delay = random.nextInt(1000);

    return Positioned(
      left: random.nextDouble() * MediaQuery.of(context).size.width * 0.8,
      top: random.nextDouble() * MediaQuery.of(context).size.height,
      child: Transform.rotate(
        angle: random.nextDouble() * pi,
        child: Animate(
              effects: [
                FadeEffect(duration: 1200.ms, delay: delay.ms),
                ScaleEffect(
                  begin: const Offset(0.5, 0.5),
                  end: const Offset(1.0, 1.0),
                  duration: 1200.ms,
                  delay: delay.ms,
                  curve: Curves.easeOutBack,
                ),
              ],
              child: SizedBox(
                width: size,
                height: size,
                child: CustomPaint(
                  painter: _PatternPainter(
                    type: type,
                    color: color.withOpacity(0.15),
                    strokeWidth: 2,
                  ),
                ),
              ),
            )
            .animate(onPlay: (controller) => controller.repeat(reverse: true))
            .scale(
              begin: const Offset(1.0, 1.0),
              end: const Offset(1.1, 1.1),
              duration: (2000 + random.nextInt(2000)).ms,
              curve: Curves.easeInOut,
            ),
      ),
    );
  }
}

class _FloatingDot extends StatelessWidget {
  final int index;
  final Color color;

  const _FloatingDot({required this.index, required this.color});

  @override
  Widget build(BuildContext context) {
    final random = Random(index);
    final size = 4.0 + random.nextDouble() * 4;
    final delay = random.nextInt(2000);

    return Positioned(
      left: random.nextDouble() * MediaQuery.of(context).size.width,
      top: random.nextDouble() * MediaQuery.of(context).size.height,
      child: Animate(
            effects: [
              FadeEffect(duration: 1000.ms, delay: delay.ms),
              ScaleEffect(
                begin: const Offset(0.5, 0.5),
                end: const Offset(1.0, 1.0),
                duration: 1000.ms,
                delay: delay.ms,
              ),
            ],
            child: Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color.withOpacity(0.2),
              ),
            ),
          )
          .animate(onPlay: (controller) => controller.repeat(reverse: true))
          .scale(
            begin: const Offset(1.0, 1.0),
            end: const Offset(1.5, 1.5),
            duration: (3000 + random.nextInt(2000)).ms,
            curve: Curves.easeInOut,
          ),
    );
  }
}

class _AnimatedLine extends StatelessWidget {
  final int index;
  final Color color;

  const _AnimatedLine({required this.index, required this.color});

  @override
  Widget build(BuildContext context) {
    final random = Random(index);
    final length = 100.0 + random.nextDouble() * 100;
    final thickness = 1.0 + random.nextDouble() * 1;
    final delay = random.nextInt(1500);
    final angle = random.nextDouble() * pi;

    return Positioned(
      left: random.nextDouble() * MediaQuery.of(context).size.width,
      top: random.nextDouble() * MediaQuery.of(context).size.height,
      child: Transform.rotate(
        angle: angle,
        child: Animate(
              effects: [
                FadeEffect(duration: 1500.ms, delay: delay.ms),
                ScaleEffect(
                  begin: const Offset(0.2, 1.0),
                  end: const Offset(1.0, 1.0),
                  duration: 1500.ms,
                  delay: delay.ms,
                ),
              ],
              child: Container(
                width: length,
                height: thickness,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(thickness / 2),
                ),
              ),
            )
            .animate(onPlay: (controller) => controller.repeat(reverse: true))
            .scale(
              begin: const Offset(1.0, 1.0),
              end: const Offset(1.2, 1.0),
              duration: (4000 + random.nextInt(2000)).ms,
              curve: Curves.easeInOut,
            ),
      ),
    );
  }
}

class _PatternPainter extends CustomPainter {
  final _PatternType type;
  final Color color;
  final double strokeWidth;

  _PatternPainter({
    required this.type,
    required this.color,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = color
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    switch (type) {
      case _PatternType.circle:
        canvas.drawCircle(center, radius - strokeWidth, paint);
        break;
      case _PatternType.square:
        canvas.drawRect(
          Rect.fromCenter(
            center: center,
            width: size.width - strokeWidth * 2,
            height: size.height - strokeWidth * 2,
          ),
          paint,
        );
        break;
      case _PatternType.triangle:
        final path =
            Path()
              ..moveTo(center.dx, strokeWidth)
              ..lineTo(size.width - strokeWidth, size.height - strokeWidth)
              ..lineTo(strokeWidth, size.height - strokeWidth)
              ..close();
        canvas.drawPath(path, paint);
        break;
      case _PatternType.diamond:
        final path =
            Path()
              ..moveTo(center.dx, strokeWidth)
              ..lineTo(size.width - strokeWidth, center.dy)
              ..lineTo(center.dx, size.height - strokeWidth)
              ..lineTo(strokeWidth, center.dy)
              ..close();
        canvas.drawPath(path, paint);
        break;
      case _PatternType.cross:
        canvas.drawLine(
          Offset(strokeWidth, strokeWidth),
          Offset(size.width - strokeWidth, size.height - strokeWidth),
          paint,
        );
        canvas.drawLine(
          Offset(size.width - strokeWidth, strokeWidth),
          Offset(strokeWidth, size.height - strokeWidth),
          paint,
        );
        break;
    }
  }

  @override
  bool shouldRepaint(_PatternPainter oldDelegate) =>
      type != oldDelegate.type ||
      color != oldDelegate.color ||
      strokeWidth != oldDelegate.strokeWidth;
}
