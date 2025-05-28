import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  bool _isLoading = false;
  String? _error;
  int _bubbleTapIndex = -1;
  bool _showConfetti = false;
  final _pageController = PageController();
  bool _showPassword = false;
  bool _isPasswordFocused = false;

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(_handlePasswordChange);
    _passwordFocusNode.addListener(_handlePasswordFocus);
  }

  void _handlePasswordChange() {
    setState(() {});
  }

  void _handlePasswordFocus() {
    setState(() => _isPasswordFocused = _passwordFocusNode.hasFocus);
  }

  @override
  void dispose() {
    _passwordController.removeListener(_handlePasswordChange);
    _passwordFocusNode.removeListener(_handlePasswordFocus);
    _passwordFocusNode.dispose();
    _emailFocusNode.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _triggerConfetti() async {
    setState(() => _showConfetti = true);
    await Future.delayed(const Duration(milliseconds: 1500));
    if (mounted) setState(() => _showConfetti = false);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 600;

    return Scaffold(
      body: Stack(
        children: [
          // Animated gradient orb background
          GradientOrbBackground(colorScheme: colorScheme),

          // Decorative background (formerly left pane)
          DecorativePane(colorScheme: colorScheme),

          // Floating elements layer
          _FloatingElementsLayer(
            bubbleTapIndex: _bubbleTapIndex,
            onBubbleTap: (index) => setState(() => _bubbleTapIndex = index),
          ),

          // Centered login form with adaptive width
          Positioned.fill(
            child: Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 24 : 48,
                  vertical: 24,
                ),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 400),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AnimatedLogo(
                        colorScheme: colorScheme,
                        isPasswordVisible: _showPassword,
                        isPasswordFocused: _isPasswordFocused,
                        hasPasswordInput: _passwordController.text.isNotEmpty,
                      ),
                      const SizedBox(height: 24),
                      _buildLoginCard(colorScheme, isMobile),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Success confetti
          if (_showConfetti) const Positioned.fill(child: ConfettiOverlay()),

          // Floating action button for help/support
          Positioned(
            right: 16,
            bottom: 16,
            child: FloatingHelpButton(colorScheme: colorScheme),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginCard(ColorScheme colorScheme, bool isMobile) {
    return Container(
          padding: EdgeInsets.all(isMobile ? 24 : 32),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: colorScheme.primary.withOpacity(0.2),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: colorScheme.shadow.withOpacity(0.08),
                blurRadius: 16,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                    'Welcome Back',
                    style: GoogleFonts.quicksand(
                      fontSize: isMobile ? 30 : 32,
                      fontWeight: FontWeight.bold,
                      color: colorScheme.surface,
                    ),
                  )
                  .animate()
                  .fadeIn(duration: 600.ms)
                  .slideX(
                    begin: -0.2,
                    end: 0,
                    duration: 600.ms,
                    curve: Curves.easeOutCubic,
                  ),
              const SizedBox(height: 8),
              Text(
                    'Sign in to continue your journey',
                    style: GoogleFonts.quicksand(
                      fontSize: isMobile ? 16 : 18,
                      color: colorScheme.surface,
                    ),
                  )
                  .animate()
                  .fadeIn(duration: 600.ms, delay: 200.ms)
                  .slideX(
                    begin: -0.2,
                    end: 0,
                    duration: 600.ms,
                    delay: 200.ms,
                    curve: Curves.easeOutCubic,
                  ),
              SizedBox(height: isMobile ? 24 : 32),
              _buildLoginForm(colorScheme)
                  .animate()
                  .fadeIn(duration: 600.ms, delay: 400.ms)
                  .slideY(
                    begin: 0.2,
                    end: 0,
                    duration: 600.ms,
                    delay: 400.ms,
                    curve: Curves.easeOutCubic,
                  ),
              SizedBox(height: isMobile ? 16 : 24),
              SocialLoginButtons(colorScheme: colorScheme)
                  .animate()
                  .fadeIn(duration: 600.ms, delay: 600.ms)
                  .slideY(
                    begin: 0.2,
                    end: 0,
                    duration: 600.ms,
                    delay: 600.ms,
                    curve: Curves.easeOutCubic,
                  ),
              SizedBox(height: isMobile ? 16 : 24),
              _buildSignUpLink(colorScheme, isMobile)
                  .animate()
                  .fadeIn(duration: 600.ms, delay: 800.ms)
                  .scale(
                    begin: const Offset(0.8, 0.8),
                    end: const Offset(1, 1),
                    duration: 600.ms,
                    delay: 800.ms,
                    curve: Curves.easeOutCubic,
                  ),
            ],
          ),
        )
        .animate()
        .fadeIn(duration: 800.ms)
        .scale(
          begin: const Offset(0.9, 0.9),
          end: const Offset(1, 1),
          duration: 800.ms,
          curve: Curves.easeOutCubic,
        )
        .shimmer(
          duration: 2.seconds,
          color: colorScheme.primary.withOpacity(0.1),
          size: 0.5,
          delay: 400.ms,
        );
  }

  Widget _buildLoginForm(ColorScheme colorScheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ModernFormField(
          controller: _emailController,
          focusNode: _emailFocusNode,
          label: 'Email',
          icon: Icons.email_outlined,
          color: colorScheme.primary,
        ),
        const SizedBox(height: 16),
        ModernFormField(
          controller: _passwordController,
          focusNode: _passwordFocusNode,
          label: 'Password',
          icon: Icons.lock_outline,
          color: colorScheme.primary,
          obscure: !_showPassword,
          suffixIcon: IconButton(
            icon: Icon(
              _showPassword ? Icons.visibility : Icons.visibility_off,
              color: colorScheme.primary,
              size: 20,
            ),
            onPressed: () => setState(() => _showPassword = !_showPassword),
          ),
        ),
        const SizedBox(height: 8),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {},
            child: Text(
              'Forgot Password?',
              style: TextStyle(color: colorScheme.surface),
            ),
          ),
        ),
        if (_error != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Text(_error!, style: TextStyle(color: colorScheme.error)),
          ),
        const SizedBox(height: 8),
        ModernButton(
          isLoading: _isLoading,
          onPressed: _isLoading ? null : _handleLogin,
          label: 'Sign In',
          icon: Icons.arrow_forward_ios,
        ),
      ],
    );
  }

  Widget _buildSignUpLink(ColorScheme colorScheme, bool isMobile) {
    return Center(
      child: RichText(
        text: TextSpan(
          style: GoogleFonts.quicksand(
            fontSize: isMobile ? 12 : 14,
            color: colorScheme.onSurfaceVariant,
          ),
          children: [
            const TextSpan(text: "Don't have an account? "),
            TextSpan(
              text: 'Sign up',
              style: TextStyle(
                color: colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleLogin() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    await Future.delayed(const Duration(seconds: 1));

    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      setState(() {
        _error = 'Please enter email and password';
        _isLoading = false;
      });
      return;
    }

    _triggerConfetti();
    await Future.delayed(const Duration(milliseconds: 1500));
    if (mounted) context.go('/dashboard');
  }
}

class _FloatingElementsLayer extends StatelessWidget {
  final int bubbleTapIndex;
  final ValueChanged<int> onBubbleTap;

  const _FloatingElementsLayer({
    required this.bubbleTapIndex,
    required this.onBubbleTap,
  });

  @override
  Widget build(BuildContext context) {
    final pastelBubbles = [
      _BubbleData(const Offset(80, 120), 60, const Color(0xFFB8D8F8)),
      _BubbleData(const Offset(320, 200), 40, const Color(0xFFD1E8FF)),
      _BubbleData(const Offset(60, 500), 50, const Color(0xFFA7C7E7)),
      _BubbleData(const Offset(300, 600), 70, const Color(0xFFB8D8F8)),
    ];

    return Stack(
      children: [
        // Floating bubbles
        ...List.generate(
          pastelBubbles.length,
          (i) => Positioned(
            left: pastelBubbles[i].position.dx,
            top: pastelBubbles[i].position.dy,
            child: _AnimatedBubble(
              bubble: pastelBubbles[i],
              onTap: () => onBubbleTap(i),
              tapped: bubbleTapIndex == i,
              index: i,
            ),
          ),
        ),

        // Sparkles
        ...List.generate(24, (i) {
          final random = Random(i);
          return Positioned(
            left: random.nextDouble() * MediaQuery.of(context).size.width,
            top: random.nextDouble() * MediaQuery.of(context).size.height,
            child: _AnimatedSparkle(index: i),
          );
        }),
      ],
    );
  }
}

class _AnimatedSparkle extends StatelessWidget {
  final int index;

  const _AnimatedSparkle({required this.index});

  @override
  Widget build(BuildContext context) {
    final random = Random(index);
    final size = 4.0 + random.nextDouble() * 4.0;
    final delay = random.nextInt(2000);

    return Animate(
          effects: [
            FadeEffect(duration: 800.ms, delay: delay.ms),
            ScaleEffect(
              duration: 1200.ms,
              begin: const Offset(0.6, 0.6),
              end: const Offset(1.4, 1.4),
              curve: Curves.easeInOut,
              delay: delay.ms,
            ),
            MoveEffect(
              begin: Offset(
                random.nextDouble() * 20 - 10,
                random.nextDouble() * 20 - 10,
              ),
              end: Offset.zero,
              duration: 1200.ms,
              delay: delay.ms,
              curve: Curves.easeOutCubic,
            ),
          ],
          onComplete: (controller) => controller.repeat(reverse: true),
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withValues(alpha: 0.7),
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withValues(alpha: 0.5),
                  blurRadius: 8,
                  spreadRadius: 1,
                ),
              ],
            ),
          ),
        )
        .animate()
        .fadeIn(
          duration: 600.ms,
          delay: (index * 100).ms,
          curve: Curves.easeOut,
        )
        .scale(
          begin: const Offset(0.5, 0.5),
          end: const Offset(1, 1),
          duration: 600.ms,
          delay: (index * 100).ms,
          curve: Curves.easeOutBack,
        );
  }
}

