import 'package:hometake/features/auth/domain/entities/user_entity.dart';

import '../../../../core/error/exceptions.dart';
import '../../domain/entities/member_entity.dart';
import '../../domain/entities/params/user_login_params.dart';
import '../../domain/entities/params/user_otp_verify_params.dart';
import '../../domain/entities/params/user_register_params.dart';
import '../database/app_database.dart';

abstract class AuthRemoteDatasource{
  Future< UserEntity > loginUser({required UserLoginParams userLoginParams});
  Future< UserEntity> registerUser({required UserRegisterParams userRegisterParams});
  Future< UserEntity> verifyOtp({required UserOtpVerifyParams userOtpVerifyParams});
}

// TODO: implement this data source  using Database ( drift ) , not API

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource{
  final AppDatabase db;
  AuthRemoteDatasourceImpl({required this.db});

  @override
  Future<UserEntity> loginUser({required UserLoginParams userLoginParams}) async{
    final phone = userLoginParams.phone.trim();

    final row = await (db.select(db.users)
      ..where((u) => u.phone.equals(phone))
      ..limit(1))
        .getSingleOrNull();

    if (row == null) {
      throw SingleMessageReturnException(
        message: 'Phone number not registered',
      );
    }

    return _toEntity(row);
  }

  @override
  Future<UserEntity> registerUser({required UserRegisterParams userRegisterParams}) {
    // TODO: implement registerUser
    throw UnimplementedError();
  }

  @override
  Future<UserEntity> verifyOtp({required UserOtpVerifyParams userOtpVerifyParams}) {
    // TODO: implement verifyOtp
    throw UnimplementedError();
  }
  Future<UserEntity> _toEntity(User row) async {
    final m = await (db.select(db.members)
      ..where((m) => m.id.equals(row.memberId))
      ..limit(1))
        .getSingleOrNull();

    return UserEntity(
      id: row.id,
      firstName: row.firstName,
      lastName: row.lastName,
      dob: row.dob ?? DateTime.fromMillisecondsSinceEpoch(0),
      phone: row.phone,
      currentPoints: row.currentPoints,
      memberId: row.memberId,
      member: MemberEntity(
        id: m?.id ?? 0,
        name: m?.name ?? '',
        description: m?.description ?? '',
        imageUrl: m?.imageUrl ?? '',
        memberPoints: m?.memberPoints ?? 0,
        createdAt: m?.createdAt ?? DateTime.fromMillisecondsSinceEpoch(0),
        updatedAt: m?.updatedAt ?? DateTime.fromMillisecondsSinceEpoch(0),
      ),
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
    );
  }
}