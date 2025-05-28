import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with TickerProviderStateMixin {
  late final PageController _pageController;
  late final AnimationController _facesController;
  late final AnimationController _titleController;
  late final AnimationController _centerController;
  late final AnimationController _buttonController;
  late final AnimationController _floatController;
  bool _buttonPressed = false;
  int _currentPage = 0;

  final List<OnboardingPage> _pages = [
    OnboardingPage(
      title: "Express your\nmoods with\nstyle",
      faces: [
        MoodFaceData(
          color: Color(0xFFA9C48A),
          label: 'Disgust',
          faceType: MoodFaceType.disgust,
          labelOffset: const Offset(-24, -24),
          labelAngle: -0.18,
        ),
        MoodFaceData(
          color: Color(0xFFC3E2D2),
          label: 'Fear',
          faceType: MoodFaceType.fear,
          labelOffset: const Offset(24, -24),
          labelAngle: 0.18,
        ),
        MoodFaceData(
          color: Color(0xFFF7D59C),
          label: 'Anger',
          faceType: MoodFaceType.anger,
          labelOffset: const Offset(-32, 90),
          labelAngle: -0.14,
        ),
        MoodFaceData(
          color: Color(0xFFF7D6E0),
          label: 'Happiness',
          faceType: MoodFaceType.happiness,
          labelOffset: const Offset(32, 90),
          labelAngle: 0.14,
        ),
      ],
    ),
    OnboardingPage(
      title: "Your daily\nmood\ncompanion",
      faces: [
        MoodFaceData(
          color: Color(0xFFB6D0E2),
          label: 'Calm',
          faceType: MoodFaceType.happiness,
          labelOffset: const Offset(-24, -24),
          labelAngle: -0.18,
        ),
        MoodFaceData(
          color: Color(0xFFE8D5C4),
          label: 'Surprise',
          faceType: MoodFaceType.fear,
          labelOffset: const Offset(24, -24),
          labelAngle: 0.18,
        ),
      ],
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _facesController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _titleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _centerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _buttonController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat(reverse: true);
    _startStaggered();
  }

  Future<void> _startStaggered() async {
    await Future.delayed(const Duration(milliseconds: 200));
    _facesController.forward();
    await Future.delayed(const Duration(milliseconds: 200));
    _titleController.forward();
    await Future.delayed(const Duration(milliseconds: 200));
    _centerController.forward();
    await Future.delayed(const Duration(milliseconds: 200));
    _buttonController.forward();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _facesController.dispose();
    _titleController.dispose();
    _centerController.dispose();
    _buttonController.dispose();
    _floatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFF181C2E),
      body: SafeArea(
        child: Center(
          child: Container(
            width: size.width * 0.95,
            height: size.height * 0.97,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(40),
            ),
            child: Column(
              children: [
                const SizedBox(height: 32),
                // Title
                AnimatedBuilder(
                  animation: _titleController,
                  builder: (context, child) {
                    final offset = 40 * (1 - _titleController.value);
                    return Opacity(
                      opacity: _titleController.value,
                      child: Transform.translate(
                        offset: Offset(0, -offset),
                        child: child,
                      ),
                    );
                  },
                  child: Text(
                    'MoodBoard',
                    style: TextStyle(
                      fontFamily: 'Serif',
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                      color: Color(0xFF38406A),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                // Page View
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() => _currentPage = index);
                    },
                    itemCount: _pages.length,
                    itemBuilder: (context, index) {
                      final page = _pages[index];
                      return _buildPage(page);
                    },
                  ),
                ),
                const SizedBox(height: 24),
                // Page indicator
                AnimatedBuilder(
                  animation: _centerController,
                  builder: (context, child) {
                    return Opacity(
                      opacity: _centerController.value,
                      child: child,
                    );
                  },
                  child: SmoothPageIndicator(
                    controller: _pageController,
                    count: _pages.length,
                    effect: WormEffect(
                      dotHeight: 8,
                      dotWidth: 8,
                      type: WormType.thin,
                      activeDotColor: Color(0xFF23284B),
                      dotColor: Color(0xFFD9D9D9),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                // Get Started Button
                AnimatedBuilder(
                  animation: _buttonController,
                  builder: (context, child) {
                    final offset = 60 * (1 - _buttonController.value);
                    return Opacity(
                      opacity: _buttonController.value,
                      child: Transform.translate(
                        offset: Offset(0, offset),
                        child: child,
                      ),
                    );
                  },
                  child: Center(
                    child: GestureDetector(
                      onTapDown: (_) {
                        setState(() => _buttonPressed = true);
                      },
                      onTapUp: (_) {
                        setState(() => _buttonPressed = false);
                      },
                      onTapCancel: () {
                        setState(() => _buttonPressed = false);
                      },
                      child: AnimatedScale(
                        scale: _buttonPressed ? 0.93 : 1.0,
                        duration: const Duration(milliseconds: 120),
                        curve: Curves.easeOut,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF23284B),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 48,
                              vertical: 18,
                            ),
                          ),
                          onPressed: () {
                            if (_currentPage < _pages.length - 1) {
                              _pageController.nextPage(
                                duration: Duration(milliseconds: 500),
                                curve: Curves.easeInOut,
                              );
                            } else {
                              // to login screen use go router
                              context.go('/login');
                            }
                          },
                          child: Text(
                            _currentPage < _pages.length - 1
                                ? 'Next'
                                : 'Get Started',
                            style: TextStyle(
                              fontFamily: 'Serif',
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPage(OnboardingPage page) {
    return Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Top faces
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (page.faces.isNotEmpty)
                        _AnimatedFace(
                          controller: _facesController,
                          floatController: _floatController,
                          interval: 0.0,
                          child: _MoodFace(
                            color: page.faces[0].color,
                            label: page.faces[0].label,
                            faceType: page.faces[0].faceType,
                            labelOffset: page.faces[0].labelOffset,
                            labelAngle: page.faces[0].labelAngle,
                          ),
                        ),
                      if (page.faces.length > 1)
                        _AnimatedFace(
                          controller: _facesController,
                          floatController: _floatController,
                          interval: 0.15,
                          child: _MoodFace(
                            color: page.faces[1].color,
                            label: page.faces[1].label,
                            faceType: page.faces[1].faceType,
                            labelOffset: page.faces[1].labelOffset,
                            labelAngle: page.faces[1].labelAngle,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  // Center text and squiggle
                  AnimatedBuilder(
                    animation: _centerController,
                    builder: (context, child) {
                      final offset = 40 * (1 - _centerController.value);
                      return Opacity(
                        opacity: _centerController.value,
                        child: Transform.translate(
                          offset: Offset(0, offset),
                          child: child,
                        ),
                      );
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.arrow_downward,
                          color: Color(0xFFB6D0E2),
                          size: 32,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          page.title,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Serif',
                            fontWeight: FontWeight.bold,
                            fontSize: 32,
                            color: Color(0xFF23284B),
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: 80,
                          height: 12,
                          child: CustomPaint(painter: _SquigglePainter()),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  // Bottom faces
                  if (page.faces.length > 2)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _AnimatedFace(
                          controller: _facesController,
                          floatController: _floatController,
                          interval: 0.3,
                          child: _MoodFace(
                            color: page.faces[2].color,
                            label: page.faces[2].label,
                            faceType: page.faces[2].faceType,
                            labelOffset: page.faces[2].labelOffset,
                            labelAngle: page.faces[2].labelAngle,
                          ),
                        ),
                        if (page.faces.length > 3)
                          _AnimatedFace(
                            controller: _facesController,
                            floatController: _floatController,
                            interval: 0.45,
                            child: _MoodFace(
                              color: page.faces[3].color,
                              label: page.faces[3].label,
                              faceType: page.faces[3].faceType,
                              labelOffset: page.faces[3].labelOffset,
                              labelAngle: page.faces[3].labelAngle,
                            ),
                          ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        )
        .animate()
        .fadeIn(duration: 600.ms)
        .slideY(
          begin: 0.3,
          end: 0,
          duration: 600.ms,
          curve: Curves.easeOutCubic,
        );
  }
}

class OnboardingPage {
  final String title;
  final List<MoodFaceData> faces;

  OnboardingPage({required this.title, required this.faces});
}

class MoodFaceData {
  final Color color;
  final String label;
  final MoodFaceType faceType;
  final Offset labelOffset;
  final double labelAngle;

  MoodFaceData({
    required this.color,
    required this.label,
    required this.faceType,
    required this.labelOffset,
    required this.labelAngle,
  });
}

enum MoodFaceType { disgust, fear, anger, happiness }

class _MoodFace extends StatelessWidget {
  final Color color;
  final String label;
  final MoodFaceType faceType;
  final Offset labelOffset;
  final double labelAngle;
  const _MoodFace({
    required this.color,
    required this.label,
    required this.faceType,
    required this.labelOffset,
    this.labelAngle = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 120,
          height: 110,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(28),
          ),
          child: Center(
            child: SizedBox(
              width: 80,
              height: 80,
              child: CustomPaint(painter: _FacePainter(faceType)),
            ),
          ),
        ),
        Positioned(
          left: labelOffset.dx < 0 ? labelOffset.dx : null,
          right: labelOffset.dx > 0 ? labelOffset.dx : null,
          top: labelOffset.dy < 0 ? labelOffset.dy : null,
          bottom: labelOffset.dy > 0 ? labelOffset.dy : null,
          child: Transform.rotate(
            angle: labelAngle,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 3,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              child: Text(
                label,
                style: TextStyle(
                  fontFamily: 'Serif',
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  color: Color(0xFF23284B),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _FacePainter extends CustomPainter {
  final MoodFaceType type;
  _FacePainter(this.type);

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = Colors.transparent
          ..style = PaintingStyle.stroke
          ..strokeWidth = 3;
    final facePaint =
        Paint()
          ..color = Color(0xFF23284B)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 3;
    final w = size.width;
    final h = size.height;
    // Draw face circle
    canvas.drawCircle(Offset(w / 2, h / 2), w / 2 - 4, facePaint);
    switch (type) {
      case MoodFaceType.disgust:
        // Eyes
        canvas.drawArc(
          Rect.fromLTWH(w * 0.22, h * 0.32, w * 0.18, h * 0.18),
          0.2,
          2.7,
          false,
          facePaint,
        );
        canvas.drawArc(
          Rect.fromLTWH(w * 0.60, h * 0.32, w * 0.18, h * 0.18),
          0.2,
          2.7,
          false,
          facePaint,
        );
        // Mouth
        canvas.drawArc(
          Rect.fromLTWH(w * 0.32, h * 0.60, w * 0.36, h * 0.18),
          0.8,
          1.6,
          false,
          facePaint,
        );
        // Cheeks
        canvas.drawCircle(Offset(w * 0.38, h * 0.68), 2.5, facePaint);
        canvas.drawCircle(Offset(w * 0.62, h * 0.68), 2.5, facePaint);
        break;
      case MoodFaceType.fear:
        // Eyes (crossed)
        canvas.drawLine(
          Offset(w * 0.32, h * 0.38),
          Offset(w * 0.42, h * 0.48),
          facePaint,
        );
        canvas.drawLine(
          Offset(w * 0.42, h * 0.38),
          Offset(w * 0.32, h * 0.48),
          facePaint,
        );
        canvas.drawLine(
          Offset(w * 0.58, h * 0.38),
          Offset(w * 0.68, h * 0.48),
          facePaint,
        );
        canvas.drawLine(
          Offset(w * 0.68, h * 0.38),
          Offset(w * 0.58, h * 0.48),
          facePaint,
        );
        // Zigzag mouth
        final path = Path();
        path.moveTo(w * 0.32, h * 0.68);
        path.lineTo(w * 0.40, h * 0.62);
        path.lineTo(w * 0.48, h * 0.72);
        path.lineTo(w * 0.56, h * 0.62);
        path.lineTo(w * 0.64, h * 0.72);
        path.lineTo(w * 0.68, h * 0.68);
        canvas.drawPath(path, facePaint);
        break;
      case MoodFaceType.anger:
        // Eyes (angry)
        final leftEye = Path();
        leftEye.moveTo(w * 0.32, h * 0.40);
        leftEye.lineTo(w * 0.40, h * 0.36);
        leftEye.lineTo(w * 0.40, h * 0.44);
        canvas.drawPath(leftEye, facePaint);
        final rightEye = Path();
        rightEye.moveTo(w * 0.68, h * 0.40);
        rightEye.lineTo(w * 0.60, h * 0.36);
        rightEye.lineTo(w * 0.60, h * 0.44);
        canvas.drawPath(rightEye, facePaint);
        // Frown
        canvas.drawArc(
          Rect.fromLTWH(w * 0.36, h * 0.62, w * 0.28, h * 0.16),
          0.8,
          1.6,
          false,
          facePaint,
        );
        break;
      case MoodFaceType.happiness:
        // Eyes (happy)
        canvas.drawArc(
          Rect.fromLTWH(w * 0.32, h * 0.44, w * 0.12, h * 0.10),
          0.8,
          1.6,
          false,
          facePaint,
        );
        canvas.drawArc(
          Rect.fromLTWH(w * 0.56, h * 0.44, w * 0.12, h * 0.10),
          0.8,
          1.6,
          false,
          facePaint,
        );
        // Smile
        canvas.drawArc(
          Rect.fromLTWH(w * 0.36, h * 0.60, w * 0.28, h * 0.16),
          0.8,
          1.6,
          false,
          facePaint,
        );
        // Hearts
        final heartPaint =
            Paint()
              ..color = Color(0xFFE87EA1)
              ..style = PaintingStyle.stroke
              ..strokeWidth = 2;
        final heartPath = Path();
        heartPath.moveTo(w * 0.78, h * 0.32);
        heartPath.cubicTo(
          w * 0.80,
          h * 0.28,
          w * 0.86,
          h * 0.28,
          w * 0.86,
          h * 0.34,
        );
        heartPath.cubicTo(
          w * 0.86,
          h * 0.38,
          w * 0.80,
          h * 0.38,
          w * 0.78,
          h * 0.34,
        );
        canvas.drawPath(heartPath, heartPaint);
        final heartPath2 = Path();
        heartPath2.moveTo(w * 0.70, h * 0.22);
        heartPath2.cubicTo(
          w * 0.72,
          h * 0.18,
          w * 0.78,
          h * 0.18,
          w * 0.78,
          h * 0.24,
        );
        heartPath2.cubicTo(
          w * 0.78,
          h * 0.28,
          w * 0.72,
          h * 0.28,
          w * 0.70,
          h * 0.24,
        );
        canvas.drawPath(heartPath2, heartPaint);
        break;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _SquigglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = Color(0xFFF7D59C)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 3;
    final path = Path();
    path.moveTo(0, size.height * 0.7);
    path.cubicTo(
      size.width * 0.2,
      0,
      size.width * 0.4,
      size.height,
      size.width * 0.6,
      size.height * 0.7,
    );
    path.cubicTo(
      size.width * 0.8,
      0,
      size.width,
      size.height,
      size.width,
      size.height * 0.7,
    );
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _Dot extends StatelessWidget {
  final bool isActive;
  const _Dot({required this.isActive});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: isActive ? 12 : 8,
      height: isActive ? 12 : 8,
      decoration: BoxDecoration(
        color: isActive ? Color(0xFF23284B) : Color(0xFFD9D9D9),
        shape: BoxShape.circle,
      ),
    );
  }
}

class _AnimatedFace extends StatelessWidget {
  final AnimationController controller;
  final AnimationController floatController;
  final double interval;
  final Widget child;
  const _AnimatedFace({
    required this.controller,
    required this.floatController,
    required this.interval,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([controller, floatController]),
      builder: (context, _) {
        final appear =
            CurvedAnimation(
              parent: controller,
              curve: Interval(interval, 1.0, curve: Curves.easeOutBack),
            ).value;
        final float = (1 + 0.04 * (1 - (floatController.value * 2 - 1).abs()));
        final yOffset = (1 - appear) * 60;
        return Opacity(
          opacity: appear.clamp(0.0, 1.0),
          child: Transform.translate(
            offset: Offset(0, yOffset),
            child: Transform.scale(scale: appear * float, child: child),
          ),
        );
      },
    );
  }
}
