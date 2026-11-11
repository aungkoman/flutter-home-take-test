import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../auth/presentation/providers/login_provider.dart';
import '../../../auth/presentation/providers/otp_verify_provider.dart';
import '../../../auth/presentation/providers/register_provider.dart';
import '../../../home/presentation/widgets/tab_ui.dart';
import '../../../product/presentation/widgets/loading_effects.dart';
import '../providers/rewards_provider.dart';

class RewardPage extends ConsumerStatefulWidget {
  const RewardPage({super.key});
  @override
  ConsumerState<RewardPage> createState() => _RewardPageState();
}

class _RewardPageState extends ConsumerState<RewardPage> {
  int _selected = 0;
  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = context.colorScheme;
    final AppColors appColors = context.appColors;
    final TextTheme textTheme = context.textTheme;
    final UserEntity? loginUser = ref.watch(loginProvider).value;
    final UserEntity? verifiedUser = ref.watch(otpVerifyProvider).value;
    final UserEntity? registeredUser = ref.watch(registerProvider).value;
    final UserEntity? user =
        (registeredUser?.id == verifiedUser?.id ? registeredUser : null) ??
        verifiedUser ??
        loginUser;
    final int userId = user?.id ?? 0;
    final AsyncValue<RewardsViewData> state = ref.watch(
      rewardsProvider(userId),
    );
    return Scaffold(
      backgroundColor: appColors.pageBackground,
      body: state.when(
        loading: () => _rewardLoadingSkeleton(context),
        error: (Object error, StackTrace stackTrace) => SafeArea(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Could not load rewards.'),
                TextButton(
                  onPressed: () => ref.invalidate(rewardsProvider(userId)),
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
        ),
        data: (RewardsViewData data) {
          final int points = user?.currentPoints ?? 0;
          final int ready = user == null
              ? 0
              : data.earns
                    .where(
                      (earn) => data.completedFor(earn.id) >= earn.quantity,
                    )
                    .length;
          final RewardEntity? next = data.rewards
              .where((tier) => tier.rewardPoints > points)
              .firstOrNull;
          final double tierProgress = next == null
              ? (user == null ? 0 : 1)
              : (points / next.rewardPoints).clamp(0, 1).toDouble();
          return RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(rewardsProvider(userId));
              await ref.read(rewardsProvider(userId).future);
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  Container(
                    color: appColors.blushHeader,
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
                                  style: textTheme.headlineSmall,
                                ),
                              ),
                              const SizedBox(width: AppSpacing.sm),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: AppSpacing.md,
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  color: appColors.orangeBadge,
                                  borderRadius: BorderRadius.circular(
                                    AppRadii.cardXl,
                                  ),
                                ),
                                child: Text(
                                  'Rewards $ready',
                                  style: textTheme.labelMedium?.copyWith(
                                    fontSize: 14,
                                    color: colorScheme.onTertiary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 28),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    for (final RewardEntity tier
                                        in data.rewards)
                                      _tier(
                                        context,
                                        tier,
                                        user,
                                        points,
                                        last: tier.id == data.rewards.last.id,
                                      ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: AppSpacing.md),
                              Expanded(
                                child: AspectRatio(
                                  aspectRatio: 1,
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Positioned.fill(
                                        child: CircularProgressIndicator(
                                          value: tierProgress,
                                          strokeWidth: 16,
                                          color: colorScheme.secondary,
                                          backgroundColor:
                                              appColors.progressTrack,
                                          semanticsLabel:
                                              'Progress to next reward tier',
                                          semanticsValue:
                                              '${(tierProgress * 100).round()} percent',
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(
                                          AppSpacing.lg,
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              'Total points',
                                              textAlign: TextAlign.center,
                                              style: textTheme.labelMedium
                                                  ?.copyWith(
                                                    color:
                                                        colorScheme.secondary,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                            ),
                                            const SizedBox(
                                              height: AppSpacing.xs,
                                            ),
                                            FittedBox(
                                              fit: BoxFit.scaleDown,
                                              child: Text(
                                                _number(points),
                                                style: textTheme.headlineMedium
                                                    ?.copyWith(
                                                      color:
                                                          colorScheme.secondary,
                                                    ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          if (user == null)
                            const Padding(
                              padding: EdgeInsets.only(top: AppSpacing.lg),
                              child: Text(
                                'Sign in to track your points and progress.',
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  TabPills(
                    labels: const ['Eat more Earn more', 'Gift'],
                    selected: _selected,
                    onSelected: (int value) =>
                        setState(() => _selected = value),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(22, 16, 22, 140),
                    child: Column(
                      children: [
                        if (_selected == 0)
                          if (data.earns.isEmpty)
                            const Padding(
                              padding: EdgeInsets.all(AppSpacing.xxl),
                              child: Text('No Promotion Found'),
                            )
                          else
                            for (final EarnEntity earn in data.earns)
                              _earnCard(
                                context,
                                earn,
                                data.completedFor(earn.id),
                                user != null,
                              )
                        else if (data.gifts.isEmpty)
                          const Padding(
                            padding: EdgeInsets.all(AppSpacing.xxl),
                            child: Text('No Gifts Found'),
                          )
                        else
                          for (final GiftEntity gift in data.gifts)
                            _giftCard(context, gift, points, user != null),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _rewardLoadingSkeleton(BuildContext context) {
    final ColorScheme colorScheme = context.colorScheme;
    final AppColors appColors = context.appColors;
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: appColors.blushHeader,
              padding: const EdgeInsets.fromLTRB(22, 24, 22, 24),
              child: Column(
                children: [
                  const Row(
                    children: [
                      SkeletonBlock(width: 170, height: 26),
                      Spacer(),
                      SkeletonBlock(
                        width: 94,
                        height: 38,
                        borderRadius: AppRadii.cardXl,
                      ),
                    ],
                  ),
                  const SizedBox(height: 28),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for (int index = 0; index < 3; index++) ...[
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SkeletonBlock(
                                    width: 32,
                                    height: 36,
                                    borderRadius: 18,
                                  ),
                                  const SizedBox(width: AppSpacing.sm),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SkeletonBlock(
                                          width: index == 1 ? 76 : 95,
                                          height: 15,
                                        ),
                                        const SizedBox(height: 6),
                                        const SkeletonBlock(
                                          width: 112,
                                          height: 11,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              if (index < 2)
                                const Padding(
                                  padding: EdgeInsets.only(left: 15, top: 4),
                                  child: SkeletonBlock(
                                    width: 2,
                                    height: 20,
                                    borderRadius: 1,
                                  ),
                                ),
                              if (index < 2)
                                const SizedBox(height: AppSpacing.sm),
                            ],
                          ],
                        ),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      const SkeletonBlock(
                        width: 132,
                        height: 132,
                        borderRadius: 66,
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  const SkeletonBlock(width: 230, height: 14),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 22),
              child: Row(
                children: [
                  Expanded(
                    child: SkeletonBlock(
                      width: double.infinity,
                      height: 42,
                      borderRadius: AppRadii.cardXl,
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: SkeletonBlock(
                      width: double.infinity,
                      height: 42,
                      borderRadius: AppRadii.cardXl,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(22, 16, 22, 140),
              child: Column(
                children: [
                  for (int index = 0; index < 3; index++) ...[
                    Container(
                      margin: const EdgeInsets.only(bottom: AppSpacing.lg),
                      padding: const EdgeInsets.all(AppSpacing.lg),
                      decoration: BoxDecoration(
                        color: colorScheme.surface,
                        borderRadius: BorderRadius.circular(AppRadii.cardLg),
                      ),
                      child: Row(
                        children: [
                          const SkeletonBlock(
                            width: 88,
                            height: 88,
                            borderRadius: 44,
                          ),
                          const SizedBox(width: AppSpacing.lg),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SkeletonBlock(
                                  width: index == 1 ? 150 : 185,
                                  height: 16,
                                ),
                                const SizedBox(height: 10),
                                const SkeletonBlock(width: 74, height: 13),
                                const SizedBox(height: AppSpacing.md),
                                const Row(
                                  children: [
                                    SkeletonBlock(
                                      width: 78,
                                      height: 34,
                                      borderRadius: 18,
                                    ),
                                    SizedBox(width: AppSpacing.md),
                                    SkeletonBlock(width: 48, height: 13),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _number(int value) => value.toString().replaceAllMapped(
    RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
    (match) => '${match[1]},',
  );

  Widget _tier(
    BuildContext context,
    RewardEntity tier,
    UserEntity? user,
    int points, {
    required bool last,
  }) {
    final AppColors appColors = context.appColors;
    final TextTheme textTheme = context.textTheme;
    final int? hex = int.tryParse(
      tier.colorCode.replaceFirst('#', ''),
      radix: 16,
    );
    final Color color = hex == null
        ? appColors.textMuted
        : Color(0xFF000000 | hex);
    final bool current =
        user?.member.name.toLowerCase() == tier.name.toLowerCase();
    final int remaining = tier.rewardPoints - points;
    final String subtitle = user == null
        ? tier.description
        : current
        ? 'You’re here now'
        : remaining > 0
        ? '${_number(remaining)} pts to become ${tier.name}'
        : tier.description;
    return Padding(
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
                Icon(Icons.workspace_premium_outlined, color: color, size: 32),
              if (!last)
                Container(width: 2, height: 24, color: appColors.divider),
            ],
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tier.name,
                  style: textTheme.titleMedium?.copyWith(fontSize: 15),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  subtitle,
                  style: textTheme.labelSmall?.copyWith(
                    color: context.colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _image(BuildContext context, String path, {double? progress}) {
    final ColorScheme colorScheme = context.colorScheme;
    final AppColors appColors = context.appColors;
    return SizedBox(
      width: 96,
      height: 100,
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (progress != null)
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: CircularProgressIndicator(
                  value: progress,
                  strokeWidth: 6,
                  color: progress >= 1
                      ? colorScheme.primary
                      : appColors.orangeBadge,
                  backgroundColor: appColors.progressTrack,
                ),
              ),
            ),
          Padding(
            padding: EdgeInsets.all(progress == null ? 0 : AppSpacing.lg),
            child: Image.asset(
              path,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) => Icon(
                Icons.bakery_dining_outlined,
                size: 48,
                color: colorScheme.secondary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _earnCard(
    BuildContext context,
    EarnEntity earn,
    int completed,
    bool signedIn,
  ) {
    final TextTheme textTheme = context.textTheme;
    final int count = completed.clamp(0, earn.quantity);
    final bool eligible = signedIn && count >= earn.quantity;
    final String action = earn.productEntity.productTypeId == 2
        ? 'Drink'
        : 'Eat';
    return _card(
      context,
      _image(
        context,
        earn.productEntity.imageUrl,
        progress: count / earn.quantity,
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$action ${earn.quantity} ${earn.productEntity.name}',
            style: textTheme.titleMedium?.copyWith(fontSize: 15),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text('$count/${earn.quantity}', style: textTheme.bodySmall),
          const SizedBox(height: 10),
          Wrap(
            spacing: 10,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              FilledButton(
                onPressed: eligible
                    ? () => showTabSheet(
                        context,
                        'Earning offer',
                        'You’ve completed this offer. ${earn.earnPoints} points are available to claim.',
                      )
                    : null,
                child: const Text('EARN'),
              ),
              Text(
                '${earn.earnPoints} pts',
                style: textTheme.labelSmall?.copyWith(
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

  Widget _giftCard(
    BuildContext context,
    GiftEntity gift,
    int points,
    bool signedIn,
  ) {
    final ColorScheme colorScheme = context.colorScheme;
    final TextTheme textTheme = context.textTheme;
    return _card(
      context,
      _image(context, gift.imageUrl),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            gift.name,
            style: textTheme.titleMedium?.copyWith(fontSize: 15),
          ),
          const SizedBox(height: 6),
          Text(
            gift.description,
            style: textTheme.labelSmall?.copyWith(
              fontSize: 12,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            '${_number(gift.giftPoints)} pts',
            style: textTheme.titleSmall?.copyWith(color: colorScheme.secondary),
          ),
          const SizedBox(height: AppSpacing.sm),
          OutlinedButton(
            onPressed: signedIn && points >= gift.giftPoints
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

  Widget _card(BuildContext context, Widget image, Widget body) => Container(
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
