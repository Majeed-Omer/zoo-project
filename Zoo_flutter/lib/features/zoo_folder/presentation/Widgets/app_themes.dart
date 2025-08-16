import 'package:flutter/material.dart';

class AppThemes {
  static final appThemeData = {
    AppTheme.lightTheme: ThemeData(
      brightness: Brightness.light,
      primarySwatch: Colors.green,
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.green,
        iconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(
          color: Colors.black,
        ),
      ),
    ),
    AppTheme.darkTheme: ThemeData(
      brightness: Brightness.dark,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.grey,
        iconTheme: IconThemeData(color: Colors.black),
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 20,
        ),
      ),
      bottomAppBarTheme: const BottomAppBarThemeData(
        color: Colors.green,
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(
          color: Colors.white,
        ),
      ),
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: Colors.grey,
        brightness: Brightness.dark, // ✅ fixes mismatch
      ).copyWith(surface: Colors.black),
    ),
  };
}

enum AppTheme {
  lightTheme,
  darkTheme,
}