class _AnimatedBubble extends StatelessWidget {
  final _BubbleData bubble;
  final VoidCallback onTap;
  final bool tapped;
  final int index;

  const _AnimatedBubble({
    required this.bubble,
    required this.onTap,
    required this.tapped,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final random = Random();
    final floatDuration = Duration(seconds: 6 + random.nextInt(4));

    return Animate(
          effects: [
            FadeEffect(duration: 1200.ms),
            ScaleEffect(
              duration: floatDuration,
              begin: const Offset(1.0, 1.0),
              end: const Offset(1.08, 1.08),
              curve: Curves.easeInOut,
            ),
            MoveEffect(
              begin: const Offset(0, 10),
              end: const Offset(0, -10),
              duration: floatDuration,
              curve: Curves.easeInOut,
            ),
          ],
          onComplete: (controller) => controller.repeat(reverse: true),
          child: GestureDetector(
            onTap: onTap,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutCubic,
              width: bubble.radius * 2 * (tapped ? 1.25 : 1.0),
              height: bubble.radius * 2 * (tapped ? 1.25 : 1.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: bubble.color.withValues(alpha: 0.18),
                gradient: RadialGradient(
                  colors: [
                    bubble.color.withValues(alpha: 0.24),
                    bubble.color.withValues(alpha: 0.16),
                    bubble.color.withValues(alpha: 0.08),
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: bubble.color.withValues(alpha: 0.18),
                    blurRadius: 24,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child:
                  tapped
                      ? Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: bubble.color.withValues(alpha: 0.5),
                                width: 6,
                              ),
                            ),
                          )
                          .animate(onPlay: (controller) => controller.repeat())
                          .shimmer(
                            duration: 1.seconds,
                            color: bubble.color.withValues(alpha: 0.3),
                          )
                      : null,
            ),
          ),
        )
        .animate()
        .fadeIn(
          duration: 800.ms,
          delay: (index * 200).ms,
          curve: Curves.easeOut,
        )
        .scale(
          begin: const Offset(0.5, 0.5),
          end: const Offset(1, 1),
          duration: 800.ms,
          delay: (index * 200).ms,
          curve: Curves.easeOutBack,
        );
  }
}

class _BubbleData {
  final Offset position;
  final double radius;
  final Color color;

  const _BubbleData(this.position, this.radius, this.color);
}
