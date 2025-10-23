import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static const String _introShownKey = 'intro_shown';

  static Future<bool> isIntroShown() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_introShownKey) ?? false;
  }

  static Future<void> setIntroShown() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_introShownKey, true);
  }
}