enum AppHeroTags {
  articleImage;

  String tagBy(String value) {
    return '${name}_$value';
  }
}
