import 'package:dartz/dartz.dart';
import 'package:hometake/features/rewards/domain/entities/gift_entity.dart';
import 'package:hometake/features/rewards/domain/repositories/reward_repository.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';

export '../../../../core/error/failures.dart';
export '../entities/gift_entity.dart';

class GetGifts implements UseCase<List<GiftEntity>, NoParams> {
  GetGifts({required this.repository});
  final RewardRepository repository;

  @override
  Future<Either<Failure, List<GiftEntity>>> call(NoParams params) =>
      repository.getGifts();
}
