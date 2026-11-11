import 'dart:developer' show log;

import 'package:riverpod/riverpod.dart';

import '../../domain/usecases/user_register.dart';

export '../../domain/usecases/user_register.dart' show UserEntity;

final registerProvider = AsyncNotifierProvider<RegisterNotifier, UserEntity?>(
  () {
    throw StateError('Provide RegisterNotifier in the root ProviderScope.');
  },
);

class RegisterNotifier extends AsyncNotifier<UserEntity?> {
  RegisterNotifier(this._userRegister);

  final UserRegister _userRegister;

  String? get errorMessage => switch (state.error) {
    null => null,
    SingleMessageReturnFailure(:final message) => message,
    _ => 'Could not register your account. Try again.',
  };

  // 1. ဒါက state
  @override
  UserEntity? build() => null;

  // 2. state modifier methods တွေ။
  Future<void> register({
    required int userId,
    required String firstName,
    required String lastName,
    required String dob,
    required String phone,
  }) async {
    if (state.isLoading) return;

    final Ref registerRef = ref;
    state = const AsyncLoading();

    try {
      final Either<Failure, UserEntity> userEither = await _userRegister(
        UserRegisterParams(
          userId: userId,
          firstName: firstName.trim(),
          lastName: lastName.trim(),
          dob: dob.trim(),
          phone: phone.trim(),
        ),
      );
      if (!registerRef.mounted) return;

      state = userEither.fold<AsyncValue<UserEntity?>>((failure) {
        log(
          'Registration failed: ${failure.runtimeType}',
          name: 'auth.register',
          error: failure is SingleMessageReturnFailure
              ? failure.message
              : failure,
        );
        return AsyncError(failure, StackTrace.current);
      }, (user) => AsyncData(user));
    } catch (error, stackTrace) {
      log(
        'Registration threw an unexpected exception',
        name: 'auth.register',
        error: error,
        stackTrace: stackTrace,
      );
      if (registerRef.mounted) {
        state = AsyncError(error, stackTrace);
      }
    }
  }
}
