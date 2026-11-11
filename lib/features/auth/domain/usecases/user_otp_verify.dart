import 'package:dartz/dartz.dart';
import 'package:hometake/features/auth/domain/entities/params/user_otp_verify_params.dart';
import 'package:hometake/features/auth/domain/entities/user_entity.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/auth_repository.dart';

export 'package:dartz/dartz.dart' show Either;

export '../../../../core/error/failures.dart'
    show Failure, SingleMessageReturnFailure;
export '../entities/params/user_otp_verify_params.dart'
    show UserOtpVerifyParams;
export '../entities/user_entity.dart' show UserEntity;

class UserOtpVerify implements UseCase<UserEntity, UserOtpVerifyParams> {
  final AuthRepository authRepository;
  UserOtpVerify({required this.authRepository});
  @override
  Future<Either<Failure, UserEntity>> call(
    UserOtpVerifyParams userOtpVerifyParams,
  ) {
    return authRepository.verifyOtp(userOtpVerifyParams: userOtpVerifyParams);
  }
}
