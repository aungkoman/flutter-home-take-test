import 'package:hometake/features/auth/domain/entities/user_entity.dart';

import '../../../../core/error/exceptions.dart';
import '../../domain/entities/member_entity.dart';
import '../../domain/entities/params/user_login_params.dart';
import '../../domain/entities/params/user_otp_verify_params.dart';
import '../../domain/entities/params/user_register_params.dart';
import '../database/app_database.dart';

abstract class AuthLocalDatasource{
  Future< UserEntity > loginUser({required UserLoginParams userLoginParams});
  Future< UserEntity> registerUser({required UserRegisterParams userRegisterParams});
  Future< UserEntity> verifyOtp({required UserOtpVerifyParams userOtpVerifyParams});
}

// TODO: implement this data source  using Database ( drift ) , not API

class AuthLocalDatasourceImpl implements AuthLocalDatasource{
  final AppDatabase db;
  AuthLocalDatasourceImpl({required this.db});

  @override
  Future<UserEntity> loginUser({required UserLoginParams userLoginParams}) async{

    // add delayed of 3 seconds
    await Future.delayed(Duration(seconds: 1));
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
  Future<UserEntity> registerUser({
    required UserRegisterParams userRegisterParams,
  }) async {
    final String phone = userRegisterParams.phone.trim();
    final DateTime? dob = DateTime.tryParse(userRegisterParams.dob.trim());
    if (phone.isEmpty) {
      throw SingleMessageReturnException(message: 'Phone number is required.');
    }
    if (dob == null) {
      throw SingleMessageReturnException(message: 'Date of birth is not valid.');
    }

    return db.transaction(() async {
      final User? existingUser = await (db.select(db.users)
            ..where((u) => u.phone.equals(phone))
            ..limit(1))
          .getSingleOrNull();
      if (existingUser != null) {
        throw SingleMessageReturnException(
          message: 'Phone number is already registered.',
        );
      }



      final DateTime timestamp = DateTime.now().toUtc();
      await db.customStatement(
        'INSERT INTO users '
        '(first_name, last_name, phone, dob, member_id,current_points, created_at, updated_at) '
        'VALUES (?, ?, ?, ?, ?, ?, ?)',
        [
          userRegisterParams.firstName.trim(),
          userRegisterParams.lastName.trim(),
          phone,
          db.typeMapping.mapToSqlVariable(dob),
          1, // silver as default
          0, // zero as default
          db.typeMapping.mapToSqlVariable(timestamp),
          db.typeMapping.mapToSqlVariable(timestamp),
        ],
      );
      db.markTablesUpdated({db.users});

      final User row = await (db.select(db.users)
            ..where((u) => u.phone.equals(phone)))
          .getSingle();
      return _toEntity(row);
    });
  }

  @override
  Future<UserEntity> verifyOtp({required UserOtpVerifyParams userOtpVerifyParams}) async{
    await Future.delayed(Duration(seconds: 1));
    if (userOtpVerifyParams.otpCode.trim() != "123456"){
      throw SingleMessageReturnException(message: "OTP Code is not valid.");
    }
    final int userId = userOtpVerifyParams.userId;

    final row = await (db.select(db.users)
      ..where((u) => u.id.equals(userId))
      ..limit(1))
        .getSingleOrNull();

    if (row == null) {
      throw SingleMessageReturnException(
        message: 'User id number not registered',
      );
    }


    return _toEntity(row);
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