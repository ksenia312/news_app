import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:news_app/app/network/api/news_api.dart';
import 'package:news_app/app/network/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../features/home/di/setup_dependencies.dart';
import '../features/news_sources/di/setup_dependencies.dart';
import '../features/view_settings/di/setup_dependencies.dart';

final sl = GetIt.instance;

Future<void> setupDependencies() async {
  final prefs = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => prefs);

  final dio = DioRegister.dio;
  sl.registerLazySingleton<Dio>(() => dio);

  final api = NewsApi(dio);
  sl.registerLazySingleton<NewsApi>(() => api);

  await setupThemeDependencies();
  await setupSourcesDependencies();
  setupHomeDependencies();
}

T getIt<T extends Object>({
  String? instanceName,
  Object? param1,
  Object? param2,
}) {
  return sl.get<T>(
    instanceName: instanceName,
    param1: param1,
    param2: param2,
  );
}
