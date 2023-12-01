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

  factory ArticleEntity.fromJson(Map<String, dynamic> json) {
    final rawDateTime = json['publishedAt'];
    final publishedAt =
        rawDateTime != null ? DateTime.tryParse(json['publishedAt']) : null;
    return ArticleEntity(
      title: json['title'] ?? 'Unnamed',
      author: json['author'] ?? '',
      description: json['description'] ?? '',
      url: json['url'] ?? '',
      imageUrl: json['urlToImage'],
      publishedAt: publishedAt,
      content: json['content'] ?? '',
    );
  }

  final String title;
  final String author;
  final String description;
  final String url;
  final String? imageUrl;
  final DateTime? publishedAt;
  final String content;
}
