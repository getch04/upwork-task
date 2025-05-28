import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:upwork_task/l10n/app_localizations.dart';

class MoodSelector extends StatefulWidget {
  final Function(int) onMoodSelected;

  const MoodSelector({
    super.key,
    required this.onMoodSelected,
  });

  @override
  State<MoodSelector> createState() => _MoodSelectorState();
}

class _MoodSelectorState extends State<MoodSelector> {
  int? _selectedIndex;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final l10n = AppLocalizations.of(context)!;

    final List<MoodOption> moods = [
      MoodOption(emoji: '😄', value: 5, label: l10n.veryHappy),
      MoodOption(emoji: '🙂', value: 4, label: l10n.happy),
      MoodOption(emoji: '😐', value: 3, label: l10n.neutral),
      MoodOption(emoji: '😔', value: 2, label: l10n.sad),
      MoodOption(emoji: '😢', value: 1, label: l10n.verySad),
    ];

    void onMoodTap(int index) {
      setState(() => _selectedIndex = index);
      widget.onMoodSelected(moods[index].value);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(moods.length, (index) {
            final isSelected = _selectedIndex == index;
            return _MoodButton(
              emoji: moods[index].emoji,
              isSelected: isSelected,
              onTap: () => onMoodTap(index),
              label: moods[index].label,
              colorScheme: colorScheme,
            )
                .animate(
                  delay: (50 * index).ms,
                )
                .slideY(
                  begin: 0.3,
                  end: 0,
                  curve: Curves.easeOutCubic,
                  duration: 500.ms,
                )
                .fadeIn(
                  duration: 400.ms,
                );
          }),
        ),
        if (_selectedIndex != null) ...[
          const SizedBox(height: 16),
          Text(
            moods[_selectedIndex!].label,
            style: textTheme.titleMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ).animate().fadeIn(duration: 300.ms).scale(
                begin: const Offset(0.95, 0.95),
                end: const Offset(1, 1),
                duration: 300.ms,
                curve: Curves.easeOutCubic,
              ),
        ],
      ],
    );
  }
}

class _MoodButton extends StatelessWidget {
  final String emoji;
  final bool isSelected;
  final VoidCallback onTap;
  final String label;
  final ColorScheme colorScheme;

  const _MoodButton({
    required this.emoji,
    required this.isSelected,
    required this.onTap,
    required this.label,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: label,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: isSelected
                  ? colorScheme.primary.withOpacity(0.2)
                  : Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isSelected
                    ? colorScheme.primary
                    : Colors.white.withOpacity(0.2),
                width: isSelected ? 2 : 1,
              ),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: colorScheme.primary.withOpacity(0.3),
                        blurRadius: 12,
                        spreadRadius: 2,
                      )
                    ]
                  : null,
            ),
            child: Center(
              child: Text(
                emoji,
                style: TextStyle(
                  fontSize: isSelected ? 32 : 28,
                ),
              ),
            ),
          ),
        ),
      ),
    )
        .animate(
          target: isSelected ? 1 : 0,
        )
        .scale(
          begin: const Offset(1, 1),
          end: const Offset(1.05, 1.05),
          duration: 200.ms,
          curve: Curves.easeOutCubic,
        );
  }
}

class MoodOption {
  final String emoji;
  final int value;
  final String label;

  const MoodOption({
    required this.emoji,
    required this.value,
    required this.label,
  });
}
