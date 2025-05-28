import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:upwork_task/l10n/app_localizations.dart';

class TodayMoodCard extends StatelessWidget {
  final ColorScheme colorScheme;
  final TextTheme textTheme;
  final AppLocalizations l10n;

  const TodayMoodCard({
    super.key,
    required this.colorScheme,
    required this.textTheme,
    required this.l10n,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            colorScheme.primary,
            colorScheme.primary.withBlue(
              (colorScheme.primary.blue * 0.8).toInt(),
            ),
          ],
        ),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: colorScheme.primary.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.todaysMood,
                    style: textTheme.titleMedium?.copyWith(
                      color: colorScheme.onPrimary.withOpacity(0.8),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: colorScheme.onPrimary.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          '😊',
                          style: textTheme.headlineSmall,
                        ),
                      )
                          .animate(
                            onPlay: (controller) => controller.repeat(),
                          )
                          .shake(
                            duration: 1.seconds,
                            delay: 2.seconds,
                          ),
                      const SizedBox(width: 12),
                      Text(
                        l10n.happy,
                        style: textTheme.headlineSmall?.copyWith(
                          color: colorScheme.onPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Spacer(),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.edit_outlined),
                style: IconButton.styleFrom(
                  backgroundColor: colorScheme.onPrimary.withOpacity(0.2),
                  foregroundColor: colorScheme.onPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            l10n.feelingEnergizedAndMotivated,
            style: textTheme.bodyLarge?.copyWith(
              color: colorScheme.onPrimary.withOpacity(0.9),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Icon(
                Icons.access_time,
                size: 16,
                color: colorScheme.onPrimary.withOpacity(0.7),
              ),
              const SizedBox(width: 4),
              Text(
                l10n.nineThirtyAM,
                style: textTheme.bodySmall?.copyWith(
                  color: colorScheme.onPrimary.withOpacity(0.7),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
