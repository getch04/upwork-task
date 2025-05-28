import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleProvider extends ChangeNotifier {
  Locale _locale = const Locale('en');

  Locale get locale => _locale;

  Future<void> loadLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final langCode = prefs.getString('locale') ?? 'en';
    print('Loading locale: $langCode'); // Debug print
    _locale = Locale(langCode);
    notifyListeners();
  }

  Future<void> setLocale(String languageCode) async {
    print('Setting locale to: $languageCode'); // Debug print
    if (_locale.languageCode != languageCode) {
      _locale = Locale(languageCode);
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('locale', languageCode);
      print('Locale set and saved: $languageCode'); // Debug print
    }
  }

  void clearLocale() {
    _locale = const Locale('en');
    notifyListeners();
  }
}
