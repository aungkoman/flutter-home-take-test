import 'package:flutter/material.dart';

import '../../../../core/motion/app_motion.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../auth/domain/entities/user_entity.dart';
import '../../domain/entities/reward_entity.dart';
import 'reward_motion.dart';
import 'rewards_points_ring.dart';

class RewardsTierLadder extends StatelessWidget {
  const RewardsTierLadder({
    super.key,
    required this.tiers,
    required this.user,
    required this.points,
  });
  final List<RewardEntity> tiers;
  final UserEntity? user;
  final int points;

  @override
  Widget build(BuildContext context) => Column(
    children: [
      for (int index = 0; index < tiers.length; index++)
        RewardEntrance(index: index, child: _tier(context, index)),
    ],
  );

  Widget _tier(BuildContext context, int index) {
    final RewardEntity tier = tiers[index];
    final bool current =
        user?.member.name.toLowerCase() == tier.name.toLowerCase();
    final int? colorValue = int.tryParse(
      tier.colorCode.replaceFirst('#', ''),
      radix: 16,
    );
    final Color color = colorValue == null
        ? context.appColors.textMuted
        : Color(0xFF000000 | colorValue);
    final int remaining = tier.rewardPoints - points;
    final String subtitle = user == null
        ? tier.description
        : current
        ? 'You’re here now'
        : remaining > 0
        ? '${rewardNumber(remaining)} pts to become ${tier.name}'
        : tier.description;
    final RewardEntity? next = index + 1 < tiers.length
        ? tiers[index + 1]
        : null;
    final int interval = next == null
        ? 0
        : next.rewardPoints - tier.rewardPoints;
    final double progress = user == null || interval <= 0
        ? 0
        : ((points - tier.rewardPoints) / interval).clamp(0, 1).toDouble();
    return Semantics(
      selected: current,
      label: current ? '${tier.name}, current tier' : tier.name,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                if (tier.imageUrl.isNotEmpty)
                  Image.asset(
                    tier.imageUrl,
                    width: 30,
                    height: 36,
                    errorBuilder: (context, error, stackTrace) => Icon(
                      Icons.workspace_premium_outlined,
                      color: color,
                      size: 32,
                    ),
                  )
                else
                  Icon(
                    Icons.workspace_premium_outlined,
                    color: color,
                    size: 32,
                  ),
                if (next != null)
                  TweenAnimationBuilder<double>(
                    tween: Tween<double>(begin: 0, end: progress),
                    duration: AppMotion.duration(context, AppMotion.rewards),
                    curve: AppMotion.curve,
                    builder: (context, value, child) => SizedBox(
                      width: 3,
                      height: 26,
                      child: Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          Positioned.fill(
                            child: ColoredBox(
                              color: context.appColors.progressTrack,
                            ),
                          ),
                          Align(
                            alignment: Alignment.topCenter,
                            child: FractionallySizedBox(
                              heightFactor: value,
                              child: ColoredBox(
                                color: color,
                                child: const SizedBox.expand(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Container(
                key: ValueKey<String>('reward-tier-${tier.id}'),
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                decoration: BoxDecoration(
                  color: current
                      ? color.withValues(alpha: 0.15)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(AppRadii.sm),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tier.name,
                      style: context.textTheme.titleMedium?.copyWith(
                        fontSize: 15,
                        fontWeight: current ? FontWeight.w800 : FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      subtitle,
                      style: context.textTheme.labelSmall?.copyWith(
                        color: context.colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
