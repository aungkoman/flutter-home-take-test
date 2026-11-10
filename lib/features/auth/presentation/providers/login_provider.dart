import 'dart:developer' show log;

import 'package:riverpod/riverpod.dart';

import '../../domain/usecases/user_login_use_case.dart';

export '../../domain/usecases/user_login_use_case.dart' show UserEntity;

final loginProvider = AsyncNotifierProvider<LoginNotifier, UserEntity?>(() {
  throw StateError('Provide LoginNotifier in the root ProviderScope.');
});

class LoginNotifier extends AsyncNotifier<UserEntity?> {
  LoginNotifier(this._userLogin);

  final UserLoginUseCase _userLogin;

  String? get errorMessage => switch (state.error) {
    null => null,
    SingleMessageReturnFailure(:final message) => message,
    _ => 'Could not check your phone number. Try again.',
  };

  // 1. ဒါက state
  @override
  UserEntity? build() => null;

  // 2. state modifier methods တွေ။
  Future<void> login(String phone) async {
    if (state.isLoading) return;

    final Ref loginRef = ref;
    state = const AsyncLoading();

    try {
      final Either<Failure, UserEntity> userEither = await _userLogin(
        UserLoginParams(phone: phone.trim()),
      );
      if (!loginRef.mounted) return;

      state = userEither.fold<AsyncValue<UserEntity?>>((failure) {
        log(
          'Login failed: ${failure.runtimeType}',
          name: 'auth.login',
          error: failure is SingleMessageReturnFailure
              ? failure.message
              : failure,
        );
        return AsyncError(failure, StackTrace.current);
      }, (user) => AsyncData(user));
    } catch (error, stackTrace) {
      log(
        'Login threw an unexpected exception',
        name: 'auth.login',
        error: error,
        stackTrace: stackTrace,
      );
      if (loginRef.mounted) {
        state = AsyncError(error, stackTrace);
      }
    }
  }
}
