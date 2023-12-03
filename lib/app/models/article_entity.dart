import 'package:freezed_annotation/freezed_annotation.dart';

part 'article_entity.g.dart';

@JsonSerializable(createToJson: false)
class ArticleEntity {
  ArticleEntity({
    required this.title,
    required this.author,
    required this.description,
    required this.url,
    required this.content,
    this.imageUrl,
    this.publishedAt,
  });

  factory ArticleEntity.fromJson(Map<String, dynamic> json) =>
      _$ArticleEntityFromJson(json);

  @JsonKey(defaultValue: _ArticleEmptyField.title)
  final String title;
  @JsonKey(defaultValue: _ArticleEmptyField.author)
  final String author;
  @JsonKey(defaultValue: _ArticleEmptyField.description)
  final String description;
  @JsonKey(defaultValue: _ArticleEmptyField.url)
  final String url;
  @JsonKey(name: 'urlToImage')
  final String? imageUrl;
  final DateTime? publishedAt;
  @JsonKey(defaultValue: _ArticleEmptyField.content)
  final String content;
}

class _ArticleEmptyField {
  static const title = 'No title';
  static const author = 'No author';
  static const description = 'No description';
  static const url = '';
  static const content = 'No content';
}
