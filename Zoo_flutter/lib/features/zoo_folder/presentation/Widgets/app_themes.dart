import 'package:flutter/material.dart';

class AppThemes {
  static final appThemeData = {
    AppTheme.lightTheme: ThemeData(
      
      brightness: Brightness.light,
      primarySwatch: Colors.green,
      backgroundColor: Colors.white,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.green,
        iconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20
        )
      ),
      textTheme: TextTheme(
        bodyText1: TextStyle(
          color: Colors.black,
        ),
      ),
    ),
    AppTheme.darkTheme: ThemeData(
      brightness: Brightness.dark,
      bottomAppBarColor: Colors.green,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.grey,
        iconTheme: IconThemeData(color: Colors.black),
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 20
        )
      ),
      primarySwatch: Colors.grey,
      backgroundColor: Colors.black,
      textTheme: TextTheme(
        bodyText1: TextStyle(
          color: Colors.white,
        ),
      ),
    )
  };
}
enum AppTheme {
  lightTheme,
  darkTheme,
}