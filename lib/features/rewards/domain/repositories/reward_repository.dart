import 'package:dartz/dartz.dart';
import 'package:hometake/features/rewards/domain/entities/earn_entity.dart';
import 'package:hometake/features/rewards/domain/entities/gift_entity.dart';
import 'package:hometake/features/rewards/domain/entities/reward_entity.dart';

import '../../../../core/error/failures.dart';

abstract class RewardRepository {
  Future<Either<Failure, List<RewardEntity>>> getRewards();
  Future<Either<Failure, List<EarnEntity>>> getEarns();
  Future<Either<Failure, List<GiftEntity>>> getGifts();
}
