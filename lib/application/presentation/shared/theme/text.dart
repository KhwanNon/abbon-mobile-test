import 'package:flutter/material.dart';

class AppTextTheme {
  static const String _fontFamily = "IBMPlexSansThai";

  static TextTheme light = TextTheme(
    headlineLarge: _baseStyle(24, FontWeight.bold, Colors.black),
    titleMedium: _baseStyle(16, FontWeight.w600, Colors.black),
    bodyMedium: _baseStyle(14, FontWeight.normal, Colors.black),
  );

  static TextTheme dark = TextTheme(
    headlineLarge: _baseStyle(24, FontWeight.bold, Colors.white),
    titleMedium: _baseStyle(16, FontWeight.w600, Colors.white),
    bodyMedium: _baseStyle(14, FontWeight.normal, Colors.white),
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
