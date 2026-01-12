// models/app_state.dart
import 'package:flutter/material.dart';

class AppState with ChangeNotifier {
  String _language = 'en';
  bool _isDarkMode = false;

  String get language => _language;
  bool get isDarkMode => _isDarkMode;

  void setLanguage(String newLanguage) {
    _language = newLanguage;
    notifyListeners();
  }

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  void setTheme(bool isDark) {
    _isDarkMode = isDark;
    notifyListeners();
  }
}