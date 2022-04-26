import 'package:flutter/material.dart';

class Style {
  static ThemeData themeData(bool isDarkTheme) {
    return ThemeData(
      primaryColor:
          isDarkTheme ? Colors.black : const Color.fromARGB(255, 79, 171, 83),
      scaffoldBackgroundColor:
          isDarkTheme ? const Color(0xFF222222) : Colors.white,
      backgroundColor: isDarkTheme ? const Color(0xFF222222) : Colors.white,
      textTheme: TextTheme(
          bodyText1: isDarkTheme
              ? const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.bold)
              : const TextStyle(
                  color: Color(0xFF222222),
                  fontSize: 16,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.bold)),
      toggleableActiveColor: isDarkTheme ? Colors.white : Colors.black,
      primaryColorDark: isDarkTheme
          ? const Color.fromARGB(144, 9, 121, 28)
          :const  Color.fromARGB(234, 9, 121, 28),
      primaryColorLight: isDarkTheme
          ? const Color.fromARGB(140, 187, 255, 0)
          : const Color.fromARGB(221, 187, 255, 0),
    );
  }
}
