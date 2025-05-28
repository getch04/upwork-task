import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart' as smooth;
import 'package:upwork_task/features/auth/presentation/widgets/decorative_pane.dart';
import 'package:upwork_task/features/auth/presentation/widgets/gradient_orb_background.dart';
import 'package:upwork_task/features/auth/presentation/widgets/modern_button.dart';

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
  final bool _buttonPressed = false;
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
          color: Color(0xFFF7D6E0),
          label: 'Happiness',
          faceType: MoodFaceType.happiness,
          labelOffset: const Offset(48, -12),
          labelAngle: 0.18,
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
    OnboardingPage(
      title: "Track your\nemotional\njourney",
      faces: [
        MoodFaceData(
          color: Color(0xFFE6C3E2),
          label: 'Joy',
          faceType: MoodFaceType.happiness,
          labelOffset: const Offset(-24, -24),
          labelAngle: -0.18,
        ),
        MoodFaceData(
          color: Color(0xFFA9D4F5),
          label: 'Peace',
          faceType: MoodFaceType.happiness,
          labelOffset: const Offset(24, -24),
          labelAngle: 0.18,
        ),
        MoodFaceData(
          color: Color(0xFFFFC3A0),
          label: 'Love',
          faceType: MoodFaceType.happiness,
          labelOffset: const Offset(0, 90),
          labelAngle: 0,
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
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: Stack(
        children: [
          // Animated gradient orb background
          GradientOrbBackground(colorScheme: colorScheme)
              .animate()
              .scale(
                begin: const Offset(1.1, 1.1),
                end: const Offset(1.0, 1.0),
                duration: 800.ms,
                curve: Curves.easeOutQuint,
              )
              .fadeIn(duration: 600.ms),

          // Decorative background
          DecorativePane(colorScheme: colorScheme)
              .animate()
              .slideX(
                begin: -0.2,
                end: 0,
                duration: 800.ms,
                curve: Curves.easeOutQuint,
              )
              .fadeIn(duration: 600.ms),

          // Main content
          SafeArea(
            child: Center(
              child: SizedBox(
                width: size.width,
                height: size.height,
                child: Column(
                  children: [
                    const SizedBox(height: 32),
                    // Title with enhanced animations
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
                      child: Column(
                        children: [
                          Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 6,
                                ),
                                child: Stack(
                                  children: [
                                    // Enhanced paper background
                                    Positioned.fill(
                                          child: CustomPaint(
                                            painter: _PaperBackgroundPainter(
                                              backgroundColor: colorScheme
                                                  .primary
                                                  .withOpacity(0.05),
                                              strokeColor: colorScheme.primary
                                                  .withOpacity(0.1),
                                            ),
                                          ),
                                        )
                                        .animate()
                                        .scale(
                                          begin: const Offset(0.95, 0.95),
                                          end: const Offset(1.0, 1.0),
                                          duration: 600.ms,
                                          curve: Curves.easeOutQuint,
                                        )
                                        .fadeIn(duration: 400.ms),

                                    // Animated background shapes with enhanced animation
                                    Positioned.fill(
                                      child: CustomPaint(
                                            painter: _TitleBackgroundPainter(
                                              color: colorScheme.primary
                                                  .withOpacity(0.07),
                                            ),
                                          )
                                          .animate(
                                            onPlay:
                                                (controller) =>
                                                    controller.repeat(),
                                          )
                                          .scale(
                                            duration: 3.seconds,
                                            begin: const Offset(1, 1),
                                            end: const Offset(1.1, 1.1),
                                            curve: Curves.easeInOut,
                                          )
                                          .rotate(
                                            duration: 8.seconds,
                                            begin: -0.02,
                                            end: 0.02,
                                          ),
                                    ),

                                    // Title text with enhanced animations
                                    Center(
                                      child: ShaderMask(
                                        shaderCallback:
                                            (bounds) => LinearGradient(
                                              colors: [
                                                colorScheme.primary,
                                                colorScheme.tertiary,
                                                colorScheme.secondary,
                                              ],
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                            ).createShader(bounds),
                                        child: Text(
                                          'MoodBoard',
                                          style: TextStyle(
                                            fontFamily: 'Serif',
                                            fontWeight: FontWeight.bold,
                                            fontSize: 42,
                                            color: Colors.white,
                                            letterSpacing: 1.2,
                                            height: 1.1,
                                            shadows: [
                                              Shadow(
                                                color: colorScheme.primary
                                                    .withOpacity(0.5),
                                                offset: const Offset(0, 4),
                                                blurRadius: 15,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                              .animate()
                              .fadeIn(duration: 800.ms)
                              .slideY(
                                begin: 0.3,
                                end: 0,
                                duration: 800.ms,
                                curve: Curves.easeOutCubic,
                              ),

                          // const SizedBox(height: 8),

                          // Subtitle with animated underline
                          Column(
                                children: [
                                  Text(
                                    'Express yourself',
                                    style: TextStyle(
                                      fontFamily: 'Serif',
                                      fontSize: 18,
                                      color: colorScheme.onPrimary.withOpacity(
                                        0.8,
                                      ),
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Container(
                                        width: 120,
                                        height: 2,
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [
                                              colorScheme.primary.withOpacity(
                                                0,
                                              ),
                                              colorScheme.primary.withOpacity(
                                                0.7,
                                              ),
                                              colorScheme.primary.withOpacity(
                                                0,
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                      .animate(
                                        onPlay:
                                            (controller) => controller.repeat(),
                                      )
                                      .slideX(
                                        begin: -1.5,
                                        end: 1.5,
                                        duration: 2.seconds,
                                        curve: Curves.easeInOut,
                                      ),
                                ],
                              )
                              .animate()
                              .fadeIn(duration: 600.ms, delay: 200.ms)
                              .slideY(
                                begin: 0.3,
                                end: 0,
                                duration: 600.ms,
                                delay: 200.ms,
                                curve: Curves.easeOutCubic,
                              ),

                          const SizedBox(height: 14),
                        ],
                      ),
                    ),

                    // PageView with enhanced transitions
                    Expanded(
                      child: PageView.builder(
                        controller: _pageController,
                        onPageChanged: (index) {
                          setState(() => _currentPage = index);
                          // Reset and restart animations for the new page
                          _facesController.reset();
                          _centerController.reset();
                          _startStaggered();
                        },
                        itemCount: _pages.length,
                        itemBuilder: (context, index) {
                          final page = _pages[index];
                          return _buildPage(page);
                        },
                      ),
                    ),

                    // Enhanced page indicator
                    AnimatedBuilder(
                      animation: _centerController,
                      builder: (context, child) {
                        return Opacity(
                          opacity: _centerController.value,
                          child: child,
                        );
                      },
                      child: smooth.SmoothPageIndicator(
                        controller: _pageController,
                        count: _pages.length,
                        effect: smooth.WormEffect(
                          dotHeight: 8,
                          dotWidth: 8,
                          type: smooth.WormType.thin,
                          activeDotColor: Color(0xFF23284B),
                          dotColor: Color(0xFFD9D9D9),
                          strokeWidth: 1,
                          paintStyle: PaintingStyle.fill,
                        ),
                      ),
                    ).animate().scale(
                      duration: 400.ms,
                      curve: Curves.easeOutQuint,
                      delay: 200.ms,
                    ),

                    const SizedBox(height: 24),

                    // Enhanced buttons animations
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
                      child: Column(
                        children: [
                          // Next/Get Started button with enhanced animations
                          ModernButton(
                            isLoading: false,
                            onPressed: () {
                              if (_currentPage < _pages.length - 1) {
                                _pageController.nextPage(
                                  duration: Duration(milliseconds: 600),
                                  curve: Curves.easeInOut,
                                );
                              } else {
                                context.go('/login');
                              }
                            },
                            label:
                                _currentPage < _pages.length - 1
                                    ? 'Next'
                                    : 'Get Started',
                          ),
                          const SizedBox(height: 10),

                          // Skip button with enhanced animations
                          InkWell(
                                onTap: () => context.go('/login'),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'Skip',
                                      style: TextStyle(
                                        fontFamily: 'Serif',
                                        fontSize: 16,
                                        color: colorScheme.onPrimary
                                            .withOpacity(0.8),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      size: 14,
                                      color: colorScheme.onPrimary.withOpacity(
                                        0.8,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                              .animate()
                              .fadeIn(duration: 400.ms, delay: 200.ms)
                              .slideX(
                                begin: -0.2,
                                end: 0,
                                duration: 400.ms,
                                delay: 200.ms,
                                curve: Curves.easeOutQuint,
                              ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPage(OnboardingPage page) {
    return Center(
          child: SingleChildScrollView(
            child: Stack(
              children: [
                if (_currentPage == 2) ...[
                  // Enhanced floating bubbles with more dynamic animations
                  Positioned(
                    top: 20,
                    left: 40,
                    child: _FloatingBubble(
                      color: Color(0xFFE6C3E2),
                      size: 24,
                      animation: CurvedAnimation(
                        parent: _floatController,
                        curve: Curves.easeInOut,
                      ),
                    ).animate().scale(
                      duration: 600.ms,
                      curve: Curves.easeOutQuint,
                      delay: 200.ms,
                    ),
                  ),
                  Positioned(
                    top: 100,
                    right: 30,
                    child: _FloatingBubble(
                      color: Color(0xFFA9D4F5),
                      size: 32,
                      animation: CurvedAnimation(
                        parent: _floatController,
                        curve: Interval(0.2, 0.8, curve: Curves.easeInOut),
                      ),
                    ).animate().scale(
                      duration: 600.ms,
                      curve: Curves.easeOutQuint,
                      delay: 400.ms,
                    ),
                  ),
                  Positioned(
                    bottom: 120,
                    left: 60,
                    child: _FloatingBubble(
                      color: Color(0xFFFFC3A0),
                      size: 28,
                      animation: CurvedAnimation(
                        parent: _floatController,
                        curve: Interval(0.4, 1.0, curve: Curves.easeInOut),
                      ),
                    ).animate().scale(
                      duration: 600.ms,
                      curve: Curves.easeOutQuint,
                      delay: 600.ms,
                    ),
                  ),
                ],
                // Rest of the page content with enhanced animations
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
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
                            ).animate().scale(
                              duration: 600.ms,
                              curve: Curves.easeOutQuint,
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
                            ).animate().scale(
                              duration: 600.ms,
                              curve: Curves.easeOutQuint,
                              delay: 100.ms,
                            ),
                        ],
                      ),
                      const SizedBox(height: 32),
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
                                )
                                .animate(
                                  onPlay: (controller) => controller.repeat(),
                                )
                                .moveY(
                                  begin: -4,
                                  end: 4,
                                  duration: 1.seconds,
                                  curve: Curves.easeInOut,
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
                            ).animate().fadeIn(duration: 400.ms, delay: 200.ms),
                            const SizedBox(height: 16),
                            SizedBox(
                                  width: 80,
                                  height: 12,
                                  child: CustomPaint(
                                    painter: _SquigglePainter(),
                                  ),
                                )
                                .animate()
                                .scaleX(
                                  begin: 0.6,
                                  end: 1.0,
                                  duration: 600.ms,
                                  curve: Curves.easeOutQuint,
                                )
                                .fadeIn(duration: 400.ms),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),
                      if (page.faces.length > 2)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
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
                            ).animate().scale(
                              duration: 600.ms,
                              curve: Curves.easeOutQuint,
                              delay: 200.ms,
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
        .animate()
        .fadeIn(duration: 600.ms)
        .slideY(
          begin: 0.3,
          end: 0,
          duration: 600.ms,
          curve: Curves.easeOutQuint,
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

class _TitleBackgroundPainter extends CustomPainter {
  final Color color;

  _TitleBackgroundPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = color
          ..style = PaintingStyle.fill;

    // Draw decorative shapes
    final path = Path();

    // Add circles
    path.addOval(
      Rect.fromCircle(
        center: Offset(size.width * 0.2, size.height * 0.3),
        radius: 20,
      ),
    );
    path.addOval(
      Rect.fromCircle(
        center: Offset(size.width * 0.8, size.height * 0.7),
        radius: 15,
      ),
    );

    // Add a wavy line
    path.moveTo(0, size.height * 0.5);
    for (var i = 0; i < size.width; i += 30) {
      path.quadraticBezierTo(
        i + 15,
        size.height * 0.5 + (i % 60 == 0 ? 10 : -10),
        i + 30,
        size.height * 0.5,
      );
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

Widget _buildDecorativeDot(Color color) {
  return Container(
    width: 8,
    height: 8,
    decoration: BoxDecoration(
      color: color,
      shape: BoxShape.circle,
      boxShadow: [
        BoxShadow(
          color: color.withOpacity(0.3),
          blurRadius: 8,
          spreadRadius: 2,
        ),
      ],
    ),
  );
}

class _PaperBackgroundPainter extends CustomPainter {
  final Color backgroundColor;
  final Color strokeColor;

  _PaperBackgroundPainter({
    required this.backgroundColor,
    required this.strokeColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final backgroundPaint =
        Paint()
          ..color = backgroundColor
          ..style = PaintingStyle.fill;

    final strokePaint =
        Paint()
          ..color = strokeColor
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1;

    // Draw background
    final backgroundPath =
        Path()..addRRect(
          RRect.fromRectAndRadius(
            Rect.fromLTWH(0, 0, size.width, size.height),
            Radius.circular(12),
          ),
        );
    canvas.drawPath(backgroundPath, backgroundPaint);

    // Draw scrambled lines
    final random = Random(42); // Fixed seed for consistent pattern
    for (var i = 0; i < 50; i++) {
      final x1 = random.nextDouble() * size.width;
      final y1 = random.nextDouble() * size.height;
      final x2 = x1 + (random.nextDouble() - 0.5) * 40;
      final y2 = y1 + (random.nextDouble() - 0.5) * 40;

      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), strokePaint);
    }

    // Draw some random dots
    for (var i = 0; i < 30; i++) {
      final x = random.nextDouble() * size.width;
      final y = random.nextDouble() * size.height;
      canvas.drawCircle(Offset(x, y), random.nextDouble() * 2, strokePaint);
    }

    // Draw crumpled paper effect (curved lines)
    for (var i = 0; i < 8; i++) {
      final path = Path();
      path.moveTo(
        random.nextDouble() * size.width,
        random.nextDouble() * size.height,
      );

      for (var j = 0; j < 3; j++) {
        path.quadraticBezierTo(
          random.nextDouble() * size.width,
          random.nextDouble() * size.height,
          random.nextDouble() * size.width,
          random.nextDouble() * size.height,
        );
      }

      canvas.drawPath(path, strokePaint..strokeWidth = 0.5);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _FloatingBubble extends StatelessWidget {
  final Color color;
  final double size;
  final Animation<double> animation;

  const _FloatingBubble({
    required this.color,
    required this.size,
    required this.animation,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(
            8 * sin(animation.value * 2 * pi),
            12 * cos(animation.value * 2 * pi),
          ),
          child: child,
        );
      },
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: color.withOpacity(0.8),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.3),
              blurRadius: 8,
              spreadRadius: 2,
            ),
          ],
        ),
      ),
    );
  }
}
