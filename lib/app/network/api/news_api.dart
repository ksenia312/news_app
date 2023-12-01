import 'package:dio/dio.dart';
import 'package:news_app/app/models/article_entity.dart';
import 'package:news_app/app/models/news_search_params.dart';
import 'package:news_app/app/models/source_entity.dart';

class NewsApi {
  NewsApi(this.dio);

  static const _everythingPath = '/everything';
  static const _sourcesPath = '/sources';

  final Dio dio;

  Future<List<SourceEntity>> fetchSources() {
    return dio.get(_sourcesPath).then(NewsApiMapper.mapToSources);
  }

  Future<List<ArticleEntity>> fetchArticles({
    required NewsApiQueryBundle bundle,
  }) {
    return dio
        .get(_everythingPath, queryParameters: bundle.asMap())
        .then(NewsApiMapper.mapToArticles);
  }
}

class NewsApiQueryBundle {
  NewsApiQueryBundle({
    required this.pageSize,
    this.page = 1,
    this.searchParams = const NewsSearchParams(),
  });

  final int pageSize;
  final int page;
  final NewsSearchParams searchParams;

  Map<String, dynamic> asMap() {
    return {
      'page': page.toString(),
      'pageSize': pageSize.toString(),
      ...searchParams.asMap(),
    };
  }
}

class NewsApiMapper {
  static List<ArticleEntity> mapToArticles(Response response) {
    final data = response.data as Map;
    final articles = data['articles'] as List;
    return [
      ...articles.map((e) => ArticleEntity.fromJson(e as Map<String, dynamic>)),
    ];
  }

  static List<SourceEntity> mapToSources(Response response) {
    final data = response.data as Map;
    final articles = data['sources'] as List;
    return [
      ...articles.map((e) => SourceEntity.fromJson(e as Map<String, dynamic>)),
    ];
  }
}
