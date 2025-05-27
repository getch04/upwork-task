import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/config/language/locale_provider.dart';
import 'core/config/theme/theme_provider.dart';
import 'router/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final themeProvider = ThemeProvider();
  await themeProvider.loadTheme();

  final localeProvider = LocaleProvider();
  await localeProvider.loadLocale();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: themeProvider),
        ChangeNotifierProvider.value(value: localeProvider),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: appRouter.routerDelegate,
      routeInformationParser: appRouter.routeInformationParser,
      routeInformationProvider: appRouter.routeInformationProvider,
      debugShowCheckedModeBanner: false,
      title: 'MoodBoard',
      theme: Provider.of<ThemeProvider>(context).lightTheme,
      darkTheme: Provider.of<ThemeProvider>(context).darkTheme,
      themeMode: Provider.of<ThemeProvider>(context).themeMode,
      locale: Provider.of<LocaleProvider>(context).locale,
      supportedLocales: const [Locale('en'), Locale('es')],
      localizationsDelegates: const [
        // Add your localization delegates here
      ],
    );
  }
}
