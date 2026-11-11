import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../auth/domain/entities/user_entity.dart';
import '../../../home/presentation/widgets/tab_ui.dart';
import '../providers/rewards_provider.dart';
import 'challenge_artwork.dart';
import 'reward_motion.dart';
import 'rewards_points_ring.dart';

class RewardsCards extends StatelessWidget {
  const RewardsCards({
    super.key,
    required this.data,
    required this.user,
    required this.selected,
  });
  final RewardsViewData data;
  final UserEntity? user;
  final int selected;

  @override
  Widget build(BuildContext context) => Column(
    children: [
      if (selected == 0)
        if (data.earns.isEmpty)
          const Padding(
            padding: EdgeInsets.all(AppSpacing.xxl),
            child: Text('No Promotion Found'),
          )
        else
          for (final (int index, EarnEntity earn) in data.earns.indexed)
            RewardEntrance(
              key: ValueKey<String>('earn-${earn.id}'),
              index: index,
              child: _earn(context, earn),
            )
      else if (data.gifts.isEmpty)
        const Padding(
          padding: EdgeInsets.all(AppSpacing.xxl),
          child: Text('No Gifts Found'),
        )
      else
        for (final (int index, GiftEntity gift) in data.gifts.indexed)
          RewardEntrance(
            key: ValueKey<String>('gift-${gift.id}'),
            index: index,
            child: _gift(context, gift),
          ),
    ],
  );

  Widget _earn(BuildContext context, EarnEntity earn) {
    final int count = data.completedFor(earn.id).clamp(0, earn.quantity);
    final bool eligible = user != null && count >= earn.quantity;
    final bool drink = earn.productEntity.productTypeId == 2;
    return RewardCard(
      image: ChallengeArtwork(
        imagePath: earn.productEntity.imageUrl,
        progress: earn.quantity > 0 ? count / earn.quantity : 0,
        isDrink: drink,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${drink ? 'Drink' : 'Eat'} ${earn.quantity} ${earn.productEntity.name}',
            style: context.textTheme.titleMedium?.copyWith(fontSize: 15),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text('$count/${earn.quantity}', style: context.textTheme.bodySmall),
          const SizedBox(height: 10),
          Wrap(
            spacing: 10,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              RewardEarnButton(
                eligible: eligible,
                onPressed: () => showTabSheet(
                  context,
                  'Earning offer',
                  'You’ve completed this offer. ${earn.earnPoints} points are available to claim.',
                ),
              ),
              Text(
                '${earn.earnPoints} pts',
                style: context.textTheme.labelSmall?.copyWith(
                  fontSize: 12,
                  color: context.colorScheme.onSurface,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _gift(BuildContext context, GiftEntity gift) => RewardCard(
    image: SizedBox(
      width: 96,
      height: 100,
      child: Image.asset(
        gift.imageUrl,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) => Icon(
          Icons.card_giftcard_outlined,
          size: 48,
          color: context.colorScheme.secondary,
        ),
      ),
    ),
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          gift.name,
          style: context.textTheme.titleMedium?.copyWith(fontSize: 15),
        ),
        const SizedBox(height: 6),
        Text(
          gift.description,
          style: context.textTheme.labelSmall?.copyWith(
            fontSize: 12,
            color: context.colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          '${rewardNumber(gift.giftPoints)} pts',
          style: context.textTheme.titleSmall?.copyWith(
            color: context.colorScheme.secondary,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        OutlinedButton(
          onPressed: user != null && user!.currentPoints >= gift.giftPoints
              ? () => showTabSheet(
                  context,
                  gift.name,
                  '${gift.description}\nRequires ${gift.giftPoints} points.',
                )
              : null,
          child: const Text('View gift'),
        ),
      ],
    ),
  );
}

class RewardCard extends StatelessWidget {
  const RewardCard({super.key, required this.image, required this.body});
  final Widget image;
  final Widget body;
  @override
  Widget build(BuildContext context) => Container(
    margin: const EdgeInsets.only(bottom: AppSpacing.lg),
    padding: const EdgeInsets.all(AppSpacing.lg),
    decoration: BoxDecoration(
      color: context.colorScheme.surface,
      borderRadius: BorderRadius.circular(AppRadii.cardLg),
    ),
    child: LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 260 &&
            MediaQuery.textScalerOf(context).scale(14) > 17) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(child: image),
              const SizedBox(height: AppSpacing.md),
              body,
            ],
          );
        }
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            image,
            const SizedBox(width: AppSpacing.lg),
            Expanded(child: body),
          ],
        );
      },
    ),
  );
}
