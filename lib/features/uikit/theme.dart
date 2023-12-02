import 'package:flutter/material.dart';

class AppTheme extends ChangeNotifier {
  AppTheme.initialized() {
    init();
  }

  late ThemeMode mode;

  bool get isLight => mode == ThemeMode.light;

  void init() {
    mode = ThemeMode.light;
  }

  void toggle() {
    mode = isLight ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

abstract class AppThemeConfig {
  static const appBarTheme = AppBarTheme(elevation: 5);

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
        appBarTheme: appBarTheme,
        inputDecorationTheme: inputDecorationTheme,
      );
}
