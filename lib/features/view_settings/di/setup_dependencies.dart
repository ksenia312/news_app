import 'package:news_app/di/setup_dependencies.dart';
import 'package:news_app/features/view_settings/data/theme_repository_impl.dart';
import 'package:news_app/features/view_settings/domain/app_theme_model.dart';

Future<void> setupThemeDependencies() async {
  final themeRepository = ThemeRepositoryImpl(getIt());

  final appTheme = await AppThemeModel.getInstance(themeRepository);
  sl.registerLazySingleton(() => appTheme);
}
