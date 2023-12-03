import 'package:freezed_annotation/freezed_annotation.dart';

part 'source_entity.g.dart';

@JsonSerializable(createToJson: false)
class SourceEntity {
  const SourceEntity({
    required this.id,
    required this.name,
  });

  factory SourceEntity.fromJson(Map<String, dynamic> json) =>
      _$SourceEntityFromJson(json);

  static const fieldKey = 'source';

  final String id;
  final String name;
}
