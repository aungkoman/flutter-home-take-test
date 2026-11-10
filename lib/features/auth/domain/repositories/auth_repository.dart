
import 'package:dartz/dartz.dart';
import 'package:hometake/features/auth/domain/entities/params/user_login_params.dart';
import 'package:hometake/features/auth/domain/entities/params/user_register_params.dart';
import 'package:hometake/features/auth/domain/entities/user_entity.dart';
import '../../../../core/error/failures.dart';

abstract class UserRepository{
  Future<Either<Failure,UserEntity>> loginUser({required UserLoginParams userLoginParams});

  Future<Either<Failure,UserEntity>> registerUser({required UserRegisterParams userRegisterParams});
}