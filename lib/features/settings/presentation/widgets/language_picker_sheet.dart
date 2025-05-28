import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:upwork_task/core/config/language/locale_provider.dart';
import 'package:upwork_task/features/settings/domain/constants/language_constants.dart';
import 'package:upwork_task/l10n/app_localizations.dart';

/// A bottom sheet widget that displays available languages for selection.
/// Shows each language with its native name and English name, along with a checkmark
/// for the currently selected language.
class LanguagePickerSheet extends StatelessWidget {
  final ColorScheme colorScheme;
  final TextTheme textTheme;

  const LanguagePickerSheet({
    super.key,
    required this.colorScheme,
    required this.textTheme,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final currentLocale = context.watch<LocaleProvider>().locale.languageCode;

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
                  l10n.selectLanguage,
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
          // List of available languages
          ...LanguageConstants.languages.map((lang) => ListTile(
                leading: const Icon(Icons.language),
                title: Text(lang.nativeLabel),
                subtitle: Text(lang.label),
                trailing: lang.code == currentLocale
                    ? Icon(
                        Icons.check_circle,
                        color: colorScheme.primary,
                      )
                    : null,
                onTap: () async {
                  await context.read<LocaleProvider>().setLocale(lang.code);
                  if (context.mounted) {
                    Navigator.pop(context);
                  }
                },
              )),
        ],
      ),
    );
  }
}
