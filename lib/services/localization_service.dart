// services/localization_service.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalizationService with ChangeNotifier {
  static const String _languageKey = 'app_language';
  
  Locale _locale = const Locale('en', 'US');
  
  Locale get locale => _locale;
  String get languageCode => _locale.languageCode;

  LocalizationService() {
    _loadLanguage();
  }

  Future<void> _loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final languageCode = prefs.getString(_languageKey) ?? 'en';
    _locale = Locale(languageCode);
    notifyListeners();
  }

  Future<void> setLanguage(String languageCode) async {
    _locale = Locale(languageCode);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_languageKey, languageCode);
    notifyListeners();
  }

  Future<void> toggleLanguage() async {
    final newLanguage = _locale.languageCode == 'en' ? 'ar' : 'en';
    await setLanguage(newLanguage);
  }

  bool isEnglish() => _locale.languageCode == 'en';
  bool isArabic() => _locale.languageCode == 'ar';
}