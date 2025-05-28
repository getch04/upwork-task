import 'package:flutter/material.dart';
import 'package:upwork_task/core/constants/app_strings.dart';
import 'package:upwork_task/features/settings/domain/constants/theme_constants.dart';

/// A bottom sheet widget that displays available theme options for selection.
/// Shows each theme with its icon, label, and description, along with a checkmark
/// for the currently selected theme.
class ThemePickerSheet extends StatelessWidget {
  final ColorScheme colorScheme;
  final TextTheme textTheme;
  final ThemeMode currentTheme;
  final Function(ThemeMode) onThemeSelected;

  const ThemePickerSheet({
    super.key,
    required this.colorScheme,
    required this.textTheme,
    required this.currentTheme,
    required this.onThemeSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header with title and close button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                Text(
                  AppStrings.selectTheme,
                  style: textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // List of available themes
          ...ThemeConstants.themes.map((theme) => ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: colorScheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    theme.icon,
                    color: colorScheme.primary,
                    size: 24,
                  ),
                ),
                title: Text(
                  theme.label,
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                subtitle: Text(
                  theme.description,
                  style: textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurface.withOpacity(0.6),
                  ),
                ),
                trailing: currentTheme == theme.mode
                    ? Icon(
                        Icons.check_circle,
                        color: colorScheme.primary,
                      )
                    : null,
                onTap: () => onThemeSelected(theme.mode),
              )),
        ],
      ),
    );
  }
}
