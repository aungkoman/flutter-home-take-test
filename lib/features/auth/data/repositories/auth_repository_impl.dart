import 'dart:developer' show log;

import 'package:dartz/dartz.dart';
import 'package:hometake/core/error/failures.dart';
import 'package:hometake/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:hometake/features/auth/domain/entities/params/user_login_params.dart';
import 'package:hometake/features/auth/domain/entities/params/user_otp_verify_params.dart';
import 'package:hometake/features/auth/domain/entities/params/user_register_params.dart';
import 'package:hometake/features/auth/domain/entities/user_entity.dart';
import 'package:hometake/features/auth/domain/repositories/auth_repository.dart';

import '../../../../core/error/exceptions.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthLocalDatasource authLocalDatasource;

  AuthRepositoryImpl({required this.authLocalDatasource});

  @override
  Future<Either<Failure, UserEntity>> loginUser({
    required UserLoginParams userLoginParams,
  }) async {
    log(
      'AuthRepositoryImpl.loginUser -> ${authLocalDatasource.runtimeType}.loginUser '
      '| input UserLoginParams phone=${userLoginParams.phone}',
      name: 'auth.login',
    );
    try {
      UserEntity user = await authLocalDatasource.loginUser(
        userLoginParams: userLoginParams,
      );
      log(
        'AuthRepositoryImpl.loginUser <- UserEntity '
        '| runtime=${user.runtimeType}, id=${user.id}, '
        'name=${user.firstName} ${user.lastName}, phone=${user.phone}, '
        'tier=${user.member.name}, points=${user.currentPoints}; '
        'return Right<Failure, UserEntity>',
        name: 'auth.login',
      );
      return Right(user);
    } catch (exp, stackTrace) {
      log(
        'AuthRepositoryImpl.loginUser <- exception ${exp.runtimeType}; '
        'return Left<Failure, UserEntity> containing '
        '${exp is SingleMessageReturnException ? "SingleMessageReturnFailure" : "ServerFailure"}',
        name: 'auth.login',
        error: exp is SingleMessageReturnException ? exp.message : exp,
        stackTrace: stackTrace,
      );
      if (exp is PhoneNotRegisteredException) {
        return Left(PhoneNotRegisteredFailure());
      }
      if (exp is SingleMessageReturnException) {
        return Left(SingleMessageReturnFailure(message: exp.message));
      }
      return left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, UserEntity>> registerUser({
    required UserRegisterParams userRegisterParams,
  }) async {
    try {
      UserEntity user = await authLocalDatasource.registerUser(
        userRegisterParams: userRegisterParams,
      );
      return Right(user);
    } catch (exp) {
      if (exp is SingleMessageReturnException) {
        return Left(SingleMessageReturnFailure(message: exp.message));
      }
      return left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, UserEntity>> verifyOtp({
    required UserOtpVerifyParams userOtpVerifyParams,
  }) async {
    try {
      UserEntity user = await authLocalDatasource.verifyOtp(
        userOtpVerifyParams: userOtpVerifyParams,
      );
      return Right(user);
    } catch (exp) {
      if (exp is SingleMessageReturnException) {
        return Left(SingleMessageReturnFailure(message: exp.message));
      }
      return left(ServerFailure());
    }
  }
}
