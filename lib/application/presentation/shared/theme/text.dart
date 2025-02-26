import 'package:flutter/material.dart';

class AppTextTheme {
  static const String _fontFamily = "IBMPlexSansThai";

  static TextTheme light = TextTheme(
    headlineLarge: _baseStyle(24, FontWeight.bold, Colors.black),
    headlineSmall: _baseStyle(20, FontWeight.bold, Colors.black),
    titleLarge: _baseStyle(18, FontWeight.w600, Colors.black),
    titleMedium: _baseStyle(16, FontWeight.w600, Colors.black),
    titleSmall: _baseStyle(14, FontWeight.w600, Colors.black),
    bodyLarge: _baseStyle(16, FontWeight.normal, Colors.black),
    bodyMedium: _baseStyle(14, FontWeight.normal, Colors.black),
    bodySmall: _baseStyle(12, FontWeight.normal, Colors.black),
  );

  static TextTheme dark = TextTheme(
    headlineLarge: _baseStyle(24, FontWeight.bold, Colors.white),
    headlineSmall: _baseStyle(20, FontWeight.bold, Colors.white),
    titleLarge: _baseStyle(18, FontWeight.w600, Colors.white),
    titleMedium: _baseStyle(16, FontWeight.w600, Colors.white),
    titleSmall: _baseStyle(14, FontWeight.w600, Colors.white),
    bodyLarge: _baseStyle(16, FontWeight.normal, Colors.white),
    bodyMedium: _baseStyle(14, FontWeight.normal, Colors.white),
    bodySmall: _baseStyle(12, FontWeight.normal, Colors.white),
  );

  static TextStyle _baseStyle(double size, FontWeight weight, Color color) {
    return TextStyle(
      fontSize: size,
      fontWeight: weight,
      fontFamily: _fontFamily,
      color: color,
    );
  }
}
