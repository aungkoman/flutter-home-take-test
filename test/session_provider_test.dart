import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hometake/features/auth/presentation/providers/session_provider.dart';
import 'package:hometake/features/auth/presentation/providers/current_user_provider.dart';
import 'package:hometake/features/auth/presentation/session_redirect.dart';

class MemorySession implements SessionRepository {
  UserEntity? saved;
  bool failLogout = false;
  @override
  Future<Either<Failure, UserEntity?>> restoreSession() async => Right(saved);
  @override
  Future<Either<Failure, void>> saveSession(UserEntity user) async {
    saved = user;
    return const Right(null);
  }

  @override
  Future<Either<Failure, void>> logout() async {
    if (failLogout) return Left(CacheFailure());
    saved = null;
    return const Right(null);
  }
}

void main() {
  test(
    'authenticated user is restored and logout clears shared user state',
    () async {
      final MemorySession repository = MemorySession()
        ..saved = UserEntity.sample;
      final ProviderContainer container = ProviderContainer(
        overrides: [
          sessionProvider.overrideWith(
            () => SessionNotifier(
              restoreSession: RestoreSession(repository: repository),
              saveSession: SaveSession(repository: repository),
              logout: Logout(repository: repository),
            ),
          ),
        ],
      );
      addTearDown(container.dispose);
      expect(
        (await container.read(sessionProvider.future))?.id,
        repository.saved?.id,
      );
      expect(container.read(currentUserProvider)?.id, repository.saved?.id);
      expect(await container.read(sessionProvider.notifier).signOut(), isTrue);
      expect(container.read(currentUserProvider), isNull);
      expect(repository.saved, isNull);
    },
  );
  test('failed logout retains authenticated state', () async {
    final MemorySession repository = MemorySession()
      ..saved = UserEntity.sample
      ..failLogout = true;
    final ProviderContainer container = ProviderContainer(
      overrides: [
        sessionProvider.overrideWith(
          () => SessionNotifier(
            restoreSession: RestoreSession(repository: repository),
            saveSession: SaveSession(repository: repository),
            logout: Logout(repository: repository),
          ),
        ),
      ],
    );
    addTearDown(container.dispose);
    await container.read(sessionProvider.future);
    expect(await container.read(sessionProvider.notifier).signOut(), isFalse);
    expect(container.read(currentUserProvider), isNotNull);
  });
  test('save updates the session and protected route guard', () async {
    final MemorySession repository = MemorySession();
    final ProviderContainer container = ProviderContainer(
      overrides: [
        sessionProvider.overrideWith(
          () => SessionNotifier(
            restoreSession: RestoreSession(repository: repository),
            saveSession: SaveSession(repository: repository),
            logout: Logout(repository: repository),
          ),
        ),
      ],
    );
    addTearDown(container.dispose);
    await container.read(sessionProvider.future);
    expect(sessionRedirect(container.read(sessionProvider), '/home'), '/');
    expect(
      await container
          .read(sessionProvider.notifier)
          .authenticate(UserEntity.sample),
      isTrue,
    );
    expect(sessionRedirect(container.read(sessionProvider), '/'), '/home');
    expect(
      sessionRedirect(container.read(sessionProvider), '/home/products/8'),
      isNull,
    );
    expect(
      sessionRedirect(container.read(sessionProvider), '/welcome'),
      isNull,
    );
  });
  test('guard waits for restoration and keeps failures on retry screen', () {
    expect(sessionRedirect(const AsyncLoading(), '/home'), '/session');
    expect(
      sessionRedirect(AsyncError(CacheFailure(), StackTrace.current), '/home'),
      '/session',
    );
    expect(
      sessionRedirect(const AsyncData<UserEntity?>(null), '/login'),
      isNull,
    );
    expect(sessionRedirect(const AsyncData<UserEntity?>(null), '/reward'), '/');
  });
}
