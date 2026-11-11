import 'dart:developer' show log;

import 'package:riverpod/riverpod.dart';

import '../../domain/usecases/user_login_use_case.dart';

export '../../domain/usecases/user_login_use_case.dart'
    show UserEntity, AuthEntryMode;

final loginProvider = AsyncNotifierProvider<LoginNotifier, UserEntity?>(() {
  throw StateError('Provide LoginNotifier in the root ProviderScope.');
});

class LoginNotifier extends AsyncNotifier<UserEntity?> {
  LoginNotifier(this._userLogin);

  final UserLoginUseCase _userLogin;
  AuthEntryMode? requestedMode;
  bool get isUnregisteredPhone => state.error is PhoneNotRegisteredFailure;

  String? get errorMessage => switch (state.error) {
    null => null,
    SingleMessageReturnFailure(:final message) => message,
    _ => 'Could not check your phone number. Try again.',
  };

  // 1. ဒါက state
  @override
  UserEntity? build() => null;

  // 2. state modifier methods တွေ။
  Future<void> login(
    String phone, {
    AuthEntryMode mode = AuthEntryMode.login,
  }) async {
    if (state.isLoading) {
      log(
        'LoginNotifier.login: ignored duplicate submit while loading',
        name: 'auth.login',
      );
      return;
    }
    log('LoginNotifier.login | input String phone=$phone', name: 'auth.login');

    requestedMode = mode;
    final Ref loginRef = ref;
    state = const AsyncLoading();
    log(
      'LoginNotifier.login -> state AsyncLoading<UserEntity?>',
      name: 'auth.login',
    );

    try {
      log(
        'LoginNotifier.login -> UserLoginUseCase.call | input UserLoginParams',
        name: 'auth.login',
      );
      final Either<Failure, UserEntity> userEither = await _userLogin(
        UserLoginParams(phone: phone.trim(), mode: mode),
      );
      log(
        'LoginNotifier.login <- Either<Failure, UserEntity> '
        '| runtime=${userEither.runtimeType}',
        name: 'auth.login',
      );
      if (!loginRef.mounted) {
        log(
          'LoginNotifier.login: result received after disposal; state skipped',
          name: 'auth.login',
        );
        return;
      }

      state = userEither.fold<AsyncValue<UserEntity?>>(
        (failure) {
          log(
            'Login failed: ${failure.runtimeType}',
            name: 'auth.login',
            error: failure is SingleMessageReturnFailure
                ? failure.message
                : failure,
          );
          return AsyncError(failure, StackTrace.current);
        },
        (user) {
          log(
            'LoginNotifier.login -> AsyncData<UserEntity?> '
            '| userId=${user.id}, phone=${user.phone}, '
            'tier=${user.member.name}, points=${user.currentPoints}',
            name: 'auth.login',
          );
          return AsyncData(user);
        },
      );
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
