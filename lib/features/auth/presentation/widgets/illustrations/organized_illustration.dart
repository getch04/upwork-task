import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class OrganizedIllustration extends StatefulWidget {
  final double size;
  final Color color;

  const OrganizedIllustration({
    super.key,
    this.size = 300,
    required this.color,
  });

  @override
  State<OrganizedIllustration> createState() => _OrganizedIllustrationState();
}

class _OrganizedIllustrationState extends State<OrganizedIllustration>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
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
                painter: _OrganizedIllustrationPainter(
                  color: widget.color,
                  animation: _controller.value,
                ),
                size: Size(widget.size, widget.size),
              ),
              // Minimal decorative elements
              ...List.generate(3, (index) {
                final random = Random(index);
                final size = widget.size * 0.15;
                final x = widget.size * (0.2 + random.nextDouble() * 0.6);
                final y = widget.size * (0.2 + random.nextDouble() * 0.6);

                return Positioned(
                  left: x,
                  top: y,
                  child: Container(
                        width: size,
                        height: size,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: widget.color.withOpacity(0.1),
                            width: 1,
                          ),
                        ),
                      )
                      .animate(onPlay: (controller) => controller.repeat())
                      .rotate(duration: 8.seconds, curve: Curves.easeInOut)
                      .scale(
                        begin: const Offset(0.9, 0.9),
                        end: const Offset(1.1, 1.1),
                        duration: 6.seconds,
                        curve: Curves.easeInOut,
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

class _OrganizedIllustrationPainter extends CustomPainter {
  final Color color;
  final double animation;

  _OrganizedIllustrationPainter({required this.color, required this.animation});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final maxSize = size.width * 0.8;

    final paint =
        Paint()
          ..color = color
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1;

    // Draw minimal grid lines
    final gridSize = 5;
    final step = maxSize / gridSize;
    final offset = (size.width - maxSize) / 2;

    for (var i = 0; i <= gridSize; i++) {
      final pos = offset + i * step;
      final progress = (animation * 2 + i / gridSize) % 1.0;
      paint.color = color.withOpacity(0.1 + (1 - progress) * 0.1);

      // Vertical lines
      canvas.drawLine(
        Offset(pos, offset),
        Offset(pos, offset + maxSize),
        paint,
      );

      // Horizontal lines
      canvas.drawLine(
        Offset(offset, pos),
        Offset(offset + maxSize, pos),
        paint,
      );
    }

    // Draw animated squares
    final squareSize = maxSize / 3;
    for (var i = 0; i < 4; i++) {
      final angle = animation * pi * 2 + i * (pi / 2);
      final x = center.dx + cos(angle) * squareSize;
      final y = center.dy + sin(angle) * squareSize;

      canvas.save();
      canvas.translate(x, y);
      canvas.rotate(angle);

      final rect = Rect.fromCenter(
        center: Offset.zero,
        width: squareSize * 0.5,
        height: squareSize * 0.5,
      );

      canvas.drawRect(rect, paint..color = color.withOpacity(0.2));

      canvas.restore();
    }

    // Draw connecting lines
    final path = Path();
    for (var i = 0; i < 4; i++) {
      final angle = animation * pi * 2 + i * (pi / 2);
      final x = center.dx + cos(angle) * (squareSize * 0.7);
      final y = center.dy + sin(angle) * (squareSize * 0.7);

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();

    canvas.drawPath(path, paint..color = color.withOpacity(0.15));

    // Draw minimal center element
    canvas.drawRect(
      Rect.fromCenter(
        center: center,
        width: squareSize * 0.3,
        height: squareSize * 0.3,
      ),
      paint..color = color.withOpacity(0.3),
    );
  }

  @override
  bool shouldRepaint(_OrganizedIllustrationPainter oldDelegate) =>
      color != oldDelegate.color || animation != oldDelegate.animation;
}
