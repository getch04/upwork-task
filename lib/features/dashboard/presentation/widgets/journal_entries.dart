import 'package:flutter/material.dart';
import 'package:upwork_task/l10n/app_localizations.dart';

class JournalEntries extends StatelessWidget {
  final ColorScheme colorScheme;
  final TextTheme textTheme;
  final AppLocalizations l10n;

  const JournalEntries({
    super.key,
    required this.colorScheme,
    required this.textTheme,
    required this.l10n,
  });

  @override
  Widget build(BuildContext context) {
    final entries = [
      {
        'emoji': '🌟',
        'title': l10n.achievedDailyGoals,
        'preview': l10n.journalPreviewProductive,
        'time': '2h ago',
        'mood': l10n.happy,
      },
      {
        'emoji': '🎨',
        'title': l10n.creativeBreakthrough,
        'preview': l10n.journalPreviewCreative,
        'time': 'Yesterday',
        'mood': l10n.inspired,
      },
      {
        'emoji': '🌱',
        'title': l10n.newBeginnings,
        'preview': l10n.journalPreviewNewBeginnings,
        'time': '2d ago',
        'mood': l10n.hopeful,
      },
    ];

    return Column(
      children: entries.map((entry) {
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: colorScheme.shadow.withOpacity(0.08),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: colorScheme.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      entry['emoji'] as String,
                      style: const TextStyle(fontSize: 24),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          entry['title'] as String,
                          style: textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: colorScheme.onSurface,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          entry['time'] as String,
                          style: textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurface.withOpacity(0.6),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: colorScheme.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      entry['mood'] as String,
                      style: textTheme.labelSmall?.copyWith(
                        color: colorScheme.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                entry['preview'] as String,
                style: textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurface.withOpacity(0.8),
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
