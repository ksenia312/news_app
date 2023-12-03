enum AppHeroTags {
  articleTitle,
  articleImage;

  String tagBy(String value) {
    return '${name}_$value';
  }
}
