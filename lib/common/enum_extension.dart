extension EnumExtension<T extends Enum> on Iterable<T> {
  T byString(String? value, {required T orElse}) {
    return firstWhere(
      (element) => element.name == value,
      orElse: () => orElse,
    );
  }
}
