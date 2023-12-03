import 'dart:async';

import 'package:news_app/features/view_settings/domain/interface/theme_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeRepositoryImpl implements ThemeRepository {
  ThemeRepositoryImpl(this._prefs);

  static const _key = 'app_theme_mode';

  final SharedPreferences _prefs;

  @override
  FutureOr<String?> getMode() {
    return _prefs.getString(_key);
  }

  @override
  FutureOr<bool> saveMode(String themeMode) {
    return _prefs.setString(_key, themeMode);
  }
}
