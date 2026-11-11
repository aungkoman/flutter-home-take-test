import 'package:dartz/dartz.dart';
import 'package:hometake/features/rewards/domain/entities/earn_entity.dart';
import 'package:hometake/features/rewards/domain/entities/reward_entity.dart';
import 'package:hometake/features/rewards/domain/repositories/reward_repository.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
export '../../../../core/error/failures.dart';

class GetEarns
    implements UseCase<List<EarnEntity>, NoParams> {
  GetEarns({required this.repository});
  final RewardRepository repository;

  @override
  Future<Either<Failure, List<EarnEntity>>> call(
      NoParams params,
      ) => repository.getEarns();
}
