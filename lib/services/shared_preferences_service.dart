import 'package:shared_preferences/shared_preferences.dart';
// Add these methods to your existing SharedPreferencesService class

class SharedPreferencesService {
  static const String _introShownKey = 'intro_shown';
  
  // Check if intro has been shown
  static Future<bool> isIntroShown() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_introShownKey) ?? false;
  }
  
  // Mark intro as shown
  static Future<void> setIntroShown() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_introShownKey, true);
    print('Intro pages marked as shown - user will not see them again');
  }
  
  // Reset intro shown (for testing purposes)
  static Future<void> resetIntroShown() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_introShownKey, false);
    print('Intro pages reset - user will see them again on next launch');
  }
}