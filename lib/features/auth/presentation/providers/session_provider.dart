import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/usecases/session_usecases.dart';
export '../../domain/usecases/session_usecases.dart';

final sessionProvider = AsyncNotifierProvider<SessionNotifier, UserEntity?>(
  () => throw StateError('Provide SessionNotifier in the root ProviderScope.'),
);

class SessionNotifier extends AsyncNotifier<UserEntity?> {
  SessionNotifier({
    required this.restoreSession,
    required this.saveSession,
    required this.logout,
  });
  final RestoreSession restoreSession;
  final SaveSession saveSession;
  final Logout logout;
  bool _busy = false;

  @override
  Future<UserEntity?> build() async {
    final Either<Failure, UserEntity?> result = await restoreSession(
      NoParams(),
    );
    return result.fold<UserEntity?>((failure) => throw failure, (user) => user);
  }

  Future<bool> authenticate(UserEntity user) async {
    if (_busy) return false;
    _busy = true;
    try {
      final Either<Failure, void> result = await saveSession(user);
      if (!ref.mounted) return false;
      return result.fold<bool>(
        (failure) {
          state = AsyncError(failure, StackTrace.current);
          return false;
        },
        (_) {
          state = AsyncData(user);
          return true;
        },
      );
    } finally {
      _busy = false;
    }
  }

  Future<bool> signOut() async {
    if (_busy) return false;
    _busy = true;
    try {
      final Either<Failure, void> result = await logout(NoParams());
      if (!ref.mounted) return false;
      return result.fold<bool>((failure) => false, (_) {
        state = const AsyncData(null);
        return true;
      });
    } finally {
      _busy = false;
    }
  }
}
