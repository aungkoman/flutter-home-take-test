import 'package:dartz/dartz.dart';
import 'package:hometake/features/rewards/domain/entities/reward_entity.dart';
import 'package:hometake/features/rewards/domain/repositories/reward_repository.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';

export '../../../../core/error/failures.dart';
export '../entities/reward_entity.dart';

class GetRewards implements UseCase<List<RewardEntity>, NoParams> {
  GetRewards({required this.repository});
  final RewardRepository repository;

  @override
  Future<Either<Failure, List<RewardEntity>>> call(NoParams params) =>
      repository.getRewards();
}
