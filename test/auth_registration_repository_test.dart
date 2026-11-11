import 'package:dartz/dartz.dart' show Right;
import 'package:drift/drift.dart' hide isNull, isNotNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hometake/features/auth/data/database/app_database.dart';
import 'package:hometake/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:hometake/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:hometake/features/auth/domain/repositories/auth_repository.dart';
import 'package:hometake/features/auth/domain/usecases/user_register.dart';
import 'package:hometake/features/auth/domain/validators/auth_validators.dart';

class RecordingRegistration implements AuthRepository {
  int calls = 0;
  UserRegisterParams? lastParams;
  @override
  Future<Either<Failure, UserEntity>> registerUser({
    required UserRegisterParams userRegisterParams,
  }) async {
    calls++;
    lastParams = userRegisterParams;
    return Right(UserEntity.sample);
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  late AppDatabase db;
  late AuthRepositoryImpl repository;
  late int userId;
  final DateTime timestamp = DateTime.utc(2026, 1, 1);

  UserRegisterParams params({
    String firstName = 'Maya',
    String lastName = '',
    String dob = '1995-01-20',
    String phone = '+959123456781',
  }) => UserRegisterParams(
    userId: userId,
    firstName: firstName,
    lastName: lastName,
    dob: dob,
    phone: phone,
  );

  setUp(() async {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    repository = AuthRepositoryImpl(
      authLocalDatasource: AuthLocalDatasourceImpl(db: db),
    );
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
    userId = await db
        .into(db.users)
        .insert(
          UsersCompanion.insert(
            phone: const Value('+959123456781'),
            memberId: const Value(1),
            createdAt: timestamp,
            updatedAt: timestamp,
          ),
        );
  });
  tearDown(() => db.close());

  test(
    'empty last name completes registration and persists the profile',
    () async {
      final Either<Failure, UserEntity> result = await UserRegister(
        authRepository: repository,
      )(params(firstName: '  Maya  ', lastName: '  '));
      final UserEntity user = result.fold(
        (failure) => throw failure,
        (user) => user,
      );
      expect(user.id, userId);
      expect(user.firstName, 'Maya');
      expect(user.lastName, isEmpty);
      expect(user.dob, DateTime(1995, 1, 20));
      expect(user.phone, '+959123456781');
      final User row = await (db.select(
        db.users,
      )..where((row) => row.id.equals(userId))).getSingle();
      expect(row.firstName, 'Maya');
      expect(row.lastName, isEmpty);
      expect(row.dob, DateTime(1995, 1, 20));
    },
  );

  test('use case trims names and permits a missing family name', () async {
    final RecordingRegistration recording = RecordingRegistration();
    final Either<Failure, UserEntity> result = await UserRegister(
      authRepository: recording,
    )(params(firstName: '  Maya  ', lastName: ' ', phone: '09123456781'));
    expect(result.isRight(), isTrue);
    expect(recording.lastParams!.firstName, 'Maya');
    expect(recording.lastParams!.lastName, '');
    expect(recording.lastParams!.phone, '+959123456781');
  });

  test('exactly thirteen passes while one day younger fails', () async {
    final DateTime today = DateTime.now();
    final DateTime birthday = DateTime(
      today.year - kMinAgeYears,
      today.month,
      today.day,
    );
    String asInput(DateTime date) =>
        '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
    final RecordingRegistration recording = RecordingRegistration();
    final UserRegister register = UserRegister(authRepository: recording);
    expect((await register(params(dob: asInput(birthday)))).isRight(), isTrue);
    expect(
      (await register(
        params(dob: asInput(birthday.add(const Duration(days: 1)))),
      )).isLeft(),
      isTrue,
    );
    expect(recording.calls, 1);
  });

  test(
    'invalid fields are rejected before the use case calls its repository',
    () async {
      final RecordingRegistration recording = RecordingRegistration();
      final UserRegister register = UserRegister(authRepository: recording);
      final List<UserRegisterParams> invalid = [
        params(firstName: ''),
        params(firstName: 'A' * 51),
        params(firstName: 'Maya7'),
        params(lastName: 'Lin2'),
        params(lastName: 'B' * 51),
        params(dob: '2000-04-31'),
        params(dob: '2001-02-29'),
        params(dob: '2999-01-01'),
        params(dob: '${DateTime.now().year - 12}-01-01'),
        params(phone: '123'),
      ];
      for (final UserRegisterParams input in invalid) {
        final Either<Failure, UserEntity> result = await register(input);
        expect(
          result.fold((failure) => failure, (_) => null),
          isA<SingleMessageReturnFailure>(),
        );
      }
      expect(recording.calls, 0);
    },
  );

  test(
    'direct data-source callers cannot bypass name, calendar, or age rules',
    () async {
      for (final UserRegisterParams input in [
        params(firstName: ''),
        params(firstName: 'Maya7'),
        params(lastName: 'Lin2'),
        params(dob: '2000-04-31'),
        params(dob: '2001-02-29'),
        params(dob: '2999-01-01'),
        params(dob: '${DateTime.now().year - 12}-01-01'),
      ]) {
        final Either<Failure, UserEntity> result = await repository
            .registerUser(userRegisterParams: input);
        expect(
          result.fold((failure) => failure, (_) => null),
          isA<SingleMessageReturnFailure>(),
        );
      }
      final User row = await (db.select(
        db.users,
      )..where((row) => row.id.equals(userId))).getSingle();
      expect(row.firstName, isEmpty);
      expect(row.dob, isNull);
    },
  );

  group('strict calendar parsing', () {
    test('real leap-year date is preserved', () {
      expect(parseDateOfBirth('2000-02-29'), DateTime(2000, 2, 29));
      expect(parseDateOfBirth(' 1995-01-20 '), DateTime(1995, 1, 20));
    });
    for (final String invalid in [
      '1900-02-29',
      '2001-02-29',
      '2000-04-31',
      '2000-13-01',
      '2000-00-01',
      '2000-01-00',
      '0000-01-01',
      '2000-1-1',
      '2000-01-01T10:00:00',
      '',
    ]) {
      test('$invalid is rejected rather than normalized', () {
        expect(parseDateOfBirth(invalid), isNull);
      });
    }
  });
}
