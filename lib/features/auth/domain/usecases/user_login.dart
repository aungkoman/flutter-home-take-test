
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:hometake/features/auth/domain/entities/params/user_login_params.dart';
import 'package:hometake/features/auth/domain/entities/user_entity.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/auth_repository.dart';

export 'package:dartz/dartz.dart' show Either;

export '../../../../core/error/failures.dart'
    show Failure, SingleMessageReturnFailure;
export '../entities/params/user_login_params.dart' show UserLoginParams;
export '../entities/user_entity.dart' show UserEntity;


class UserLogin implements UseCase<UserEntity, UserLoginParams>{
  final AuthRepository authRepository;
  UserLogin({required this.authRepository});
  @override
  Future<Either<Failure, UserEntity>> call(UserLoginParams userRegisterParams) {
    return authRepository.loginUser(userLoginParams: userRegisterParams);
  }
}

