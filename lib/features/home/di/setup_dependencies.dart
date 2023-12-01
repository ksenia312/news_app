import 'package:news_app/di/setup_dependencies.dart';

import '../data/news_repository_impl.dart';
import '../domain/news_cubit.dart';

void setupHomeDependencies() {
  final repository = NewsRepositoryImpl(getIt());

  sl.registerFactory(() => NewsCubit(repository));
}
