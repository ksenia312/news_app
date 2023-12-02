extension UpperCaseExtension on String {
  String get capitalizeFirst {
    if (isEmpty) {
      return this;
    }
    return replaceRange(0, 1, this[0].toUpperCase());
  }
}
