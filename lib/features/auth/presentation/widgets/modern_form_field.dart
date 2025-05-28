import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class ModernFormField extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final String label;
  final IconData icon;
  final Color color;
  final bool obscure;
  final Widget? suffixIcon;
  final ValueChanged<bool>? onFocusChanged;

  const ModernFormField({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.label,
    required this.icon,
    required this.color,
    this.obscure = false,
    this.suffixIcon,
    this.onFocusChanged,
  });

  @override
  State<ModernFormField> createState() => _ModernFormFieldState();
}

class _ModernFormFieldState extends State<ModernFormField> {
  bool _focused = false;
  bool _hovered = false;

  @override
  void initState() {
    super.initState();
    widget.focusNode.addListener(_handleFocus);
  }

  void _handleFocus() {
    setState(() => _focused = widget.focusNode.hasFocus);
    widget.onFocusChanged?.call(widget.focusNode.hasFocus);
  }

  @override
  void dispose() {
    widget.focusNode.removeListener(_handleFocus);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: Animate(
        effects: [
          FadeEffect(duration: 400.ms),
          SlideEffect(
            begin: const Offset(0, 0.2),
            end: Offset.zero,
            duration: 400.ms,
            curve: Curves.easeOutCubic,
          ),
        ],
        child: AnimatedContainer(
          duration: 200.ms,
          curve: Curves.easeOutCubic,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: colorScheme.surface.withOpacity(_hovered ? 0.95 : 0.9),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _focused
                  ? widget.color
                  : colorScheme.onSurface.withOpacity(0.2),
              width: _focused ? 1.5 : 1,
            ),
            boxShadow: [
              BoxShadow(
                color: _focused
                    ? widget.color.withOpacity(0.1)
                    : colorScheme.onSurface.withOpacity(0.05),
                blurRadius: _focused ? 8 : 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              FaIcon(
                widget.icon,
                size: 18,
                color: _focused
                    ? widget.color
                    : colorScheme.onSurface.withOpacity(0.7),
              ).animate(target: _focused ? 1 : 0).scale(
                    begin: const Offset(1, 1),
                    end: const Offset(1.1, 1.1),
                    duration: 200.ms,
                    curve: Curves.easeOutCubic,
                  ),
              const SizedBox(width: 12),
              Expanded(
                child: TextField(
                  controller: widget.controller,
                  focusNode: widget.focusNode,
                  obscureText: widget.obscure,
                  style: GoogleFonts.quicksand(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: colorScheme.onSurface,
                  ),
                  decoration: InputDecoration(
                    hintText: widget.label,
                    hintStyle: GoogleFonts.quicksand(
                      fontSize: 15,
                      color: colorScheme.onSurface.withOpacity(0.7),
                      fontWeight: FontWeight.w400,
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 16,
                    ),
                  ),
                  cursorColor: widget.color,
                  cursorWidth: 1.5,
                  keyboardType: widget.obscure
                      ? TextInputType.visiblePassword
                      : TextInputType.emailAddress,
                ),
              ),
              if (widget.suffixIcon != null)
                widget.suffixIcon!.animate(target: _focused ? 1 : 0).scale(
                      begin: const Offset(1, 1),
                      end: const Offset(1.1, 1.1),
                      duration: 200.ms,
                      curve: Curves.easeOutCubic,
                    ),
            ],
          ),
        ),
      ),
    )
        .animate(
          onPlay: (controller) => controller.repeat(reverse: true),
          target: _hovered ? 1 : 0,
        )
        .shimmer(
          duration: 1.seconds,
          color: widget.color.withOpacity(0.1),
          size: 0.3,
          delay: 200.ms,
        );
  }
}
