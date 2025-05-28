import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

class SplashPreview extends StatefulWidget {
  const SplashPreview({super.key});

  @override
  State<SplashPreview> createState() => _SplashPreviewState();
}

class _SplashPreviewState extends State<SplashPreview>
    with SingleTickerProviderStateMixin {
  late AnimationController _loadingController;

  @override
  void initState() {
    super.initState();
    _loadingController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();

    // Navigate to onboarding after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        context.go('/onboarding');
      }
    });
  }

  @override
  void dispose() {
    _loadingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final brightness = MediaQuery.platformBrightnessOf(context);
    final isDarkMode = brightness == Brightness.dark;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: isDarkMode ? const Color(0xFF23284B) : Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            const Spacer(),
            // Logo with fade and scale animation
            Image.asset(
              'assets/logo1.png',
              width: 200,
              height: 200,
            ).animate().fadeIn(duration: 600.ms).scale(
                  begin: const Offset(0.8, 0.8),
                  end: const Offset(1, 1),
                  duration: 600.ms,
                  curve: Curves.easeOutBack,
                ),
            const SizedBox(height: 32),
            // App name with fade and slide animation
            Text(
              'MoodBoard',
              style: textTheme.displayMedium?.copyWith(
                color: isDarkMode ? Colors.white : const Color(0xFF23284B),
              ),
            )
                .animate()
                .fadeIn(
                  delay: 300.ms,
                  duration: 600.ms,
                )
                .slideY(
                  begin: 0.3,
                  end: 0,
                  delay: 300.ms,
                  duration: 600.ms,
                  curve: Curves.easeOutBack,
                ),
            const SizedBox(height: 8),
            // Tagline with fade animation
            Text(
              'Express your emotions',
              style: textTheme.titleMedium?.copyWith(
                color: (isDarkMode ? Colors.white : const Color(0xFF23284B))
                    .withOpacity(0.7),
              ),
            ).animate().fadeIn(
                  delay: 500.ms,
                  duration: 600.ms,
                ),
            const Spacer(),
            // Animated loading indicator
            AnimatedBuilder(
              animation: _loadingController,
              builder: (context, child) {
                return Container(
                  width: 120,
                  height: 4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    color: (isDarkMode ? Colors.white : const Color(0xFF23284B))
                        .withOpacity(0.1),
                  ),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return Stack(
                        children: [
                          Positioned(
                            left: constraints.maxWidth *
                                    _loadingController.value -
                                30,
                            child: Container(
                              width: 30,
                              height: 4,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2),
                                gradient: LinearGradient(
                                  colors: [
                                    (isDarkMode
                                            ? Colors.white
                                            : const Color(0xFF23284B))
                                        .withOpacity(0),
                                    (isDarkMode
                                            ? Colors.white
                                            : const Color(0xFF23284B))
                                        .withOpacity(0.7),
                                    (isDarkMode
                                            ? Colors.white
                                            : const Color(0xFF23284B))
                                        .withOpacity(0),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ).animate().fadeIn(delay: 800.ms, duration: 400.ms);
              },
            ),
            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }
}
