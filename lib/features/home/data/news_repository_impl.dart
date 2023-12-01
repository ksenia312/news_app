import 'package:dio/dio.dart';
import 'package:news_app/app/models/article_entity.dart';
import 'package:news_app/app/models/news_search_params.dart';
import 'package:news_app/app/network/api/news_api.dart';

import '../domain/interface/news_repository.dart';

class NewsRepositoryImpl implements NewsRepository {
  const NewsRepositoryImpl(this.newsApi);

  final NewsApi newsApi;

  @override
  Future<List<ArticleEntity>> fetch({
    required int count,
    int page = 1,
    NewsSearchParams searchParams = const NewsSearchParams(),
  }) async {
    try {
      final response = await newsApi.fetchArticles(
        bundle: NewsApiQueryBundle(
          pageSize: count,
          page: page,
          searchParams: searchParams,
        ),
      );
      return response;
    } on DioException catch (e) {
      print(e.message);
      if (e.response?.statusCode == 426) {
        throw NewsCompletedException();
      }
      throw NewsFetchException();
    } catch (e) {
      throw NewsFetchException();
    }
  }
}
