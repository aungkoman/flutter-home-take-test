import 'package:flutter/material.dart';

/// J'Donuts design tokens inferred from the supplied code-test mockups.
/// These are not verified official brand guidelines.
abstract final class JDonutsColors {
  static const cyan = Color(0xFF48C7E3);
  static const pink = Color(0xFFF6EAF0);
  static const hotPink = Color(0xFFEF4C9A);
  static const orange = Color(0xFFFF851B);
  static const ink = Color(0xFF25242A);
  static const muted = Color(0xFF79747C);
  static const surface = Colors.white;
  static const canvas = Color(0xFFF9F5F7);
}

abstract final class JDonutsSpacing {
  static const xs = 4.0;
  static const sm = 8.0;
  static const md = 16.0;
  static const lg = 24.0;
  static const xl = 32.0;
}

abstract final class JDonutsRadius {
  static const field = 10.0;
  static const card = 18.0;
  static const pill = 100.0;
}

abstract final class JDonutsTheme {
  static ThemeData get light {
    final scheme = ColorScheme.fromSeed(
      seedColor: JDonutsColors.cyan,
      brightness: Brightness.light,
      primary: JDonutsColors.cyan,
      onPrimary: Colors.white,
      secondary: JDonutsColors.hotPink,
      onSecondary: Colors.white,
      surface: JDonutsColors.surface,
      onSurface: JDonutsColors.ink,
    );
    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: JDonutsColors.canvas,
      fontFamily: 'Roboto',
      textTheme: const TextTheme(
        headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: JDonutsColors.ink),
        headlineMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: JDonutsColors.ink),
        titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: JDonutsColors.ink),
        titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: JDonutsColors.ink),
        bodyMedium: TextStyle(fontSize: 14, color: JDonutsColors.ink),
        bodySmall: TextStyle(fontSize: 12, color: JDonutsColors.muted),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: JDonutsColors.canvas,
        foregroundColor: JDonutsColors.ink,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: JDonutsColors.cyan,
          foregroundColor: Colors.white,
          minimumSize: const Size.fromHeight(48),
          shape: const StadiumBorder(),
          textStyle: const TextStyle(fontWeight: FontWeight.w800, letterSpacing: .6),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(JDonutsRadius.field),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(JDonutsRadius.field),
          borderSide: const BorderSide(color: JDonutsColors.cyan, width: 1.5),
        ),
      ),
      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(JDonutsRadius.card),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: JDonutsColors.cyan,
        indicatorColor: JDonutsColors.hotPink,
        labelTextStyle: WidgetStateProperty.all(
          const TextStyle(fontWeight: FontWeight.w700, color: Colors.white),
        ),
        iconTheme: WidgetStateProperty.all(const IconThemeData(color: Colors.white)),
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(color: JDonutsColors.hotPink),
      snackBarTheme: const SnackBarThemeData(behavior: SnackBarBehavior.floating),
    );
  }
}
