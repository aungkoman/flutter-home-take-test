import 'dart:developer' show log;

import 'package:riverpod/riverpod.dart';

import '../../domain/usecases/user_otp_verify.dart';

export '../../domain/usecases/user_otp_verify.dart' show UserEntity;

final otpVerifyProvider = AsyncNotifierProvider<OtpVerifyNotifier, UserEntity?>(
  () {
    throw StateError('Provide OtpVerifyNotifier in the root ProviderScope.');
  },
);

class OtpVerifyNotifier extends AsyncNotifier<UserEntity?> {
  OtpVerifyNotifier(this._userOtpVerify);

  final UserOtpVerify _userOtpVerify;

  String? get errorMessage => switch (state.error) {
    null => null,
    SingleMessageReturnFailure(:final message) => message,
    _ => 'Could not verify your code. Try again.',
  };

  // 1. ဒါက state
  @override
  UserEntity? build() => null;

  // 2. state modifier methods တွေ။
  Future<void> verifyOtp({required int userId, required String otpCode}) async {
    if (state.isLoading) return;

    final Ref otpRef = ref;
    state = const AsyncLoading();

    try {
      final Either<Failure, UserEntity> userEither = await _userOtpVerify(
        UserOtpVerifyParams(userId: userId, otpCode: otpCode.trim()),
      );
      if (!otpRef.mounted) return;

      state = userEither.fold<AsyncValue<UserEntity?>>((failure) {
        log(
          'OTP verification failed: ${failure.runtimeType}',
          name: 'auth.otp_verify',
          error: failure is SingleMessageReturnFailure
              ? failure.message
              : failure,
        );
        return AsyncError(failure, StackTrace.current);
      }, (user) => AsyncData(user));
    } catch (error, stackTrace) {
      log(
        'OTP verification threw an unexpected exception',
        name: 'auth.otp_verify',
        error: error,
        stackTrace: stackTrace,
      );
      if (otpRef.mounted) {
        state = AsyncError(error, stackTrace);
      }
    }
  }
}
