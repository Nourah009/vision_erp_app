import 'package:flutter/material.dart';

class AppTheme {
  final String name;
  final ThemeData themeData;

  AppTheme({required this.name, required this.themeData});
}

class ThemeCollection {
  // Your exact colors from the image - DARK BLUE (#196390) is main color
  static const Color diSerria = Color(0xFFdb9b4e);      // Orange/Brown - Secondary
  static const Color matisse = Color(0xFF196390);       // DARK BLUE - PRIMARY COLOR
  static const Color whiteSmoke = Color(0xFFf1f1f2);    // WHITE SMOKE - Background
  static const Color jumbo = Color(0xFF79787a);         // Medium Gray - Text secondary
  static const Color mako = Color(0xFF40494f);          // Dark Gray - Text primary
  static const Color hippieBlue = Color(0xFF6697b6);    // Medium Blue - Primary container
  static const Color silverSand = Color(0xFFbfc2c6);    // Light Silver - Borders
  static const Color dairyCream = Color(0xFFf9dab5);    // Light Cream - Secondary container

  // Static theme getters
  static AppTheme get lightTheme => AppTheme(
    name: 'Light',
    themeData: getLightTheme(),
  );

  static AppTheme get darkTheme => AppTheme(
    name: 'Dark', 
    themeData: getDarkTheme(),
  );

  static AppTheme get warmTheme => AppTheme(
    name: 'Warm',
    themeData: getLightTheme().copyWith(
      colorScheme: getLightTheme().colorScheme.copyWith(
        secondary: diSerria,
        secondaryContainer: dairyCream,
      ),
    ),
  );

  static AppTheme get coolTheme => AppTheme(
    name: 'Cool',
    themeData: getLightTheme().copyWith(
      colorScheme: getLightTheme().colorScheme.copyWith(
        primaryContainer: hippieBlue,
      ),
    ),
  );

