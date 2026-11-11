import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../auth/domain/entities/user_entity.dart';
import '../../domain/entities/reward_entity.dart';
import 'reward_motion.dart';
import 'rewards_points_ring.dart';
import 'rewards_tier_ladder.dart';

class RewardsHeader extends StatelessWidget {
  const RewardsHeader({
    super.key,
    required this.tiers,
    required this.user,
    required this.ready,
  });
  final List<RewardEntity> tiers;
  final UserEntity? user;
  final int ready;

  @override
  Widget build(BuildContext context) {
    final int points = user?.currentPoints ?? 0;
    final RewardEntity? next = tiers
        .where((tier) => tier.rewardPoints > points)
        .firstOrNull;
    final RewardEntity? lower = tiers
        .where((tier) => tier.rewardPoints <= points)
        .lastOrNull;
    final int floor = lower?.rewardPoints ?? 0;
    final double progress = user == null
        ? 0
        : next == null
        ? 1
        : ((points - floor) / (next.rewardPoints - floor))
              .clamp(0, 1)
              .toDouble();
    return Container(
      color: context.appColors.blushHeader,
      padding: const EdgeInsets.fromLTRB(22, 24, 22, 24),
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'J’Donuts Rewards',
                    style: context.textTheme.headlineSmall,
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                RewardEntrance(
                  pop: true,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: context.appColors.orangeBadge,
                      borderRadius: BorderRadius.circular(AppRadii.cardXl),
                    ),
                    child: Text(
                      'Rewards $ready',
                      key: const ValueKey<String>('rewards-badge'),
                      style: context.textTheme.labelMedium?.copyWith(
                        fontSize: 14,
                        color: context.colorScheme.onTertiary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 28),
            Row(
              children: [
                Expanded(
                  child: RewardsTierLadder(
                    tiers: tiers,
                    user: user,
                    points: points,
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: RewardsPointsRing(points: points, progress: progress),
                ),
              ],
            ),
            if (user == null)
              const Padding(
                padding: EdgeInsets.only(top: AppSpacing.lg),
                child: Text('Sign in to track your points and progress.'),
              ),
          ],
        ),
      ),
    );
  }
}
