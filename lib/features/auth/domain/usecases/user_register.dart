import 'package:dartz/dartz.dart';
import 'package:hometake/features/auth/domain/entities/params/user_register_params.dart';
import 'package:hometake/features/auth/domain/entities/user_entity.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/auth_repository.dart';
import '../validators/auth_validators.dart';

export 'package:dartz/dartz.dart' show Either;

export '../../../../core/error/failures.dart'
    show Failure, SingleMessageReturnFailure;
export '../entities/params/user_register_params.dart' show UserRegisterParams;
export '../entities/user_entity.dart' show UserEntity;

class UserRegister implements UseCase<UserEntity, UserRegisterParams> {
  final AuthRepository authRepository;
  UserRegister({required this.authRepository});
  @override
  Future<Either<Failure, UserEntity>> call(UserRegisterParams params) async {
    final String? error =
        validateRegistrationData(
          firstName: params.firstName,
          lastName: params.lastName,
          dob: params.dob,
        ) ??
        validatePhone(params.phone);
    if (error != null) {
      return Left(SingleMessageReturnFailure(message: error));
    }
    return authRepository.registerUser(
      userRegisterParams: UserRegisterParams(
        userId: params.userId,
        firstName: params.firstName.trim(),
        lastName: params.lastName.trim(),
        dob: params.dob.trim(),
        phone: canonicalizePhone(params.phone)!,
      ),
    );
  }
}
