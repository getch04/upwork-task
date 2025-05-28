import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class WelcomeIllustration extends StatefulWidget {
  final double size;
  final Color color;

  const WelcomeIllustration({super.key, this.size = 300, required this.color});

  @override
  State<WelcomeIllustration> createState() => _WelcomeIllustrationState();
}

class _WelcomeIllustrationState extends State<WelcomeIllustration>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return SizedBox(
          width: widget.size,
          height: widget.size,
          child: Stack(
            children: [
              CustomPaint(
                painter: _WelcomeIllustrationPainter(
                  color: widget.color,
                  animation: _controller.value,
                ),
                size: Size(widget.size, widget.size),
              ),
              // Minimal floating elements
              ...List.generate(5, (index) {
                final random = Random(index);
                final size = widget.size * (0.05 + random.nextDouble() * 0.1);
                final x = random.nextDouble() * widget.size;
                final y = random.nextDouble() * widget.size;

                return Positioned(
                  left: x,
                  top: y,
                  child: Transform.rotate(
                    angle: random.nextDouble() * pi,
                    child: Container(
                          width: size,
                          height: size,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                              color: widget.color.withOpacity(0.3),
                              width: 1.5,
                            ),
                          ),
                        )
                        .animate(onPlay: (controller) => controller.repeat())
                        .rotate(duration: 4.seconds, curve: Curves.easeInOut)
                        .scale(
                          begin: const Offset(0.8, 0.8),
                          end: const Offset(1.2, 1.2),
                          duration: 3.seconds,
                          curve: Curves.easeInOut,
                        ),
                  ),
                );
              }),
            ],
          ),
        );
      },
    );
  }
}

class _WelcomeIllustrationPainter extends CustomPainter {
  final Color color;
  final double animation;

  _WelcomeIllustrationPainter({required this.color, required this.animation});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final maxRadius = size.width * 0.4;

    final paint =
        Paint()
          ..color = color
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.5;

    // Draw minimal abstract shapes
    final path = Path();

    // Create abstract geometric pattern
    for (var i = 0; i < 4; i++) {
      final angle = (i * pi / 2) + animation * pi;
      final radius = maxRadius * (0.6 + sin(animation * pi * 2) * 0.2);

      final x = center.dx + cos(angle) * radius;
      final y = center.dy + sin(angle) * radius;

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        final controlPoint1 = Offset(
          center.dx + cos(angle - pi / 4) * radius * 1.2,
          center.dy + sin(angle - pi / 4) * radius * 1.2,
        );
        final controlPoint2 = Offset(
          center.dx + cos(angle - pi / 8) * radius * 1.2,
          center.dy + sin(angle - pi / 8) * radius * 1.2,
        );
        path.cubicTo(
          controlPoint1.dx,
          controlPoint1.dy,
          controlPoint2.dx,
          controlPoint2.dy,
          x,
          y,
        );
      }
    }
    path.close();

    // Draw the main shape
    canvas.drawPath(path, paint);

    // Add minimal accent lines
    for (var i = 0; i < 3; i++) {
      final progress = (animation + i / 3) % 1.0;
      final innerRadius = maxRadius * (0.3 + progress * 0.3);

      canvas.drawCircle(
        center,
        innerRadius,
        paint..color = color.withOpacity((1 - progress) * 0.2),
      );
    }

    // Draw minimal connecting lines
    for (var i = 0; i < 4; i++) {
      final angle = (i * pi / 2) + animation * pi;
      final startRadius = maxRadius * 0.3;
      final endRadius = maxRadius * 0.6;

      final start = Offset(
        center.dx + cos(angle) * startRadius,
        center.dy + sin(angle) * startRadius,
      );
      final end = Offset(
        center.dx + cos(angle) * endRadius,
        center.dy + sin(angle) * endRadius,
      );

      canvas.drawLine(start, end, paint..color = color.withOpacity(0.2));
    }
  }

  @override
  bool shouldRepaint(_WelcomeIllustrationPainter oldDelegate) =>
      color != oldDelegate.color || animation != oldDelegate.animation;
}
