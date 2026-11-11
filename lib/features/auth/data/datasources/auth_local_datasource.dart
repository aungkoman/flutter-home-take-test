import 'dart:developer' show log;

import 'package:drift/drift.dart' show Value;

import 'package:hometake/features/auth/domain/entities/user_entity.dart';

import '../../../../core/error/exceptions.dart';
import '../../domain/entities/member_entity.dart';
import '../../domain/validators/auth_validators.dart';
import '../../domain/entities/params/user_login_params.dart';
import '../../domain/entities/params/user_otp_verify_params.dart';
import '../../domain/entities/params/user_register_params.dart';
import '../database/app_database.dart';

abstract class AuthLocalDatasource {
  Future<UserEntity> loginUser({required UserLoginParams userLoginParams});
  Future<UserEntity?> getUserById({required int userId});
  Future<UserEntity> registerUser({
    required UserRegisterParams userRegisterParams,
  });
  Future<UserEntity> verifyOtp({
    required UserOtpVerifyParams userOtpVerifyParams,
  });
}

// TODO: implement this data source  using Database ( drift ) , not API

class AuthLocalDatasourceImpl implements AuthLocalDatasource {
  final AppDatabase db;
  AuthLocalDatasourceImpl({required this.db});

  @override
  Future<UserEntity?> getUserById({required int userId}) async {
    final row = await (db.select(
      db.users,
    )..where((user) => user.id.equals(userId))).getSingleOrNull();
    return row == null ? null : _toEntity(row);
  }

  @override
  Future<UserEntity> loginUser({
    required UserLoginParams userLoginParams,
  }) async {
    final String? phone = canonicalizePhone(userLoginParams.phone);
    if (phone == null) {
      throw SingleMessageReturnException(
        message:
            validatePhone(userLoginParams.phone) ??
            'Phone number is not valid.',
      );
    }
    await Future<void>.delayed(const Duration(seconds: 1));
    return db.transaction(() async {
      // Older installations may store the local or formatted phone.
      final List<User> rows = await db.select(db.users).get();
      final List<User> matches =
          rows.where((row) => canonicalizePhone(row.phone) == phone).toList()
            ..sort((a, b) {
              final bool aComplete = a.firstName.trim().isNotEmpty;
              final bool bComplete = b.firstName.trim().isNotEmpty;
              if (aComplete != bComplete) return aComplete ? -1 : 1;
              return a.id.compareTo(b.id);
            });
      if (matches.isNotEmpty) {
        final User existing = matches.first;
        if (matches.length == 1 && existing.phone != phone) {
          await (db.update(db.users)
                ..where((row) => row.id.equals(existing.id)))
              .write(UsersCompanion(phone: Value(phone)));
        }
        final User row = await (db.select(
          db.users,
        )..where((row) => row.id.equals(existing.id))).getSingle();
        return _toEntity(row);
      }
      final DateTime timestamp = DateTime.now().toUtc();
      final int id = await db
          .into(db.users)
          .insert(
            UsersCompanion.insert(
              phone: Value(phone),
              memberId: const Value(1),
              createdAt: timestamp,
              updatedAt: timestamp,
            ),
          );
      final User row = await (db.select(
        db.users,
      )..where((row) => row.id.equals(id))).getSingle();
      log(
        'AuthLocalDatasourceImpl.loginUser created pending account id=$id',
        name: 'auth.login',
      );
      return _toEntity(row);
    });
  }

  @override
  Future<UserEntity> registerUser({
    required UserRegisterParams userRegisterParams,
  }) async {
    await Future.delayed(Duration(seconds: 2));

    final String firstName = userRegisterParams.firstName.trim();
    final String lastName = userRegisterParams.lastName.trim();
    final String? phone = canonicalizePhone(userRegisterParams.phone);
    final DateTime? dob = DateTime.tryParse(userRegisterParams.dob.trim());
    if (firstName.isEmpty || lastName.isEmpty) {
      throw SingleMessageReturnException(
        message: 'First name and last name are required.',
      );
    }
    if (phone == null) {
      throw SingleMessageReturnException(message: 'Phone number is required.');
    }
    if (dob == null || dob.isAfter(DateTime.now())) {
      throw SingleMessageReturnException(
        message: 'Date of birth is not valid.',
      );
    }

    return db.transaction(() async {
      final User? existingUser =
          await (db.select(db.users)
                ..where((u) => u.id.equals(userRegisterParams.userId)))
              .getSingleOrNull();
      if (existingUser == null ||
          canonicalizePhone(existingUser.phone) != phone) {
        throw SingleMessageReturnException(
          message: 'User id and phone number are not registered.',
        );
      }

      await (db.update(
        db.users,
      )..where((u) => u.id.equals(existingUser.id))).write(
        UsersCompanion(
          phone: Value(phone),
          firstName: Value(firstName),
          lastName: Value(lastName),
          dob: Value(dob),
          updatedAt: Value(DateTime.now().toUtc()),
        ),
      );

      final User row = await (db.select(
        db.users,
      )..where((u) => u.id.equals(existingUser.id))).getSingle();
      return _toEntity(row);
    });
  }

  @override
  Future<UserEntity> verifyOtp({
    required UserOtpVerifyParams userOtpVerifyParams,
  }) async {
    await Future.delayed(Duration(seconds: 1));
    if (userOtpVerifyParams.otpCode.trim() != "123456") {
      throw SingleMessageReturnException(message: "OTP Code is not valid.");
    }
    final int userId = userOtpVerifyParams.userId;

    final row =
        await (db.select(db.users)
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
    final m =
        await (db.select(db.members)
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
