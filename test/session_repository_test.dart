import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hometake/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:hometake/features/auth/data/datasources/session_local_datasource.dart';
import 'package:hometake/features/auth/data/repositories/session_repository_impl.dart';
import 'package:hometake/features/auth/domain/usecases/session_usecases.dart';

class MemorySession implements SessionLocalDatasource {
  int? userId;
  bool fail = false;
  int clears = 0;

  @override
  Future<int?> readUserId() async {
    if (fail) throw StateError('Storage unavailable');
    return userId;
  }

  @override
  Future<void> writeUserId(int value) async {
    if (fail) throw StateError('Storage unavailable');
    userId = value;
  }

  @override
  Future<void> clear() async {
    if (fail) throw StateError('Storage unavailable');
    userId = null;
    clears++;
  }
}

class StoredUsers implements AuthLocalDatasource {
  final Map<int, UserEntity> users = {};
  bool fail = false;
  int reads = 0;

  @override
  Future<UserEntity?> getUserById({required int userId}) async {
    reads++;
    if (fail) throw StateError('Database unavailable');
    return users[userId];
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('secure session adapter', () {
    const FlutterSecureStorage secureStorage = FlutterSecureStorage();
    late SecureSessionLocalDatasource datasource;
    setUp(() {
      FlutterSecureStorage.setMockInitialValues({});
      datasource = SecureSessionLocalDatasource(storage: secureStorage);
    });

    test('writes and clears only the authenticated user ID', () async {
      await secureStorage.write(key: 'other.setting', value: 'preserve');
      await datasource.writeUserId(42);
      expect(await datasource.readUserId(), 42);
      await datasource.clear();
      expect(await datasource.readUserId(), isNull);
      expect(await secureStorage.read(key: 'other.setting'), 'preserve');
    });

    for (final String invalid in ['not-a-number', '0', '-3']) {
      test('malformed stored ID $invalid is removed', () async {
        await secureStorage.write(key: 'auth.session.user_id', value: invalid);
        expect(await datasource.readUserId(), isNull);
        expect(await secureStorage.read(key: 'auth.session.user_id'), isNull);
      });
    }
  });

  late MemorySession storage;
  late StoredUsers users;
  late SessionRepositoryImpl repository;
  late UserEntity user;

  setUp(() {
    storage = MemorySession();
    users = StoredUsers();
    user = UserEntity.sample;
    user.member.name = 'Gold';
    user.currentPoints = 650;
    users.users[user.id] = user;
    repository = SessionRepositoryImpl(
      authLocalDatasource: users,
      sessionLocalDatasource: storage,
    );
  });

  test('without a stored account, restore returns no session', () async {
    final Either<Failure, UserEntity?> result = await RestoreSession(
      repository: repository,
    )(NoParams());
    expect(result.fold((failure) => failure, (user) => user), isNull);
    expect(users.reads, 0);
  });

  test(
    'a saved session restores the same local profile after recreation',
    () async {
      final SaveSession save = SaveSession(repository: repository);
      expect((await save(user)).isRight(), isTrue);
      final SessionRepositoryImpl restored = SessionRepositoryImpl(
        authLocalDatasource: users,
        sessionLocalDatasource: storage,
      );
      final UserEntity? restoredUser = (await restored.restoreSession()).fold(
        (failure) => throw StateError('Unexpected failure: $failure'),
        (user) => user,
      );
      expect(restoredUser, same(user));
      expect(restoredUser!.member.name, 'Gold');
      expect(restoredUser.currentPoints, 650);
      expect(storage.userId, user.id);
    },
  );

  test(
    'an account deleted from the database clears its stored session',
    () async {
      storage.userId = 99;
      final Either<Failure, UserEntity?> result = await repository
          .restoreSession();
      expect(result.fold((failure) => failure, (user) => user), isNull);
      expect(storage.userId, isNull);
      expect(storage.clears, 1);
    },
  );

  test('invalid stored IDs clear without querying the database', () async {
    storage.userId = -1;
    final Either<Failure, UserEntity?> result = await repository
        .restoreSession();
    expect(result.fold((failure) => failure, (user) => user), isNull);
    expect(users.reads, 0);
    expect(storage.userId, isNull);
  });

  test(
    'an incomplete account cannot be restored as an authenticated session',
    () async {
      user.firstName = ' ';
      storage.userId = user.id;
      final Either<Failure, UserEntity?> result = await repository
          .restoreSession();
      expect(result.fold((failure) => failure, (user) => user), isNull);
      expect(storage.userId, isNull);
    },
  );

  test(
    'save rejects incomplete and invalid accounts without persisting',
    () async {
      user.firstName = '';
      final Either<Failure, void> incomplete = await repository.saveSession(
        user,
      );
      expect(
        incomplete.fold((failure) => failure, (_) => null),
        isA<SingleMessageReturnFailure>(),
      );
      user.firstName = 'Maya';
      user.id = 0;
      expect((await repository.saveSession(user)).isLeft(), isTrue);
      expect(storage.userId, isNull);
    },
  );

  test(
    'logout clears the session and the next restore remains signed out',
    () async {
      await repository.saveSession(user);
      expect(
        (await Logout(repository: repository)(NoParams())).isRight(),
        isTrue,
      );
      expect(storage.userId, isNull);
      expect(
        (await repository.restoreSession()).fold(
          (failure) => failure,
          (user) => user,
        ),
        isNull,
      );
    },
  );

  test(
    'secure-storage errors return typed failures for each operation',
    () async {
      storage.fail = true;
      expect(
        (await repository.restoreSession()).fold(
          (failure) => failure,
          (_) => null,
        ),
        isA<CacheFailure>(),
      );
      expect(
        (await repository.saveSession(user))
            .fold((failure) => failure, (_) => null),
        isA<CacheFailure>(),
      );
      expect(
        (await repository.logout()).fold((failure) => failure, (_) => null),
        isA<CacheFailure>(),
      );
    },
  );

  test(
    'database errors do not silently turn into a signed-out success',
    () async {
      storage.userId = user.id;
      users.fail = true;
      expect(
        (await repository.restoreSession()).fold(
          (failure) => failure,
          (_) => null,
        ),
        isA<CacheFailure>(),
      );
      expect(storage.userId, user.id);
    },
  );
}
