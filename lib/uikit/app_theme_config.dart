import 'package:flutter/material.dart';

abstract class AppThemeConfig {
  static const appBarTheme = AppBarTheme(elevation: 2);

  static const inputDecorationTheme = InputDecorationTheme(
    border: OutlineInputBorder(),
    enabledBorder: OutlineInputBorder(),
    contentPadding: EdgeInsets.symmetric(horizontal: 8),
  );

  static ThemeData get lightTheme => ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.blue,
          brightness: Brightness.light,
        ),
        splashColor: const Color(0xff0d4b80),
        appBarTheme: appBarTheme.copyWith(
          color: Colors.white,
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
        ),
        inputDecorationTheme: inputDecorationTheme,
      );

  static ThemeData get darkTheme => ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.blue,
          accentColor: Colors.lightBlueAccent,
          brightness: Brightness.dark,
        ),
        splashColor: const Color(0xff444446),
        appBarTheme: appBarTheme,
        inputDecorationTheme: inputDecorationTheme,
      );
}
