import 'package:dartz/dartz.dart' show Right;
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hometake/core/error/exceptions.dart';
import 'package:hometake/features/auth/data/database/app_database.dart';
import 'package:hometake/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:hometake/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:hometake/features/auth/domain/repositories/auth_repository.dart';
import 'package:hometake/features/auth/domain/usecases/user_login_use_case.dart';

class RecordingAuth implements AuthRepository {
  int calls = 0;
  UserLoginParams? lastParams;

  @override
  Future<Either<Failure, UserEntity>> loginUser({
    required UserLoginParams userLoginParams,
  }) async {
    calls++;
    lastParams = userLoginParams;
    return Right(UserEntity.sample);
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  late AppDatabase db;
  late AuthLocalDatasourceImpl datasource;
  late AuthRepositoryImpl repository;
  final DateTime timestamp = DateTime.utc(2026, 1, 1);

  Future<int> insertUser(String phone, {String firstName = 'Maya'}) => db
      .into(db.users)
      .insert(
        UsersCompanion.insert(
          firstName: Value(firstName),
          lastName: const Value('Lin'),
          phone: Value(phone),
          memberId: const Value(1),
          createdAt: timestamp,
          updatedAt: timestamp,
        ),
      );

  setUp(() async {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    datasource = AuthLocalDatasourceImpl(db: db);
    repository = AuthRepositoryImpl(authLocalDatasource: datasource);
    await db
        .into(db.members)
        .insert(
          MembersCompanion.insert(
            id: const Value(1),
            name: const Value('Silver'),
            createdAt: timestamp,
            updatedAt: timestamp,
          ),
        );
  });
  tearDown(() => db.close());

  test('use case sends canonical phone and rejects invalid input before repository', () async {
    final RecordingAuth recording = RecordingAuth();
    final UserLoginUseCase login = UserLoginUseCase(authRepository: recording);
    expect(
      (await login(UserLoginParams(phone: '09 254-135592'))).isRight(),
      isTrue,
    );
    expect(recording.lastParams!.phone, '+959254135592');
    expect(
      (await login(UserLoginParams(phone: 'not a phone'))).isLeft(),
      isTrue,
    );
    expect(recording.calls, 1);
  });

  test('equivalent phone formats find the seeded canonical account without inserting', () async {
    final int id = await insertUser('+959123456781');
    final List<String> formats = [
      '09123456781',
      '9123456781',
      '+959123456781',
      '+95 9-123-456-781',
      '959123456781',
    ];
    for (final String phone in formats) {
      final Either<Failure, UserEntity> result = await repository.loginUser(
        userLoginParams: UserLoginParams(phone: phone),
      );
      final UserEntity user = result.fold(
        (failure) => throw failure,
        (user) => user,
      );
      expect(user.id, id);
      expect(user.phone, '+959123456781');
      expect(user.firstName, 'Maya');
      expect(user.member.name, 'Silver');
    }
    expect(await db.select(db.users).get(), hasLength(1));
  });

  test('legacy local phone matches canonical input and normalizes the existing row', () async {
    final int id = await insertUser('09 123-456-781');
    final UserEntity user = (await repository.loginUser(
      userLoginParams: UserLoginParams(phone: '+959123456781'),
    )).fold((failure) => throw failure, (user) => user);
    expect(user.id, id);
    expect(user.phone, '+959123456781');
    expect((await db.select(db.users).get()).single.phone, '+959123456781');
  });

  test('legacy duplicates prefer completed account without deleting or merging rows', () async {
    await insertUser('+959123456781', firstName: '');
    final int completed = await insertUser('09123456781');
    await insertUser('+95 9 123456781', firstName: 'Another');
    final UserEntity user = (await repository.loginUser(
      userLoginParams: UserLoginParams(phone: '+959123456781'),
    )).fold((failure) => throw failure, (user) => user);
    expect(user.id, completed);
    final List<User> rows = await db.select(db.users).get();
    expect(rows, hasLength(3));
    expect(rows.singleWhere((row) => row.id == completed).phone, '09123456781');
  });

  test(
    'equivalent concurrent new requests create one pending canonical account',
    () async {
      final List<Either<Failure, UserEntity>> results = await Future.wait([
        repository.loginUser(
          userLoginParams: UserLoginParams(phone: '09123456781'),
        ),
        repository.loginUser(
          userLoginParams: UserLoginParams(phone: '+959123456781'),
        ),
      ]);
      final List<int> ids = results
          .map(
            (result) =>
                result.fold((failure) => throw failure, (user) => user.id),
          )
          .toList();
      expect(ids[0], ids[1]);
      final List<User> rows = await db.select(db.users).get();
      expect(rows, hasLength(1));
      expect(rows.single.phone, '+959123456781');
      expect(rows.single.firstName, isEmpty);
    },
  );

  test('invalid direct data-source input cannot insert a user', () async {
    await expectLater(
      datasource.loginUser(userLoginParams: UserLoginParams(phone: '00123')),
      throwsA(isA<SingleMessageReturnException>()),
    );
    expect(await db.select(db.users).get(), isEmpty);
  });
}
