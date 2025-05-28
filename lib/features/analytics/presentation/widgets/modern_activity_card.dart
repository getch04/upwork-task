import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:upwork_task/features/analytics/domain/models/activity_data.dart';

class ModernActivityCard extends StatelessWidget {
  final ActivityData activity;
  final ColorScheme colorScheme;
  final TextTheme textTheme;

  const ModernActivityCard({
    super.key,
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
