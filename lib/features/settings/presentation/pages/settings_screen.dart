import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:upwork_task/core/config/language/locale_provider.dart';
import 'package:upwork_task/core/config/theme/theme_provider.dart';
import 'package:upwork_task/features/settings/domain/constants/language_constants.dart';
import 'package:upwork_task/features/settings/domain/constants/theme_constants.dart';
import 'package:upwork_task/features/settings/presentation/widgets/language_picker_sheet.dart';
import 'package:upwork_task/features/settings/presentation/widgets/settings_section.dart';
import 'package:upwork_task/features/settings/presentation/widgets/settings_tile.dart';
import 'package:upwork_task/features/settings/presentation/widgets/theme_picker_sheet.dart';
import 'package:upwork_task/l10n/app_localizations.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final themeProvider = context.watch<ThemeProvider>();
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          children: [
            // Header
            Text(
              l10n.settings,
              style: textTheme.headlineMedium?.copyWith(
                color: colorScheme.onSurface,
                fontWeight: FontWeight.bold,
              ),
            ).animate().fadeIn(duration: 300.ms).slideX(
                  begin: -0.1,
                  end: 0,
                  duration: 400.ms,
                  curve: Curves.easeOutCubic,
                ),
            const SizedBox(height: 32),

            // Theme Settings
            SettingsSection(
              title: l10n.appearance,
              delay: 100.ms,
              children: [
                SettingsTile(
                  icon: Icons.palette_outlined,
                  title: l10n.theme,
                  subtitle: ThemeConstants.themes
                      .firstWhere(
                          (theme) => theme.mode == themeProvider.themeMode)
                      .label,
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => ThemePickerSheet(
                        colorScheme: colorScheme,
                        textTheme: textTheme,
                        currentTheme: themeProvider.themeMode,
                        onThemeSelected: (mode) {
                          themeProvider.setTheme(mode);
                          Navigator.pop(context);
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Language Settings
            SettingsSection(
              title: l10n.language,
              delay: 200.ms,
              children: [
                SettingsTile(
                  icon: Icons.language_outlined,
                  title: l10n.appLanguage,
                  subtitle: LanguageConstants.languages
                      .firstWhere(
                        (lang) =>
                            lang.code ==
                            context.watch<LocaleProvider>().locale.languageCode,
                      )
                      .nativeLabel,
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => LanguagePickerSheet(
                        colorScheme: colorScheme,
                        textTheme: textTheme,
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),

            // App Info
            SettingsSection(
              title: l10n.about,
              delay: 300.ms,
              children: [
                SettingsTile(
                  icon: Icons.info_outline,
                  title: l10n.version,
                  subtitle: '1.0.0',
                  onTap: () {},
                ),
                SettingsTile(
                  icon: Icons.policy_outlined,
                  title: l10n.privacyPolicy,
                  onTap: () {},
                ),
                SettingsTile(
                  icon: Icons.description_outlined,
                  title: l10n.termsOfService,
                  onTap: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
