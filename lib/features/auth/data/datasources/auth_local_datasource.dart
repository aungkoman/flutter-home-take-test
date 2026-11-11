import 'dart:developer' show log;

import 'package:drift/drift.dart' show BooleanExpressionOperators, Value;

import 'package:hometake/features/auth/domain/entities/user_entity.dart';

import '../../../../core/error/exceptions.dart';
import '../../domain/entities/member_entity.dart';
import '../../domain/entities/params/user_login_params.dart';
import '../../domain/entities/params/user_otp_verify_params.dart';
import '../../domain/entities/params/user_register_params.dart';
import '../database/app_database.dart';

abstract class AuthLocalDatasource{
  Future< UserEntity > loginUser({required UserLoginParams userLoginParams});
  Future<UserEntity?> getUserById({required int userId});
  Future< UserEntity> registerUser({required UserRegisterParams userRegisterParams});
  Future< UserEntity> verifyOtp({required UserOtpVerifyParams userOtpVerifyParams});
}

// TODO: implement this data source  using Database ( drift ) , not API

class AuthLocalDatasourceImpl implements AuthLocalDatasource{
  final AppDatabase db;
  AuthLocalDatasourceImpl({required this.db});

  @override
  Future<UserEntity?> getUserById({required int userId}) async {
    final row = await (db.select(db.users)
      ..where((user) => user.id.equals(userId)))
        .getSingleOrNull();
    return row == null ? null : _toEntity(row);
  }

  @override
  Future<UserEntity> loginUser({required UserLoginParams userLoginParams}) async{

    log(
      'AuthLocalDatasourceImpl.loginUser | input UserLoginParams '
      'phone=${userLoginParams.phone}',
      name: 'auth.login',
    );
    // add delayed of 3 seconds
    await Future.delayed(Duration(seconds: 1));
    final phone = userLoginParams.phone.trim();

    log(
      'AuthLocalDatasourceImpl.loginUser -> AppDatabase.select(users) '
      '| filter phone=$phone | returns Future<User?> (Drift row)',
      name: 'auth.login',
    );
    final row = await (db.select(db.users)
      ..where((u) => u.phone.equals(phone))
      ..limit(1))
        .getSingleOrNull();

    log(
      'AuthLocalDatasourceImpl.loginUser <- User? '
      '| runtime=${row.runtimeType}, id=${row?.id}, '
      'phone=${row?.phone}, memberId=${row?.memberId}',
      name: 'auth.login',
    );
    if (row == null) {
      log(
        'AuthLocalDatasourceImpl.loginUser -> throw SingleMessageReturnException '
        '| Phone number not registered',
        name: 'auth.login',
      );

      // insert new user and return user (id, and empty other data )

      try{
        return await db.transaction(() async {
          final DateTime timestamp = DateTime.now().toUtc();
          await db.customStatement(
            'INSERT INTO users '
                '(first_name, last_name, phone, dob, member_id,current_points, created_at, updated_at) '
                'VALUES (?, ?, ?, ?, ?, ?,?, ?)',
            [
              "",
              "",
              phone,
              null,
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
      } catch(error, stackTrace){
        log(
          'AuthLocalDatasourceImpl.loginUser failed to create user',
          name: 'auth.login',
          error: error,
          stackTrace: stackTrace,
        );

        rethrow;
      }
    }

    log('AuthLocalDatasourceImpl.loginUser -> _toEntity(User)',
        name: 'auth.login');
    final UserEntity user = await _toEntity(row);
    log(
      'AuthLocalDatasourceImpl.loginUser <- UserEntity '
      '| id=${user.id}, name=${user.firstName} ${user.lastName}, '
      'phone=${user.phone}, memberId=${user.memberId}, '
      'tier=${user.member.name}, points=${user.currentPoints}, '
      'dob=${user.dob}, createdAt=${user.createdAt}, updatedAt=${user.updatedAt}',
      name: 'auth.login',
    );
    return user;
  }

  @override
  Future<UserEntity> registerUser({
    required UserRegisterParams userRegisterParams,
  }) async {


    await Future.delayed(Duration(seconds: 2));

    final String firstName = userRegisterParams.firstName.trim();
    final String lastName = userRegisterParams.lastName.trim();
    final String phone = userRegisterParams.phone.trim();
    final DateTime? dob = DateTime.tryParse(userRegisterParams.dob.trim());
    if (firstName.isEmpty || lastName.isEmpty) {
      throw SingleMessageReturnException(
        message: 'First name and last name are required.',
      );
    }
    if (phone.isEmpty) {
      throw SingleMessageReturnException(message: 'Phone number is required.');
    }
    if (dob == null || dob.isAfter(DateTime.now())) {
      throw SingleMessageReturnException(message: 'Date of birth is not valid.');
    }

    return db.transaction(() async {
      final User? existingUser = await (db.select(db.users)
            ..where((u) =>
                u.id.equals(userRegisterParams.userId) & u.phone.equals(phone)))
          .getSingleOrNull();
      if (existingUser == null) {
        throw SingleMessageReturnException(
          message: 'User id and phone number are not registered.',
        );
      }

      await (db.update(db.users)
            ..where((u) => u.id.equals(existingUser.id)))
          .write(
        UsersCompanion(
          firstName: Value(firstName),
          lastName: Value(lastName),
          dob: Value(dob),
          updatedAt: Value(DateTime.now().toUtc()),
        ),
      );

      final User row = await (db.select(db.users)
            ..where((u) => u.id.equals(existingUser.id)))
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
    log(
      'AuthLocalDatasourceImpl._toEntity -> AppDatabase.select(members) '
      '| input User id=${row.id}, memberId=${row.memberId}',
      name: 'auth.login',
    );
    final m = await (db.select(db.members)
      ..where((m) => m.id.equals(row.memberId))
      ..limit(1))
        .getSingleOrNull();

    log(
      'AuthLocalDatasourceImpl._toEntity <- Member? '
      '| runtime=${m.runtimeType}, id=${m?.id}, name=${m?.name}; '
      'mapping User + Member? -> UserEntity + MemberEntity',
      name: 'auth.login',
    );
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