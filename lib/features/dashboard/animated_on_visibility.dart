import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:visibility_detector/visibility_detector.dart';

class AnimatedOnVisibility extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Offset slideOffset;
  final Curve curve;
  final Duration? delay;

  const AnimatedOnVisibility({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 600),
    this.slideOffset = const Offset(0, 0.15),
    this.curve = Curves.easeOutCubic,
    this.delay,
  });

  @override
  State<AnimatedOnVisibility> createState() => _AnimatedOnVisibilityState();
}

class _AnimatedOnVisibilityState extends State<AnimatedOnVisibility>
    with SingleTickerProviderStateMixin {
  bool _visible = false;

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: widget.key ?? UniqueKey(),
      onVisibilityChanged: (info) {
        if (!_visible && info.visibleFraction > 0.1) {
          setState(() => _visible = true);
        }
      },
      child: _visible
          ? widget.child
              .animate(
                delay: widget.delay ?? Duration.zero,
              )
              .fadeIn(duration: widget.duration)
              .slide(
                begin: widget.slideOffset,
                end: Offset.zero,
                curve: widget.curve,
                duration: widget.duration,
              )
          : Opacity(
              opacity: 0,
              child: widget.child,
            ),
    );
  }
}
