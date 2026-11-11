import 'dart:developer' show log;

import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/session_repository.dart';
import '../datasources/auth_local_datasource.dart';
import '../datasources/session_local_datasource.dart';

class SessionRepositoryImpl implements SessionRepository {
  SessionRepositoryImpl({
    required this.authLocalDatasource,
    required this.sessionLocalDatasource,
  });

  final AuthLocalDatasource authLocalDatasource;
  final SessionLocalDatasource sessionLocalDatasource;

  @override
  Future<Either<Failure, UserEntity?>> restoreSession() async {
    try {
      final int? userId = await sessionLocalDatasource.readUserId();
      if (userId == null) return const Right(null);
      final UserEntity? user = userId > 0
          ? await authLocalDatasource.getUserById(userId: userId)
          : null;
      if (user == null || user.firstName.trim().isEmpty) {
        await sessionLocalDatasource.clear();
        return const Right(null);
      }
      return Right(user);
    } catch (error, stackTrace) {
      _logFailure('restoreSession', error, stackTrace);
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> saveSession(UserEntity user) async {
    if (user.id <= 0 || user.firstName.trim().isEmpty) {
      return Left(
        SingleMessageReturnFailure(
          message: 'Complete registration before starting a session.',
        ),
      );
    }
    try {
      await sessionLocalDatasource.writeUserId(user.id);
      return const Right(null);
    } catch (error, stackTrace) {
      _logFailure('saveSession', error, stackTrace);
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await sessionLocalDatasource.clear();
      return const Right(null);
    } catch (error, stackTrace) {
      _logFailure('logout', error, stackTrace);
      return Left(CacheFailure());
    }
  }

  void _logFailure(String method, Object error, StackTrace stackTrace) {
    log(
      'SessionRepositoryImpl.$method failed',
      name: 'auth.session',
      error: error,
      stackTrace: stackTrace,
    );
  }
}
