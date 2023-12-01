class SourceEntity {
  const SourceEntity({
    required this.id,
    required this.name,
  });

  final String id;
  final String name;

  factory SourceEntity.fromJson(Map<String, dynamic> json) {
    return SourceEntity(
      id: json['id'] ?? 'Unnamed',
      name: json['title'] ?? 'Unnamed',
    );
  }
}
