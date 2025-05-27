import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SocialLoginButtons extends StatelessWidget {
  final ColorScheme colorScheme;

  const SocialLoginButtons({super.key, required this.colorScheme});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Divider(color: colorScheme.outline.withOpacity(0.5)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Or continue with',
                style: TextStyle(color: colorScheme.surface, fontSize: 12),
              ),
            ),
            Expanded(
              child: Divider(color: colorScheme.outline.withOpacity(0.5)),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _SocialButton(
              icon: const FaIcon(FontAwesomeIcons.google, size: 20),
              onPressed: () {},
            ),
            const SizedBox(width: 16),
            _SocialButton(
              icon: const FaIcon(FontAwesomeIcons.facebook, size: 20),
              onPressed: () {},
            ),
            const SizedBox(width: 16),
            _SocialButton(
              icon: const FaIcon(FontAwesomeIcons.apple, size: 20),
              onPressed: () {},
            ),
          ],
        ),
      ],
    );
  }
}

class _SocialButton extends StatefulWidget {
  final Widget icon;
  final VoidCallback onPressed;

  const _SocialButton({required this.icon, required this.onPressed});

  @override
  State<_SocialButton> createState() => _SocialButtonState();
}

class _SocialButtonState extends State<_SocialButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: 200.ms,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color:
              _hovered
                  ? colorScheme.surfaceContainerHighest
                  : colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: colorScheme.outline.withOpacity(0.5)),
        ),
        child: Row(mainAxisSize: MainAxisSize.min, children: [widget.icon]),
      ),
    );
  }
}
