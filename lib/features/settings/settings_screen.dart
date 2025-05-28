import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:upwork_task/core/config/language/locale_provider.dart';
import 'package:upwork_task/core/constants/app_strings.dart';
import 'package:upwork_task/l10n/app_localizations.dart';

import '../../core/config/theme/theme_provider.dart';

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
            _SettingsSection(
              title: l10n.appearance,
              delay: 100.ms,
              children: [
                _SettingsTile(
                  icon: Icons.palette_outlined,
                  title: l10n.theme,
                  subtitle: themeProvider.themeMode == ThemeMode.system
                      ? l10n.system
                      : themeProvider.themeMode == ThemeMode.light
                          ? l10n.light
                          : l10n.dark,
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => _ThemePickerSheet(
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
            _SettingsSection(
              title: l10n.language,
              delay: 200.ms,
              children: [
                _SettingsTile(
                  icon: Icons.language_outlined,
                  title: l10n.appLanguage,
                  subtitle:
                      context.watch<LocaleProvider>().locale.languageCode ==
                              'en'
                          ? 'English'
                          : 'Español',
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => _LanguagePickerSheet(
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
            _SettingsSection(
              title: l10n.about,
              delay: 300.ms,
              children: [
                _SettingsTile(
                  icon: Icons.info_outline,
                  title: l10n.version,
                  subtitle: '1.0.0',
                  onTap: () {},
                ),
                _SettingsTile(
                  icon: Icons.policy_outlined,
                  title: l10n.privacyPolicy,
                  onTap: () {},
                ),
                _SettingsTile(
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

class _SettingsSection extends StatelessWidget {
  final String title;
  final List<Widget> children;
  final Duration delay;

  const _SettingsSection({
    required this.title,
    required this.children,
    required this.delay,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: textTheme.titleMedium?.copyWith(
            color: colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: colorScheme.shadow.withOpacity(0.08),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            children: children,
          ),
        ),
      ],
    ).animate(delay: delay).fadeIn(duration: 300.ms).slideY(
          begin: 0.1,
          end: 0,
          duration: 400.ms,
          curve: Curves.easeOutCubic,
        );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;

  const _SettingsTile({
    required this.icon,
    required this.title,
    this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: colorScheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: colorScheme.primary,
                  size: 22,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: textTheme.titleMedium?.copyWith(
                        color: colorScheme.onSurface,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        subtitle!,
                        style: textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurface.withOpacity(0.6),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: colorScheme.onSurface.withOpacity(0.5),
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ThemePickerSheet extends StatelessWidget {
  final ColorScheme colorScheme;
  final TextTheme textTheme;
  final ThemeMode currentTheme;
  final Function(ThemeMode) onThemeSelected;

  const _ThemePickerSheet({
    required this.colorScheme,
    required this.textTheme,
    required this.currentTheme,
    required this.onThemeSelected,
  });

  @override
  Widget build(BuildContext context) {
    final themes = [
      {
        'mode': ThemeMode.system,
        'label': AppStrings.system,
        'icon': Icons.brightness_auto,
        'description': AppStrings.followSystemTheme,
      },
      {
        'mode': ThemeMode.light,
        'label': AppStrings.light,
        'icon': Icons.light_mode,
        'description': AppStrings.lightColorScheme,
      },
      {
        'mode': ThemeMode.dark,
        'label': AppStrings.dark,
        'icon': Icons.dark_mode,
        'description': AppStrings.darkColorScheme,
      },
    ];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
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
          ...themes.map((theme) => ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: colorScheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    theme['icon'] as IconData,
                    color: colorScheme.primary,
                    size: 24,
                  ),
                ),
                title: Text(
                  theme['label'] as String,
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                subtitle: Text(
                  theme['description'] as String,
                  style: textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurface.withOpacity(0.6),
                  ),
                ),
                trailing: currentTheme == theme['mode']
                    ? Icon(
                        Icons.check_circle,
                        color: colorScheme.primary,
                      )
                    : null,
                onTap: () => onThemeSelected(theme['mode'] as ThemeMode),
              )),
        ],
      ),
    );
  }
}

class _LanguagePickerSheet extends StatelessWidget {
  final ColorScheme colorScheme;
  final TextTheme textTheme;

  const _LanguagePickerSheet({
    required this.colorScheme,
    required this.textTheme,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final languages = [
      {'code': 'en', 'label': 'English', 'nativeLabel': 'English'},
      {'code': 'es', 'label': 'Spanish', 'nativeLabel': 'Español'},
    ];

    final currentLocale = context.watch<LocaleProvider>().locale.languageCode;
    print('Current locale in picker: $currentLocale'); // Debug print

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
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
          ...languages.map((lang) => ListTile(
                leading: const Icon(Icons.language),
                title: Text(lang['nativeLabel']!),
                subtitle: Text(lang['label']!),
                trailing: lang['code'] == currentLocale
                    ? Icon(
                        Icons.check_circle,
                        color: colorScheme.primary,
                      )
                    : null,
                onTap: () async {
                  print('Tapped language: ${lang['code']}'); // Debug print
                  await context.read<LocaleProvider>().setLocale(lang['code']!);
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
