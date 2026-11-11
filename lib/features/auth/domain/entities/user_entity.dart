import 'member_entity.dart';

class UserEntity {
  int id;
  String firstName;
  String lastName;
  DateTime dob;
  String phone;
  int currentPoints;
  int memberId;
  MemberEntity member;
  DateTime createdAt;
  DateTime updatedAt;

  UserEntity({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.dob,
    required this.phone,
    required this.currentPoints,
    required this.memberId,
    required this.member,
    required this.createdAt,
    required this.updatedAt,
  });

  static UserEntity get sample {
    return UserEntity(
      id: 1,
      firstName: 'Aung',
      lastName: 'Ko Man',
      dob: DateTime(1995, 1, 1),
      phone: '09123456789',
      currentPoints: 100,
      memberId: 1,
      member: MemberEntity.sample,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }
}
