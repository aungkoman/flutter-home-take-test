
import 'package:dartz/dartz.dart';
import 'package:hometake/features/auth/domain/entities/params/user_login_params.dart';
import 'package:hometake/features/auth/domain/entities/params/user_otp_verify_params.dart';
import 'package:hometake/features/auth/domain/entities/params/user_register_params.dart';
import 'package:hometake/features/auth/domain/entities/user_entity.dart';
import '../../../../core/error/failures.dart';

abstract class AuthRepository{
  // actually, it just accept phone number and return user_id, that's all.
  Future<Either<Failure,UserEntity>> loginUser({required UserLoginParams userLoginParams});

  // return full user data.
  Future<Either<Failure,UserEntity>> registerUser({required UserRegisterParams userRegisterParams});

  // post user_id and otp , return Full / Partial Userdata ,
  Future<Either<Failure,UserEntity>> verifyOtp({required UserOtpVerifyParams userOtpVerifyParams});
}