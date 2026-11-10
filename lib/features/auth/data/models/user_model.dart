import 'package:hometake/features/auth/domain/entities/user_entity.dart';
import 'package:json_annotation/json_annotation.dart';
import 'member_model.dart';
import '../../domain/entities/member_entity.dart';

part 'user_model.g.dart';
@JsonSerializable(explicitToJson: true)
class UserModel {

  @JsonKey(name: 'id', defaultValue: 0)
  int id;

  @JsonKey(name: 'first_name', defaultValue: '')
  String firstName;

  @JsonKey(name: 'last_name', defaultValue: '')
  String lastName;

  @JsonKey(name: 'dob', fromJson: _dateFromJson )
  DateTime dob;

  @JsonKey(name: 'phone', defaultValue: '')
  String phone;

  @JsonKey(name: 'current_points', defaultValue: 0)
  int currentPoints;

  @JsonKey(name: 'created_at', fromJson: _dateFromJson )
  DateTime createdAt;

  @JsonKey(name: 'updated_at', fromJson: _dateFromJson )
  DateTime updatedAt;

  @JsonKey(name: 'member_id', defaultValue: 0)
  int memberId;

  @JsonKey(name: 'member', fromJson: _memberFromJson, toJson: _memberToJson)
  MemberModel? member;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.dob,
    required this.phone,
    required this.currentPoints,
    required this.member,
    required this.memberId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return _$UserModelFromJson(json);
  }
  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  UserEntity toEntity(){
    return UserEntity(id: id, firstName: firstName, lastName: lastName, dob: dob, phone: phone, currentPoints: currentPoints, memberId: memberId,
        member:  MemberEntity.sample,
        createdAt: createdAt, updatedAt: updatedAt);
  }
}

DateTime _dateFromJson(Object? v) =>
    DateTime.tryParse(v?.toString() ?? '') ??
        DateTime.fromMillisecondsSinceEpoch(0);

MemberModel? _memberFromJson(Object? v) =>
    v is Map<String, dynamic> ? MemberModel.fromJson(v) : null;

Object? _memberToJson(MemberModel? m) => m?.toJson();
