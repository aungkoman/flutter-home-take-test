import 'dart:developer' show log;

import 'package:dartz/dartz.dart';
import 'package:hometake/features/auth/domain/entities/params/user_login_params.dart';
import 'package:hometake/features/auth/domain/entities/user_entity.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/auth_repository.dart';
import '../validators/auth_validators.dart';

export 'package:dartz/dartz.dart' show Either;

export '../../../../core/error/failures.dart'
    show Failure, SingleMessageReturnFailure;
export '../entities/params/user_login_params.dart' show UserLoginParams;
export '../entities/user_entity.dart' show UserEntity;

class UserLoginUseCase implements UseCase<UserEntity, UserLoginParams> {
  final AuthRepository authRepository;
  UserLoginUseCase({required this.authRepository});
  @override
  Future<Either<Failure, UserEntity>> call(
    UserLoginParams userRegisterParams,
  ) async {
    final String? phone = canonicalizePhone(userRegisterParams.phone);
    if (phone == null) {
      return Left(
        SingleMessageReturnFailure(
          message:
              validatePhone(userRegisterParams.phone) ??
              'Phone number is not valid.',
        ),
      );
    }
    log(
      'UserLoginUseCase.call -> ${authRepository.runtimeType}.loginUser '
      '| input UserLoginParams phone=${userRegisterParams.phone}',
      name: 'auth.login',
    );
    final Either<Failure, UserEntity> result = await authRepository.loginUser(
      userLoginParams: UserLoginParams(phone: phone),
    );
    log(
      'UserLoginUseCase.call <- Either<Failure, UserEntity> '
      '| runtime=${result.runtimeType}',
      name: 'auth.login',
    );
    return result;
  }
}
