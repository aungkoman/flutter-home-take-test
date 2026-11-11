import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/user_entity.dart';

/// Persists only authenticated, completed accounts; pending OTP is not a session.
abstract class SessionRepository {
  Future<Either<Failure, UserEntity?>> restoreSession();
  Future<Either<Failure, void>> saveSession(UserEntity user);
  Future<Either<Failure, void>> logout();
}
