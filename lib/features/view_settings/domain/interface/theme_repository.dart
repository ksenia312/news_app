import 'dart:async';

abstract class ThemeRepository {
  FutureOr<bool> saveMode(String themeMode);

  FutureOr<String?> getMode();
}
