import 'package:flutter/cupertino.dart';
import 'package:news_app/app/models/news_search_params.dart';
import 'package:news_app/app/models/source_entity.dart';

class SearchParamsEditingModel extends ChangeNotifier {
  SearchParamsEditingModel(
    NewsSearchParams initialParams, {
    required this.availableSources,
  }) : params = initialParams;

  NewsSearchParams params;
  final List<SourceEntity> availableSources;

  bool hasScope(SearchInScope scope) {
    return params.scopes.contains(scope);
  }

  bool hasSource(SourceEntity source) {
    return params.sources.map((e) => e.id).contains(source.id);
  }

  void setSort(SortBy sortBy) {
    params = params.copyWith(sortBy: sortBy);
    notifyListeners();
  }

  void toggleScope(SearchInScope scope) {
    final scopes = [...params.scopes];
    if (hasScope(scope) && scopes.length != 1) {
      scopes.remove(scope);
    } else {
      scopes.add(scope);
    }
    params = params.copyWith(scopes: scopes);
    notifyListeners();
  }

  void toggleSource(SourceEntity source) {
    final sources = [...params.sources];
    if (hasSource(source) && sources.length != 1) {
      sources.remove(source);
    } else {
      sources.add(source);
    }
    params = params.copyWith(sources: sources);
    notifyListeners();
  }

  void reset() {
    params = params.copyWith(
      scopes: NewsSearchParams.defaultScopes,
      sources: NewsSearchParams.defaultSourceFrom(availableSources),
      sortBy: NewsSearchParams.defaultSortBy,
    );
    notifyListeners();
  }
}
