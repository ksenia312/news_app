import 'package:news_app/app/models/source_entity.dart';
import 'package:news_app/app/network/api/news_api.dart';
import 'package:news_app/features/news_sources/domain/interface/sources_repository.dart';

class SourcesRepositoryImpl implements SourcesRepository {
  SourcesRepositoryImpl(this.newsApi);

  final NewsApi newsApi;

  @override
  Future<List<SourceEntity>> fetch() async {
    try {
      final res = await newsApi.fetchSources();
      return res;
    } catch (_) {
      throw SourcesFetchException();
    }
  }
}
