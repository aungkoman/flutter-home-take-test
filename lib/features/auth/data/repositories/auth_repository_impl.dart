import 'package:dartz/dartz.dart';
import 'package:hometake/core/error/failures.dart';
import 'package:hometake/features/auth/domain/entities/params/user_login_params.dart';
import 'package:hometake/features/auth/domain/entities/params/user_otp_verify_params.dart';
import 'package:hometake/features/auth/domain/entities/params/user_register_params.dart';
import 'package:hometake/features/auth/domain/entities/user_entity.dart';
import 'package:hometake/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository{
  @override
  Future<Either<Failure, UserEntity>> loginUser({required UserLoginParams userLoginParams}) {
    // TODO: implement loginUser
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, UserEntity>> registerUser({required UserRegisterParams userRegisterParams}) {
    // TODO: implement registerUser
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, UserEntity>> verifyOtp({required UserOtpVerifyParams userOtpVerifyParams}) {
    // TODO: implement verifyOtp
    throw UnimplementedError();
  }

}