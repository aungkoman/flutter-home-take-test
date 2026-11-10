// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
  id: (json['id'] as num?)?.toInt() ?? 0,
  firstName: json['first_name'] as String? ?? '',
  lastName: json['last_name'] as String? ?? '',
  dob: _dateFromJson(json['dob']),
  phone: json['phone'] as String? ?? '',
  currentPoints: (json['current_points'] as num?)?.toInt() ?? 0,
  member: _memberFromJson(json['member']),
  memberId: (json['member_id'] as num?)?.toInt() ?? 0,
  createdAt: _dateFromJson(json['created_at']),
  updatedAt: _dateFromJson(json['updated_at']),
);

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
  'id': instance.id,
  'first_name': instance.firstName,
  'last_name': instance.lastName,
  'dob': instance.dob.toIso8601String(),
  'phone': instance.phone,
  'current_points': instance.currentPoints,
  'created_at': instance.createdAt.toIso8601String(),
  'updated_at': instance.updatedAt.toIso8601String(),
  'member_id': instance.memberId,
  'member': _memberToJson(instance.member),
};
