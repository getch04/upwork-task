import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:upwork_task/features/dashboard/animated_on_visibility.dart';
import 'package:upwork_task/l10n/app_localizations.dart';

import 'widgets/mood_selector.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  void _onMoodSelected(int moodValue) {
    // TODO: Handle mood selection
    debugPrint('Selected mood value: $moodValue');
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final cardColor = Theme.of(context).cardColor;
    final l10n = AppLocalizations.of(context)!;

    final List<_ActivityData> activityData = [
      _ActivityData(
        title: l10n.moodStreak,
        value: l10n.sevenDays,
        subtitle: l10n.keepTrackingYourMood,
        icon: Icons.mood_outlined,
        progress: 0.7,
        color: Colors.blue,
      ),
      _ActivityData(
        title: l10n.reflections,
        value: l10n.twelve,
        subtitle: l10n.writtenThisWeek,
        icon: Icons.edit_note_outlined,
        progress: 0.8,
        color: Colors.purple,
      ),
      _ActivityData(
        title: l10n.happyDays,
        value: l10n.fiveDays,
        subtitle: l10n.thisWeek,
        icon: Icons.sentiment_very_satisfied_outlined,
        progress: 0.71,
        color: Colors.orange,
      ),
      _ActivityData(
        title: l10n.goalsMet,
        value: l10n.threeOfFive,
        subtitle: l10n.weeklyProgress,
        icon: Icons.stars_outlined,
        progress: 0.6,
        color: Colors.green,
      ),
    ];

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          children: [
            // Modern Header with Profile
            AnimatedOnVisibility(
              key: const Key('analytics-header'),
              delay: 0.ms,
              slideOffset: const Offset(0, 0.12),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      colorScheme.primary.withOpacity(0.15),
                      colorScheme.primary.withOpacity(0.05),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(28),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: colorScheme.primary.withOpacity(0.5),
                          width: 2,
                        ),
                      ),
                      child: const CircleAvatar(
                        radius: 22,
                        backgroundImage: NetworkImage(
                          'https://i.pravatar.cc/150?img=5',
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.welcomeBack,
                            style: textTheme.bodyMedium?.copyWith(
                              color: colorScheme.onSurface.withOpacity(0.6),
                            ),
                          ),
                          Text(
                            l10n.annette,
                            style: textTheme.titleMedium?.copyWith(
                              color: colorScheme.onSurface,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    _ModernIconButton(
                      icon: Icons.notifications_outlined,
                      onTap: () {},
                      color: cardColor,
                      colorScheme: colorScheme,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),

            // Daily Progress with Radial Gauge
            AnimatedOnVisibility(
              key: const Key('analytics-daily-score'),
              delay: 80.ms,
              child: Container(
                height: 280,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(32),
                  boxShadow: [
                    BoxShadow(
                      color: colorScheme.primary.withOpacity(0.08),
                      blurRadius: 24,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.moodOverview,
                      style: textTheme.titleLarge?.copyWith(
                        color: colorScheme.onSurface,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Expanded(
                      child: SfRadialGauge(
                        animationDuration: 1000,
                        enableLoadingAnimation: true,
                        axes: <RadialAxis>[
                          RadialAxis(
                            minimum: 0,
                            maximum: 100,
                            showLabels: false,
                            showTicks: false,
                            startAngle: 270,
                            endAngle: 270,
                            radiusFactor: 0.8,
                            axisLineStyle: AxisLineStyle(
                              color: colorScheme.primary.withOpacity(0.1),
                              thickness: 25,
                              cornerStyle: CornerStyle.bothCurve,
                            ),
                            pointers: <GaugePointer>[
                              RangePointer(
                                value: 85,
                                width: 25,
                                cornerStyle: CornerStyle.bothCurve,
                                color: colorScheme.primary,
                              ),
                            ],
                            annotations: <GaugeAnnotation>[
                              GaugeAnnotation(
                                widget: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      '85%',
                                      style: textTheme.headlineMedium?.copyWith(
                                        color: colorScheme.primary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 58),
                                    Text(
                                      l10n.positiveMoodRate,
                                      style: textTheme.bodyMedium?.copyWith(
                                        color: colorScheme.onSurface
                                            .withOpacity(0.6),
                                      ),
                                    ),
                                  ],
                                ),
                                angle: 90,
                                positionFactor: 0.5,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),

            // Mood Selection with Enhanced Design
            AnimatedOnVisibility(
              key: const Key('analytics-mood-selector'),
              delay: 160.ms,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      colorScheme.primary,
                      colorScheme.secondary,
                    ],
                    stops: const [0.0, 1.0],
                  ),
                  borderRadius: BorderRadius.circular(32),
                  border: Border.all(
                    color: colorScheme.primary,
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: colorScheme.primary.withOpacity(0.5),
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
                        Icon(
                          Icons.sentiment_satisfied_alt_outlined,
                          color: colorScheme.primary,
                          size: 28,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          l10n.howAreYouFeelingToday,
                          style: textTheme.titleMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: MoodSelector(
                        onMoodSelected: _onMoodSelected,
                      ),
                    ).animate().fadeIn(duration: 400.ms).slideY(
                          begin: 0.2,
                          duration: 400.ms,
                          curve: Curves.easeOutCubic,
                        ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),

            // Activity Grid with Linear Gauges
            AnimatedOnVisibility(
              key: const Key('analytics-activity-grid'),
              delay: 240.ms,
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                childAspectRatio: 1.1,
                children: [
                  for (final activity in activityData)
                    _ModernActivityCard(
                      activity: activity,
                      colorScheme: colorScheme,
                      textTheme: textTheme,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ModernIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final Color color;
  final ColorScheme colorScheme;

  const _ModernIconButton({
    required this.icon,
    required this.onTap,
    required this.color,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: color.withOpacity(0.9),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: colorScheme.primary.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Icon(
            icon,
            color: colorScheme.primary,
            size: 22,
          ),
        ),
      ),
    );
  }
}

class _ModernActivityCard extends StatelessWidget {
  final _ActivityData activity;
  final ColorScheme colorScheme;
  final TextTheme textTheme;

  const _ModernActivityCard({
    required this.activity,
    required this.colorScheme,
    required this.textTheme,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorScheme.primary.withOpacity(0.05),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: isDarkMode
              ? Colors.white.withOpacity(0.1)
              : colorScheme.primary.withOpacity(0.1),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: activity.color.withOpacity(0.08),
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
                  color: activity.color.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: activity.color.withOpacity(0.2),
                    width: 1,
                  ),
                ),
                child: Icon(
                  activity.icon,
                  color: activity.color,
                  size: 22,
                ),
              ),
              const Spacer(),
              Text(
                '${(activity.progress * 100).toInt()}%',
                style: textTheme.titleMedium?.copyWith(
                  color: isDarkMode ? Colors.white : activity.color,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const Spacer(),
          SfLinearGauge(
            minimum: 0,
            maximum: 100,
            showLabels: false,
            showTicks: false,
            animationDuration: 1000,
            barPointers: [
              LinearBarPointer(
                value: activity.progress * 100,
                color: activity.color,
                thickness: 8,
                edgeStyle: LinearEdgeStyle.bothCurve,
              ),
            ],
            axisTrackStyle: LinearAxisTrackStyle(
              color: activity.color.withOpacity(0.1),
              thickness: 8,
              edgeStyle: LinearEdgeStyle.bothCurve,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            activity.value,
            style: textTheme.titleMedium?.copyWith(
              color: isDarkMode ? Colors.white : colorScheme.onSurface,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            activity.title,
            style: textTheme.bodyMedium?.copyWith(
              color: (isDarkMode ? Colors.white : colorScheme.onSurface)
                  .withOpacity(0.6),
            ),
          ),
        ],
      ),
    );
  }
}

class _ActivityData {
  final String title;
  final String value;
  final String subtitle;
  final IconData icon;
  final double progress;
  final Color color;

  const _ActivityData({
    required this.title,
    required this.value,
    required this.subtitle,
    required this.icon,
    required this.progress,
    required this.color,
  });
}
