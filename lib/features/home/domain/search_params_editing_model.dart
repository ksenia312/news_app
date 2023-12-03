import 'package:flutter/cupertino.dart';
import 'package:news_app/app/models/news_search_params.dart';
import 'package:news_app/app/models/source_entity.dart';

class SearchParamsEditingModel extends ChangeNotifier {
  SearchParamsEditingModel(
    this.initialParams, {
    required this.availableSources,
  }) : params = initialParams;

  NewsSearchParams params;
  final NewsSearchParams initialParams;
  final List<SourceEntity> availableSources;

  bool get hasChanges {
    return initialParams != params;
  }

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
    if (hasScope(scope)) {
      scopes.remove(scope);
    } else {
      scopes.add(scope);
    }
    params = params.copyWith(scopes: scopes);
    notifyListeners();
  }

  void toggleSource(SourceEntity source) {
    final sources = [...params.sources];
    if (hasSource(source)) {
      sources.remove(source);
    } else {
      sources.add(source);
    }
    params = params.copyWith(sources: sources);
    notifyListeners();
  }

  String? validate() {
    String? error;

    if (params.sources.isEmpty) {
      error = 'News sources can\'t be empty';
    }
    if (params.scopes.isEmpty) {
      error = '${error != null ? '$error\n' : ''}Search scopes can\'t be empty';
    }
    return error;
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
