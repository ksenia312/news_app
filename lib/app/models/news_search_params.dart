import 'package:news_app/app/models/source_entity.dart';

class NewsSearchParams {
  const NewsSearchParams({
    this.key,
    this.scopes = SearchInScope.values,
    this.sources = const [],
    this.sortBy = SortBy.publishedAt,
  });

  final String? key;

  final List<SearchInScope> scopes;

  final List<SourceEntity> sources;

  final SortBy sortBy;

  NewsSearchParams copyWith({
    String? key,
    List<SearchInScope>? scopes,
    List<SourceEntity>? sources,
    SortBy? sortBy,
  }) {
    return NewsSearchParams(
      key: key ?? this.key,
      scopes: scopes ?? this.scopes,
      sources: sources ?? this.sources,
      sortBy: sortBy ?? this.sortBy,
    );
  }

  Map<String, dynamic> asMap() {
    return {
      if (key != null) 'q': key,
      'sortBy': sortBy.name,
      'searchIn': scopes.map((e) => e.name).join(','),
      'sources': sources.map((e) => e.id).join(','),
    };
  }
}

enum SearchInScope { title, description, content }

enum SortBy { relevancy, popularity, publishedAt }
