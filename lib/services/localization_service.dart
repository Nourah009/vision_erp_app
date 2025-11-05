import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalizationService extends ChangeNotifier {
  Locale _locale = const Locale('en', 'US');
  static const String _localeKey = 'selected_locale';

  Locale get locale => _locale;

  LocalizationService() {
    _loadSavedLocale();
  }

  bool isEnglish() => _locale.languageCode == 'en';
  bool isArabic() => _locale.languageCode == 'ar';

  Future<void> _loadSavedLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final savedLocale = prefs.getString(_localeKey);
    
    if (savedLocale != null) {
      _locale = Locale(savedLocale, savedLocale == 'en' ? 'US' : 'SA');
      notifyListeners();
    }
  }

  Future<void> setLocale(Locale newLocale) async {
    if (!['en', 'ar'].contains(newLocale.languageCode)) return;
    
    _locale = newLocale;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_localeKey, newLocale.languageCode);
  }

  Future<void> toggleLanguage() async {
    final newLocale = isEnglish() ? const Locale('ar', 'SA') : const Locale('en', 'US');
    await setLocale(newLocale);
  }

  // Directionality helper
  TextDirection get textDirection => isEnglish() ? TextDirection.ltr : TextDirection.rtl;

  // Alignment helper for RTL support
  Alignment get alignment => isEnglish() ? Alignment.centerLeft : Alignment.centerRight;
}