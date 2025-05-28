import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'core/config/language/locale_provider.dart';
import 'core/config/theme/theme_provider.dart';
import 'router/app_router.dart';

void main() async {
  // Keep native splash screen up until app is fully loaded
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // Initialize providers
  final themeProvider = ThemeProvider();
  await themeProvider.loadTheme();

  final localeProvider = LocaleProvider();
  await localeProvider.loadLocale();

  // Remove splash screen once initialization is complete
  FlutterNativeSplash.remove();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: themeProvider),
        ChangeNotifierProvider.value(value: localeProvider),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final lightTheme = Provider.of<ThemeProvider>(context).lightTheme.copyWith(
          textTheme: GoogleFonts.quicksandTextTheme(
            Provider.of<ThemeProvider>(context).lightTheme.textTheme,
          ),
        );

    final darkTheme = Provider.of<ThemeProvider>(context).darkTheme.copyWith(
          textTheme: GoogleFonts.quicksandTextTheme(
            Provider.of<ThemeProvider>(context).darkTheme.textTheme,
          ),
        );

    return MaterialApp.router(
      routerDelegate: appRouter.routerDelegate,
      routeInformationParser: appRouter.routeInformationParser,
      routeInformationProvider: appRouter.routeInformationProvider,
      debugShowCheckedModeBanner: false,
      title: 'MoodBoard',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: Provider.of<ThemeProvider>(context).themeMode,
      locale: Provider.of<LocaleProvider>(context).locale,
      supportedLocales: const [Locale('en'), Locale('es')],
      localizationsDelegates: const [
        // Add your localization delegates here
      ],
    );
  }
}
