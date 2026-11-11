import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/usecase/usecase.dart';
import '../../domain/usecases/get_rewards.dart';
import '../../domain/usecases/get_earns.dart';
import '../../domain/usecases/get_gifts.dart';
import '../../domain/usecases/get_earn_progress.dart';

export '../../domain/usecases/get_rewards.dart';
export '../../domain/usecases/get_earns.dart';
export '../../domain/usecases/get_gifts.dart';
export '../../domain/usecases/get_earn_progress.dart';

class RewardsViewData {
  const RewardsViewData({
    required this.rewards,
    required this.earns,
    required this.gifts,
    required this.progress,
  });
  final List<RewardEntity> rewards;
  final List<EarnEntity> earns;
  final List<GiftEntity> gifts;
  final List<EarnProgressEntity> progress;
  int completedFor(int earnId) =>
      progress
          .where((row) => row.earnId == earnId)
          .firstOrNull
          ?.completedQuantity ??
      0;
}

final rewardsProvider = AsyncNotifierProvider.autoDispose
    .family<RewardsNotifier, RewardsViewData, int>(
      (userId) => throw StateError(
        'Provide RewardsNotifier in the root ProviderScope.',
      ),
    );

class RewardsNotifier extends AsyncNotifier<RewardsViewData> {
  RewardsNotifier({
    required this.getRewards,
    required this.getEarns,
    required this.getGifts,
    required this.getEarnProgress,
    required this.userId,
  });
  final GetRewards getRewards;
  final GetEarns getEarns;
  final GetGifts getGifts;
  final GetEarnProgress getEarnProgress;
  final int userId;

  @override
  Future<RewardsViewData> build() async {
    // Start together so the local delays overlap.
    final Future<Either<Failure, List<RewardEntity>>> rewardsFuture =
        getRewards(NoParams());
    final Future<Either<Failure, List<EarnEntity>>> earnsFuture = getEarns(
      NoParams(),
    );
    final Future<Either<Failure, List<GiftEntity>>> giftsFuture = getGifts(
      NoParams(),
    );
    final Future<Either<Failure, List<EarnProgressEntity>>> progressFuture =
        getEarnProgress(GetEarnProgressParams(userId: userId));
    final List<RewardEntity> rewards = (await rewardsFuture).fold(
      (failure) => throw failure,
      (data) => data,
    );
    final List<EarnEntity> earns = (await earnsFuture).fold(
      (failure) => throw failure,
      (data) => data,
    );
    final List<GiftEntity> gifts = (await giftsFuture).fold(
      (failure) => throw failure,
      (data) => data,
    );
    final List<EarnProgressEntity> progress = (await progressFuture).fold(
      (failure) => throw failure,
      (data) => data,
    );
    return RewardsViewData(
      rewards: rewards,
      earns: earns,
      gifts: gifts,
      progress: progress,
    );
  }
}
