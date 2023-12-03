import 'package:flutter/material.dart';

extension ThemeExtension on BuildContext {
  ThemeData get themeData {
    return Theme.of(this);
  }

  ColorScheme get colorScheme {
    return themeData.colorScheme;
  }

  TextTheme get textTheme {
    return themeData.textTheme;
  }

  AppBarTheme get appBarTheme {
    return themeData.appBarTheme;
  }
}

extension NavigatorExtension on BuildContext {
  NavigatorState get navigator {
    return Navigator.of(this);
  }
}
