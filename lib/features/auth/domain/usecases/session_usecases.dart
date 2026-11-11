import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/user_entity.dart';
import '../repositories/session_repository.dart';

export 'package:dartz/dartz.dart' show Either;

export '../../../../core/error/failures.dart';
export '../../../../core/usecase/usecase.dart' show NoParams;
export '../entities/user_entity.dart';
export '../repositories/session_repository.dart';

class RestoreSession implements UseCase<UserEntity?, NoParams> {
  RestoreSession({required this.repository});
  final SessionRepository repository;

  @override
  Future<Either<Failure, UserEntity?>> call(NoParams params) =>
      repository.restoreSession();
}

class SaveSession implements UseCase<void, UserEntity> {
  SaveSession({required this.repository});
  final SessionRepository repository;

  @override
  Future<Either<Failure, void>> call(UserEntity user) =>
      repository.saveSession(user);
}

class Logout implements UseCase<void, NoParams> {
  Logout({required this.repository});
  final SessionRepository repository;

  @override
  Future<Either<Failure, void>> call(NoParams params) => repository.logout();
}