  // Cairo Font Text Theme
  static TextTheme get cairoTextTheme {
    return TextTheme(
      displayLarge: TextStyle(
        fontFamily: 'Cairo',
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: mako,
      ),
      displayMedium: TextStyle(
        fontFamily: 'Cairo',
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: mako,
      ),
      displaySmall: TextStyle(
        fontFamily: 'Cairo',
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: mako,
      ),
      headlineLarge: TextStyle(
        fontFamily: 'Cairo',
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: mako,
      ),
      headlineMedium: TextStyle(
        fontFamily: 'Cairo',
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: mako,
      ),
      headlineSmall: TextStyle(
        fontFamily: 'Cairo',
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: mako,
      ),
      titleLarge: TextStyle(
        fontFamily: 'Cairo',
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: mako,
      ),
      titleMedium: TextStyle(
        fontFamily: 'Cairo',
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: mako,
      ),
      titleSmall: TextStyle(
        fontFamily: 'Cairo',
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: mako,
      ),
      bodyLarge: TextStyle(
        fontFamily: 'Cairo',
        fontSize: 16,
        color: mako,
        fontWeight: FontWeight.normal,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'Cairo',
        fontSize: 14,
        color: jumbo,
        fontWeight: FontWeight.normal,
      ),
      bodySmall: TextStyle(
        fontFamily: 'Cairo',
        fontSize: 12,
        color: jumbo,
        fontWeight: FontWeight.normal,
      ),
      labelLarge: TextStyle(
        fontFamily: 'Cairo',
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      labelMedium: TextStyle(
        fontFamily: 'Cairo',
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
      labelSmall: TextStyle(
        fontFamily: 'Cairo',
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
    );
  }

  // Cairo Font Text Theme for Dark Mode
  static TextTheme get cairoDarkTextTheme {
    return TextTheme(
      displayLarge: TextStyle(
        fontFamily: 'Cairo',
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      displayMedium: TextStyle(
        fontFamily: 'Cairo',
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      displaySmall: TextStyle(
        fontFamily: 'Cairo',
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      headlineLarge: TextStyle(
        fontFamily: 'Cairo',
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      headlineMedium: TextStyle(
        fontFamily: 'Cairo',
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      headlineSmall: TextStyle(
        fontFamily: 'Cairo',
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      titleLarge: TextStyle(
        fontFamily: 'Cairo',
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      titleMedium: TextStyle(
        fontFamily: 'Cairo',
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      titleSmall: TextStyle(
        fontFamily: 'Cairo',
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
      bodyLarge: TextStyle(
        fontFamily: 'Cairo',
        fontSize: 16,
        color: Colors.white,
        fontWeight: FontWeight.normal,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'Cairo',
        fontSize: 14,
        color: silverSand,
        fontWeight: FontWeight.normal,
      ),
      bodySmall: TextStyle(
        fontFamily: 'Cairo',
        fontSize: 12,
        color: silverSand,
        fontWeight: FontWeight.normal,
      ),
      labelLarge: TextStyle(
        fontFamily: 'Cairo',
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      labelMedium: TextStyle(
        fontFamily: 'Cairo',
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
      labelSmall: TextStyle(
        fontFamily: 'Cairo',
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
    );
  }

  // Light Theme - DARK BLUE as primary color, WHITE SMOKE background
  static ThemeData getLightTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: matisse, // DARK BLUE - Main color
      secondaryHeaderColor: hippieBlue,
      scaffoldBackgroundColor: whiteSmoke, // WHITE SMOKE background
      cardColor: Colors.white,
      fontFamily: 'Cairo',
      
      colorScheme: const ColorScheme.light(
        primary: matisse, // DARK BLUE - Primary buttons, app bar
        primaryContainer: hippieBlue, // Medium blue for containers
        secondary: diSerria, // Orange for secondary actions
        secondaryContainer: dairyCream, // Cream for secondary containers
        surface: Colors.white, // Cards and surfaces
        background: whiteSmoke, // App background
        error: Color(0xFFBA1A1A),
        onPrimary: Colors.white, // White text on dark blue
        onSecondary: Colors.white,
        onSurface: mako,
        onBackground: mako,
        onError: Colors.white,
        surfaceContainerHighest: silverSand,
      ),
      
      // App Bar Theme - DARK BLUE
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: matisse,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: matisse),
        titleTextStyle: cairoTextTheme.titleLarge!.copyWith(color: matisse),
      ),
      
      // Text Theme with Cairo font
      textTheme: cairoTextTheme,
      
      // Input Decoration Theme - DARK BLUE focus
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: silverSand),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: silverSand),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: matisse), // DARK BLUE focus
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFBA1A1A)),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFBA1A1A)),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        hintStyle: cairoTextTheme.bodyMedium!.copyWith(color: jumbo),
        labelStyle: cairoTextTheme.bodyMedium!.copyWith(color: mako),
        errorStyle: cairoTextTheme.bodySmall!.copyWith(color: Color(0xFFBA1A1A)),
      ),
      
      // Button Themes - DARK BLUE primary
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: matisse, // DARK BLUE
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          textStyle: cairoTextTheme.labelLarge,
        ),
      ),
      
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: matisse, // DARK BLUE
          side: const BorderSide(color: matisse), // DARK BLUE border
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          textStyle: cairoTextTheme.labelLarge!.copyWith(color: matisse),
        ),
      ),
      
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: matisse, // DARK BLUE
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          textStyle: cairoTextTheme.labelMedium!.copyWith(color: matisse),
        ),
      ),
      
      // Bottom Navigation Bar Theme - DARK BLUE selected
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor: matisse, // DARK BLUE selected
        unselectedItemColor: jumbo,
        elevation: 2,
        selectedLabelStyle: cairoTextTheme.labelSmall,
        unselectedLabelStyle: cairoTextTheme.labelSmall,
      ),
      
      // Floating Action Button Theme - Orange for contrast
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: diSerria, // Orange for visibility
        foregroundColor: Colors.white,
      ),
      
      // Divider Theme
      dividerTheme: const DividerThemeData(
        color: silverSand,
        thickness: 1,
        space: 1,
      ),
      
      // SnackBar Theme - DARK BLUE background
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        backgroundColor: matisse, // DARK BLUE background
        contentTextStyle: cairoTextTheme.bodyMedium!.copyWith(color: Colors.white),
      ),
      
      // Progress Indicator Theme - DARK BLUE
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: matisse, // DARK BLUE
      ),
      
      // Switch Theme - DARK BLUE
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.selected)) {
            return matisse; // DARK BLUE when selected
          }
          return Colors.grey;
        }),
        trackColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.selected)) {
            return matisse.withOpacity(0.5); // DARK BLUE when selected
          }
          return Colors.grey.withOpacity(0.5);
        }),
      ),
      
      // Radio Theme - DARK BLUE
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.selected)) {
            return matisse; // DARK BLUE when selected
          }
          return Colors.grey;
        }),
      ),
      
      // Checkbox Theme - DARK BLUE
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.selected)) {
            return matisse; // DARK BLUE when selected
          }
          return Colors.grey;
        }),
      ), 
      
      dialogTheme: DialogThemeData(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      
    );
  }

  // Dark Theme - DARK BLUE adapted for dark mode
  static ThemeData getDarkTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: matisse, // DARK BLUE remains primary
      secondaryHeaderColor: diSerria,
      scaffoldBackgroundColor: const Color(0xFF121212), // Dark background for dark mode
      cardColor: const Color(0xFF1E1E1E),
      fontFamily: 'Cairo',
      
      colorScheme: const ColorScheme.dark(
        primary: matisse, // DARK BLUE - Primary in dark mode
        primaryContainer: hippieBlue,
        secondary: diSerria,
        secondaryContainer: dairyCream,
        surface: Color(0xFF1E1E1E), // Dark background
        background: Color(0xFF121212), // Dark background
        error: Color(0xFFFFB4AB),
        onPrimary: Colors.white,
        onSecondary: Colors.black,
        onSurface: Colors.white,
        onBackground: Colors.white,
        onError: Colors.black,
        surfaceContainerHighest: Color(0xFF2D2D2D),
      ),
      
      // App Bar Theme - DARK BLUE in dark mode
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: cairoDarkTextTheme.titleLarge!.copyWith(color: Colors.white),
      ),
      
      // Text Theme for Dark Mode with Cairo font
      textTheme: cairoDarkTextTheme,
      
      // Input Decoration Theme for Dark Mode - DARK BLUE focus
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF2D2D2D)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF2D2D2D)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: matisse), // DARK BLUE focus
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFFFB4AB)),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFFFB4AB)),
        ),
        filled: true,
        fillColor: const Color(0xFF1E1E1E),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        hintStyle: cairoDarkTextTheme.bodyMedium!.copyWith(color: silverSand),
        labelStyle: cairoDarkTextTheme.bodyMedium!.copyWith(color: Colors.white),
        errorStyle: cairoDarkTextTheme.bodySmall!.copyWith(color: Color(0xFFFFB4AB)),
      ),
      
      // Button Themes for Dark Mode - DARK BLUE primary
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: matisse, // DARK BLUE
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          textStyle: cairoDarkTextTheme.labelLarge,
        ),
      ),
      
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: matisse, // DARK BLUE
          side: const BorderSide(color: matisse), // DARK BLUE border
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          textStyle: cairoDarkTextTheme.labelLarge!.copyWith(color: matisse),
        ),
      ),
      
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: matisse, // DARK BLUE
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          textStyle: cairoDarkTextTheme.labelMedium!.copyWith(color: matisse),
        ),
      ),

      // Bottom Navigation Bar Theme for Dark Mode - DARK BLUE selected
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: const Color(0xFF1E1E1E),
        selectedItemColor: matisse, // DARK BLUE selected
        unselectedItemColor: silverSand,
        elevation: 2,
        selectedLabelStyle: cairoDarkTextTheme.labelSmall,
        unselectedLabelStyle: cairoDarkTextTheme.labelSmall,
      ),
      
      // Floating Action Button Theme for Dark Mode - Orange for contrast
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: diSerria, // Orange for visibility
        foregroundColor: Colors.white,
      ),
      
      // Divider Theme for Dark Mode
      dividerTheme: const DividerThemeData(
        color: Color(0xFF2D2D2D),
        thickness: 1,
        space: 1,
      ),
      
      // SnackBar Theme for Dark Mode - DARK BLUE background
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        backgroundColor: matisse, // DARK BLUE background
        contentTextStyle: cairoDarkTextTheme.bodyMedium!.copyWith(color: Colors.white),
      ),
      
      // Progress Indicator Theme for Dark Mode - DARK BLUE
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: matisse, // DARK BLUE
      ),
      
      // Switch Theme for Dark Mode - DARK BLUE
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.selected)) {
            return matisse; // DARK BLUE when selected
          }
          return Colors.grey;
        }),
        trackColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.selected)) {
            return matisse.withOpacity(0.5); // DARK BLUE when selected
          }
          return Colors.grey.withOpacity(0.5);
        }),
      ),
      
      // Radio Theme for Dark Mode - DARK BLUE
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.selected)) {
            return matisse; // DARK BLUE when selected
          }
          return Colors.grey;
        }),
      ),
      
      // Checkbox Theme for Dark Mode - DARK BLUE
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.selected)) {
            return matisse; // DARK BLUE when selected
          }
          return Colors.grey;
        }),
      ),
      
      dialogTheme: DialogThemeData(
        backgroundColor: const Color(0xFF1E1E1E),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      
    );
  }
}

// Helper class to easily access your colors anywhere in the app
class AppColors {
  static const Color primaryColor = Color(0xFF196390); // DARK BLUE - Main color
  static const Color secondaryColor = Color(0xFFdb9b4e); // Orange - Secondary
  static const Color backgroundColor = Color(0xFFf1f1f2); // WHITE SMOKE - Background
  static const Color textPrimary = Color(0xFF40494f); // Dark Gray
  static const Color textSecondary = Color(0xFF79787a); // Medium Gray
  static const Color accentBlue = Color(0xFF6697b6); // Medium Blue
  static const Color borderColor = Color(0xFFbfc2c6); // Light Silver
  static const Color creamColor = Color(0xFFf9dab5); // Light Cream
  static const Color whiteSmoke = Color(0xFFf1f1f2); // WHITE SMOKE
  
  // Dark mode colors
  static const Color darkBackground = Color(0xFF121212);
  static const Color darkSurface = Color(0xFF1E1E1E);
  static const Color darkSurfaceVariant = Color(0xFF2D2D2D);
}