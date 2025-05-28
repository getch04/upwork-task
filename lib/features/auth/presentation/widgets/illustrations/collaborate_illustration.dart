import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class CollaborateIllustration extends StatefulWidget {
  final double size;
  final Color color;

  const CollaborateIllustration({
    super.key,
    this.size = 300,
    required this.color,
  });

  @override
  State<CollaborateIllustration> createState() =>
      _CollaborateIllustrationState();
}

class _CollaborateIllustrationState extends State<CollaborateIllustration>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 12),
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
                painter: _CollaborateIllustrationPainter(
                  color: widget.color,
                  animation: _controller.value,
                ),
                size: Size(widget.size, widget.size),
              ),
              // Minimal floating elements
              ...List.generate(4, (index) {
                final random = Random(index);
                final size = widget.size * 0.1;
                final x = widget.size * (0.3 + random.nextDouble() * 0.4);
                final y = widget.size * (0.3 + random.nextDouble() * 0.4);

                return Positioned(
                  left: x,
                  top: y,
                  child: Container(
                        width: size,
                        height: 1,
                        color: widget.color.withOpacity(0.1),
                      )
                      .animate(onPlay: (controller) => controller.repeat())
                      .rotate(duration: 10.seconds, curve: Curves.easeInOut)
                      .scale(
                        begin: const Offset(0.8, 0.8),
                        end: const Offset(1.2, 1.2),
                        duration: 5.seconds,
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

class _CollaborateIllustrationPainter extends CustomPainter {
  final Color color;
  final double animation;

  _CollaborateIllustrationPainter({
    required this.color,
    required this.animation,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final maxSize = size.width * 0.7;

    final paint =
        Paint()
          ..color = color
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1;

    // Draw minimal frame
    final frameSize = maxSize * 0.8;
    final frameRect = Rect.fromCenter(
      center: center,
      width: frameSize,
      height: frameSize,
    );

    canvas.drawRect(frameRect, paint..color = color.withOpacity(0.1));

    // Draw diagonal lines
    for (var i = 0; i < 4; i++) {
      final progress = (animation + i / 4) % 1.0;
      final angle = i * (pi / 2) + animation * pi;

      final start = Offset(
        center.dx + cos(angle) * frameSize * 0.2,
        center.dy + sin(angle) * frameSize * 0.2,
      );

      final end = Offset(
        center.dx + cos(angle) * frameSize * 0.4,
        center.dy + sin(angle) * frameSize * 0.4,
      );

      canvas.drawLine(
        start,
        end,
        paint..color = color.withOpacity(0.2 * (1 - progress)),
      );
    }

    // Draw rotating squares
    for (var i = 0; i < 3; i++) {
      final angle = animation * pi * 2 + (i * 2 * pi / 3);
      final distance = maxSize * 0.25;

      canvas.save();
      canvas.translate(
        center.dx + cos(angle) * distance,
        center.dy + sin(angle) * distance,
      );
      canvas.rotate(angle * 2);

      final squareSize = maxSize * 0.15;
      canvas.drawRect(
        Rect.fromCenter(
          center: Offset.zero,
          width: squareSize,
          height: squareSize,
        ),
        paint..color = color.withOpacity(0.15),
      );

      canvas.restore();
    }

    // Draw connecting lines
    final path = Path();
    final points = <Offset>[];

    for (var i = 0; i < 3; i++) {
      final angle = animation * pi * 2 + (i * 2 * pi / 3);
      final distance = maxSize * 0.25;
      points.add(
        Offset(
          center.dx + cos(angle) * distance,
          center.dy + sin(angle) * distance,
        ),
      );
    }

    path.moveTo(points[0].dx, points[0].dy);
    for (var i = 1; i < points.length; i++) {
      path.lineTo(points[i].dx, points[i].dy);
    }
    path.close();

    canvas.drawPath(path, paint..color = color.withOpacity(0.1));

    // Draw minimal center element
    final centerSize = maxSize * 0.1;
    canvas.drawRect(
      Rect.fromCenter(center: center, width: centerSize, height: centerSize),
      paint..color = color.withOpacity(0.2),
    );
  }

  @override
  bool shouldRepaint(_CollaborateIllustrationPainter oldDelegate) =>
      color != oldDelegate.color || animation != oldDelegate.animation;
}
