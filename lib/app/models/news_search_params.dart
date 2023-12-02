import 'package:equatable/equatable.dart';
import 'package:news_app/app/models/source_entity.dart';

class NewsSearchParams extends Equatable {
  const NewsSearchParams({
    this.key,
    this.scopes = defaultScopes,
    this.sortBy = defaultSortBy,
    this.sources = const [],
  });

  static const defaultScopes = [SearchInScope.title];
  static const defaultSortBy = SortBy.relevancy;

  static List<SourceEntity>? defaultSourceFrom(
    List<SourceEntity> availableSources,
  ) =>
      availableSources.isNotEmpty ? [availableSources.first] : null;

  final String? key;

  final List<SearchInScope> scopes;

  final List<SourceEntity> sources;

  final SortBy sortBy;

  @override
  List<Object?> get props => [key, sources, scopes, sortBy];

  bool get isNotEmpty {
    return key != null || key!.isNotEmpty;
  }

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
      if (key != null && key!.isNotEmpty) 'q': key,
      'sortBy': sortBy.name,
      'searchIn': scopes.map((e) => e.name).join(','),
      'sources': sources.map((e) => e.id).join(','),
    };
  }
}

enum SearchInScope { title, description, content }

enum SortBy {
  relevancy('Relevance'),
  popularity('Popularity'),
  publishedAt('Published at');

  const SortBy(this.title);

  final String title;
}
