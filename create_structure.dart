import 'dart:io';

final directories = [
  'lib/core/config/theme',
  'lib/core/config/language',
  'lib/core/services',
  'lib/core/utils',
  'lib/core/widgets',

  'lib/data/local',
  'lib/data/remote',

  'lib/features/auth/data',
  'lib/features/auth/logic',
  'lib/features/auth/presentation',

  'lib/features/onboarding/data',
  'lib/features/onboarding/logic',
  'lib/features/onboarding/presentation',

  'lib/features/splash/data',
  'lib/features/splash/logic',
  'lib/features/splash/presentation',

  'lib/features/dashboard/data',
  'lib/features/dashboard/logic',
  'lib/features/dashboard/presentation',

  'lib/features/settings/data',
  'lib/features/settings/logic',
  'lib/features/settings/presentation',

  'lib/l10n',
];

final files = {
  'lib/main.dart': _mainFile,
  'lib/app.dart': _appFile,
  'lib/l10n/intl_en.arb': _enArb,
  'lib/l10n/intl_es.arb': _esArb,
};

void main() {
  for (final dir in directories) {
    Directory(dir).createSync(recursive: true);
    print('Created directory: $dir');
  }

  for (final entry in files.entries) {
    final file = File(entry.key);
    file.createSync(recursive: true);
    file.writeAsStringSync(entry.value);
    print('Created file: ${entry.key}');
  }

  print('\n✅ Project structure generated successfully.');
}

const _mainFile = '''
import 'package:flutter/material.dart';
import 'app.dart';

void main() {
  runApp(const MyApp());
}
''';

const _appFile = '''
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Clean Architecture',
      theme: ThemeData(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      home: const Scaffold(body: Center(child: Text("Hello World"))),
    );
  }
}
''';

const _enArb = '''
{
  "@@locale": "en",
  "hello": "Hello"
}
''';

const _esArb = '''
{
  "@@locale": "es",
  "hello": "Hola"
}
''';
