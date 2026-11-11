import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/member_entity.dart';
part 'member_model.g.dart';

@JsonSerializable(explicitToJson: true)
class MemberModel {
  @JsonKey(name: 'id', defaultValue: 0)
  final int id;

  @JsonKey(name: 'name', defaultValue: '')
  final String name;

  @JsonKey(name: 'description', defaultValue: '')
  final String description;

  @JsonKey(name: 'image_url', defaultValue: '')
  final String imageUrl;

  @JsonKey(name: 'member_points', defaultValue: 0)
  final int memberPoints;

  @JsonKey(name: 'created_at', defaultValue: '')
  final String createdAt;

  @JsonKey(name: 'updated_at', defaultValue: '')
  final String updatedAt;

  MemberModel({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.memberPoints,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MemberModel.fromJson(Map<String, dynamic> json) =>
      _$MemberModelFromJson(json);

  Map<String, dynamic> toJson() => _$MemberModelToJson(this);

  MemberEntity toEntity() => MemberEntity(
    id: id,
    name: name,
    description: description,
    imageUrl: imageUrl,
    memberPoints: memberPoints,
    createdAt: _parseDate(createdAt),
    updatedAt: _parseDate(updatedAt),
  );

  /// Never throws. Returns epoch on bad/null/empty input.
  static DateTime _parseDate(String? value) {
    if (value == null || value.isEmpty) {
      return DateTime.fromMillisecondsSinceEpoch(0);
    }
    return DateTime.tryParse(value) ?? DateTime.fromMillisecondsSinceEpoch(0);
  }
}
