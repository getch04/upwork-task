import 'package:flutter/material.dart';
import 'package:upwork_task/features/analytics/domain/models/activity_data.dart';
import 'package:upwork_task/features/analytics/presentation/widgets/modern_activity_card.dart';
import 'package:upwork_task/features/analytics/presentation/widgets/modern_icon_button.dart';
import 'package:upwork_task/l10n/app_localizations.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final l10n = AppLocalizations.of(context)!;

    final activities = [
      const ActivityData(
        title: 'Meditation',
        value: '45 min',
        subtitle: 'Daily Goal: 60 min',
        icon: Icons.self_improvement,
        progress: 0.75,
        color: Colors.blue,
      ),
      const ActivityData(
        title: 'Exercise',
        value: '30 min',
        subtitle: 'Daily Goal: 45 min',
        icon: Icons.fitness_center,
        progress: 0.67,
        color: Colors.green,
      ),
      const ActivityData(
        title: 'Reading',
        value: '20 min',
        subtitle: 'Daily Goal: 30 min',
        icon: Icons.book,
        progress: 0.67,
        color: Colors.orange,
      ),
      const ActivityData(
        title: 'Journaling',
        value: '15 min',
        subtitle: 'Daily Goal: 20 min',
        icon: Icons.edit_note,
        progress: 0.75,
        color: Colors.purple,
      ),
    ];

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              pinned: true,
              backgroundColor: colorScheme.surface,
              elevation: 0,
              title: Text(
                l10n.analytics,
                style: textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              actions: [
                ModernIconButton(
                  icon: Icons.notifications_outlined,
                  onTap: () {},
                  color: colorScheme.primary,
                  colorScheme: colorScheme,
                ),
                const SizedBox(width: 8),
                ModernIconButton(
                  icon: Icons.settings_outlined,
                  onTap: () {},
                  color: colorScheme.primary,
                  colorScheme: colorScheme,
                ),
                const SizedBox(width: 16),
              ],
            ),
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.85,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) => ModernActivityCard(
                    activity: activities[index],
                    colorScheme: colorScheme,
                    textTheme: textTheme,
                  ),
                  childCount: activities.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
