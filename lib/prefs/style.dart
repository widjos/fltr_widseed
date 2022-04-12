import 'package:flutter/material.dart';

class Style {
  static ThemeData themeData(bool isDarkTheme) {
    return ThemeData(
      primaryColor: isDarkTheme ? Colors.black : const Color.fromARGB(255, 79, 171, 83),
      scaffoldBackgroundColor: isDarkTheme ? const Color(0xFF222222) : Colors.white,
      backgroundColor:  isDarkTheme ? const Color(0xFF222222) : Colors.white,
    );
  }
}