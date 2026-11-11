import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth/presentation/providers/login_provider.dart';
import '../../../auth/presentation/providers/otp_verify_provider.dart';
import '../../../auth/presentation/providers/register_provider.dart';
import '../../../home/presentation/widgets/tab_ui.dart';
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
      backgroundColor: tabGray,
      body: state.when(
        loading: () =>
            const SafeArea(child: Center(child: CircularProgressIndicator())),
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
                    color: const Color(0xFFFCF8FD),
                    padding: const EdgeInsets.fromLTRB(22, 24, 22, 24),
                    child: SafeArea(
                      bottom: false,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Expanded(
                                child: Text(
                                  'J’Donuts Rewards',
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF58A38),
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                child: Text(
                                  'Rewards $ready',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
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
                                        tier,
                                        user,
                                        points,
                                        last: tier.id == data.rewards.last.id,
                                      ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 12),
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
                                          color: tabPink,
                                          backgroundColor: const Color(
                                            0xFFECEEF0,
                                          ),
                                          semanticsLabel:
                                              'Progress to next reward tier',
                                          semanticsValue:
                                              '${(tierProgress * 100).round()} percent',
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(16),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const Text(
                                              'Total points',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: tabPink,
                                                fontSize: 12,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            FittedBox(
                                              fit: BoxFit.scaleDown,
                                              child: Text(
                                                _number(points),
                                                style: const TextStyle(
                                                  color: tabPink,
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.w800,
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
                              padding: EdgeInsets.only(top: 16),
                              child: Text(
                                'Sign in to track your points and progress.',
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
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
                              padding: EdgeInsets.all(32),
                              child: Text('No Promotion Found'),
                            )
                          else
                            for (final EarnEntity earn in data.earns)
                              _earnCard(
                                earn,
                                data.completedFor(earn.id),
                                user != null,
                              )
                        else if (data.gifts.isEmpty)
                          const Padding(
                            padding: EdgeInsets.all(32),
                            child: Text('No Gifts Found'),
                          )
                        else
                          for (final GiftEntity gift in data.gifts)
                            _giftCard(gift, points, user != null),
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

  String _number(int value) => value.toString().replaceAllMapped(
    RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
    (match) => '${match[1]},',
  );

  Widget _tier(
    RewardEntity tier,
    UserEntity? user,
    int points, {
    required bool last,
  }) {
    final int? hex = int.tryParse(
      tier.colorCode.replaceFirst('#', ''),
      radix: 16,
    );
    final Color color = hex == null ? Colors.grey : Color(0xFF000000 | hex);
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
                Container(width: 2, height: 24, color: const Color(0xFFCED3D4)),
            ],
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tier.name,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(subtitle, style: const TextStyle(fontSize: 11)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _image(String path, {double? progress}) => SizedBox(
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
                color: progress >= 1 ? tabBlue : const Color(0xFFFF8734),
                backgroundColor: const Color(0xFFECEEF0),
              ),
            ),
          ),
        Padding(
          padding: EdgeInsets.all(progress == null ? 0 : 16),
          child: Image.asset(
            path,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) => const Icon(
              Icons.bakery_dining_outlined,
              size: 48,
              color: tabPink,
            ),
          ),
        ),
      ],
    ),
  );

  Widget _earnCard(EarnEntity earn, int completed, bool signedIn) {
    final int count = completed.clamp(0, earn.quantity);
    final bool eligible = signedIn && count >= earn.quantity;
    final String action = earn.productEntity.productTypeId == 2
        ? 'Drink'
        : 'Eat';
    return _card(
      _image(earn.productEntity.imageUrl, progress: count / earn.quantity),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$action ${earn.quantity} ${earn.productEntity.name}',
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),
          Text('$count/${earn.quantity}', style: const TextStyle(fontSize: 13)),
          const SizedBox(height: 10),
          Wrap(
            spacing: 10,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: tabBlue,
                  foregroundColor: Colors.white,
                ),
                onPressed: eligible
                    ? () => showTabSheet(
                        context,
                        'Earning offer',
                        'You’ve completed this offer. ${earn.earnPoints} points are available to claim.',
                      )
                    : null,
                child: const Text(
                  'EARN',
                  style: TextStyle(fontWeight: FontWeight.w800),
                ),
              ),
              Text(
                '${earn.earnPoints} pts',
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _giftCard(GiftEntity gift, int points, bool signedIn) => _card(
    _image(gift.imageUrl),
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          gift.name,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 6),
        Text(gift.description, style: const TextStyle(fontSize: 12)),
        const SizedBox(height: 8),
        Text(
          '${_number(gift.giftPoints)} pts',
          style: const TextStyle(color: tabPink, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 8),
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

  Widget _card(Widget image, Widget body) => Container(
    margin: const EdgeInsets.only(bottom: 16),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(22),
    ),
    child: LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 260 &&
            MediaQuery.textScalerOf(context).scale(14) > 17) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(child: image),
              const SizedBox(height: 12),
              body,
            ],
          );
        }
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            image,
            const SizedBox(width: 16),
            Expanded(child: body),
          ],
        );
      },
    ),
  );
}
