import 'package:upwork_task/features/settings/domain/models/language_data.dart';

class LanguageConstants {
  static const List<LanguageData> languages = [
    LanguageData(
      code: 'en',
      label: 'English',
      nativeLabel: 'English',
    ),
    LanguageData(
      code: 'es',
      label: 'Spanish',
      nativeLabel: 'Español',
    ),
  ];
}
