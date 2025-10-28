import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/theme_model.dart';

class ThemeNotifier with ChangeNotifier {
  AppTheme _currentTheme = ThemeCollection.lightTheme;
  ThemeMode _themeMode = ThemeMode.light;

  ThemeNotifier() {
    _loadTheme();
  }

  // Getters
  AppTheme get currentTheme => _currentTheme;
  ThemeData get themeData => _currentTheme.themeData;
  ThemeMode get themeMode => _themeMode;
  bool get isDarkMode => _themeMode == ThemeMode.dark;

  Future<void> _loadTheme() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final themeName = prefs.getString('theme_name') ?? 'Light';
      final themeModeString = prefs.getString('theme_mode') ?? 'light';
      
      // Set theme mode
      _themeMode = themeModeString == 'dark' ? ThemeMode.dark : 
                   themeModeString == 'system' ? ThemeMode.system : ThemeMode.light;
      
      // Set theme by name
      final theme = getThemeByName(themeName);
      if (theme != null) {
        _currentTheme = theme;
      }
      
      notifyListeners();
    } catch (e) {
      print('Error loading theme: $e');
    }
  }

  Future<void> _saveTheme() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('theme_name', _currentTheme.name);
      await prefs.setString('theme_mode', _themeMode.toString().split('.').last);
    } catch (e) {
      print('Error saving theme: $e');
    }
  }

  // Theme switching methods
  void toggleTheme() {
    _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    _updateCurrentTheme();
    _saveTheme();
    notifyListeners();
  }

  void setThemeMode(ThemeMode mode) {
    _themeMode = mode;
    _updateCurrentTheme();
    _saveTheme();
    notifyListeners();
  }

  void setLightTheme() {
    _themeMode = ThemeMode.light;
    _currentTheme = ThemeCollection.lightTheme;
    _saveTheme();
    notifyListeners();
  }

  void setDarkTheme() {
    _themeMode = ThemeMode.dark;
    _currentTheme = ThemeCollection.darkTheme;
    _saveTheme();
    notifyListeners();
  }

  void setCustomTheme(AppTheme theme) {
    _currentTheme = theme;
    _themeMode = theme.themeData.brightness == Brightness.dark ? ThemeMode.dark : ThemeMode.light;
    _saveTheme();
    notifyListeners();
  }

  void setWarmTheme() {
    _currentTheme = ThemeCollection.warmTheme;
    _themeMode = ThemeMode.light;
    _saveTheme();
    notifyListeners();
  }

  void setCoolTheme() {
    _currentTheme = ThemeCollection.coolTheme;
    _themeMode = ThemeMode.light;
    _saveTheme();
    notifyListeners();
  }

  // Method to get all available themes
  List<AppTheme> getAvailableThemes() {
    return [
      ThemeCollection.lightTheme,
      ThemeCollection.darkTheme,
      ThemeCollection.warmTheme,
      ThemeCollection.coolTheme,
    ];
  }

  // Get theme by name
  AppTheme? getThemeByName(String name) {
    try {
      return getAvailableThemes().firstWhere((theme) => theme.name == name);
    } catch (e) {
      return null;
    }
  }

  // Set theme by name
  void setThemeByName(String name) {
    final theme = getThemeByName(name);
    if (theme != null) {
      setCustomTheme(theme);
    }
  }

  // Cycle through themes
  void cycleThemes() {
    final themes = getAvailableThemes();
    final currentIndex = themes.indexWhere((theme) => theme.name == _currentTheme.name);
    final nextIndex = (currentIndex + 1) % themes.length;
    setCustomTheme(themes[nextIndex]);
  }

  // Reset to default theme
  void resetToDefault() {
    setLightTheme();
  }

  // Private method to update current theme based on theme mode
  void _updateCurrentTheme() {
    switch (_themeMode) {
      case ThemeMode.light:
        _currentTheme = ThemeCollection.lightTheme;
        break;
      case ThemeMode.dark:
        _currentTheme = ThemeCollection.darkTheme;
        break;
      case ThemeMode.system:
        final Brightness systemBrightness = WidgetsBinding.instance.platformDispatcher.platformBrightness;
        _currentTheme = systemBrightness == Brightness.dark 
            ? ThemeCollection.darkTheme 
            : ThemeCollection.lightTheme;
        break;
    }
  }

  // Check if specific theme is active
  bool isThemeActive(String themeName) {
    return _currentTheme.name == themeName;
  }

  // Get current theme colors
  Map<String, Color> getCurrentThemeColors() {
    return {
      'primary': _currentTheme.themeData.primaryColor,
      'background': _currentTheme.themeData.scaffoldBackgroundColor,
      'surface': _currentTheme.themeData.cardColor,
      'onPrimary': _currentTheme.themeData.colorScheme.onPrimary,
      'onSurface': _currentTheme.themeData.colorScheme.onSurface,
    };
  }

  // Listen to system theme changes
  void listenToSystemChanges() {
    WidgetsBinding.instance.platformDispatcher.onPlatformBrightnessChanged = () {
      if (_themeMode == ThemeMode.system) {
        _updateCurrentTheme();
        notifyListeners();
      }
    };
  }
}