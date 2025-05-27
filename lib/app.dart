import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'core/config/language/locale_provider.dart';
import 'core/config/theme/theme_provider.dart';
import 'l10n/app_localizations.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final localeProvider = Provider.of<LocaleProvider>(context);

    return MaterialApp(
      title: 'Clean Flutter App',
      debugShowCheckedModeBanner: false,
      themeMode: themeProvider.themeMode,
      theme: themeProvider.lightTheme,
      darkTheme: themeProvider.darkTheme,
      locale: localeProvider.locale,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: Scaffold(
        appBar: AppBar(
          title: Builder(
            builder: (context) => Text(AppLocalizations.of(context)!.hello),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Builder(
                builder:
                    (context) => Text(
                      AppLocalizations.of(context)!.hello,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  themeProvider.toggleTheme(
                    themeProvider.themeMode == ThemeMode.light,
                  );
                },
                child: const Text('Toggle Theme'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
