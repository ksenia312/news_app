import 'package:flutter/material.dart';
import 'package:news_app/common/enum_extension.dart';

import 'interface/theme_repository.dart';

class AppThemeModel extends ChangeNotifier {
  AppThemeModel._(this._repository);

  static Future<AppThemeModel> getInstance(
    ThemeRepository repository,
  ) async {
    final appTheme = AppThemeModel._(repository);
    await appTheme.init();
    return appTheme;
  }

  final ThemeRepository _repository;
  late ThemeMode mode;

  bool get isLight => mode == ThemeMode.light;

  Future<void> init() async {
    final savedMode = await _repository.getMode();

    mode = ThemeMode.values.byString(
      savedMode,
      orElse: ThemeMode.light,
    );
  }

  Future<void> toggle() async {
    mode = isLight ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
    await _repository.saveMode(mode.name);
  }
}
