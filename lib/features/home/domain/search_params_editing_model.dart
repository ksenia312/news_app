import 'package:flutter/cupertino.dart';
import 'package:news_app/app/models/news_search_params.dart';
import 'package:news_app/app/models/source_entity.dart';

class SearchParamsEditingModel extends ChangeNotifier {
  SearchParamsEditingModel(
    NewsSearchParams initialParams,
  ) : params = initialParams;

  NewsSearchParams params;

  bool hasSource(SourceEntity source) {
    return params.sources.map((e) => e.id).contains(source.id);
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
}
