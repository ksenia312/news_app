import 'package:news_app/di/setup_dependencies.dart';
import 'package:news_app/features/news_sources/data/sources_repository_impl.dart';
import 'package:news_app/features/news_sources/domain/news_sources_store.dart';

Future<void> setupSourcesDependencies() async {
  final repository = SourcesRepositoryImpl(getIt());
  final store = NewsSourcesStore(repository);

  sl.registerFactory(() => store);
}
