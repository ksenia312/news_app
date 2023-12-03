import 'package:news_app/app/models/article_entity.dart';
import 'package:news_app/app/models/news_search_params.dart';

abstract class NewsRepository {
  Future<List<ArticleEntity>> fetch({
    required int count,
    int page = 1,
    NewsSearchParams searchParams = const NewsSearchParams(),
  });
}

class NewsFetchException implements Exception {
  const NewsFetchException({this.message = 'Failed to fetch news'});

  final String message;
}

class NewsCompletedException implements Exception {
  const NewsCompletedException();
}
