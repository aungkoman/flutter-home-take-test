import 'package:dartz/dartz.dart';
import 'package:hometake/core/error/failures.dart';
import 'package:hometake/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:hometake/features/auth/domain/entities/params/user_login_params.dart';
import 'package:hometake/features/auth/domain/entities/params/user_otp_verify_params.dart';
import 'package:hometake/features/auth/domain/entities/params/user_register_params.dart';
import 'package:hometake/features/auth/domain/entities/user_entity.dart';
import 'package:hometake/features/auth/domain/repositories/auth_repository.dart';

import '../../../../core/error/exceptions.dart';

class AuthRepositoryImpl implements AuthRepository{

  AuthLocalDatasource authLocalDatasource;

  AuthRepositoryImpl({
    required this.authLocalDatasource
  });

  @override
  Future<Either<Failure, UserEntity>> loginUser({required UserLoginParams userLoginParams}) async{
    try{
      UserEntity user = await authLocalDatasource.loginUser(userLoginParams: userLoginParams);
      return Right(user);
    }
    catch(exp){
      if(exp is SingleMessageReturnException){
        return Left(SingleMessageReturnFailure(message: exp.message));
      }
      return left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, UserEntity>> registerUser({required UserRegisterParams userRegisterParams}) async{
    try{
      UserEntity user = await authLocalDatasource.registerUser(userRegisterParams: userRegisterParams);
      return Right(user);
    }
    catch(exp){
      if(exp is SingleMessageReturnException){
        return Left(SingleMessageReturnFailure(message: exp.message));
      }
      return left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, UserEntity>> verifyOtp({required UserOtpVerifyParams userOtpVerifyParams}) async{
    try{
      UserEntity user = await authLocalDatasource.verifyOtp(userOtpVerifyParams: userOtpVerifyParams);
      return Right(user);
    }
    catch(exp){
      if(exp is SingleMessageReturnException){
        return Left(SingleMessageReturnFailure(message: exp.message));
      }
      return left(ServerFailure());
    }
  }

}