import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/earn_progress_entity.dart';
import '../repositories/reward_repository.dart';
export '../entities/earn_progress_entity.dart';

class GetEarnProgressParams {
  const GetEarnProgressParams({required this.userId});
  final int userId;
}

class GetEarnProgress
    implements UseCase<List<EarnProgressEntity>, GetEarnProgressParams> {
  GetEarnProgress({required this.repository});
  final RewardRepository repository;
  @override
  Future<Either<Failure, List<EarnProgressEntity>>> call(
    GetEarnProgressParams params,
  ) => repository.getEarnProgress(userId: params.userId);
}
