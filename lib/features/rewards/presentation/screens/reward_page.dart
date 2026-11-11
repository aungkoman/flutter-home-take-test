import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/motion/app_motion.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../auth/presentation/providers/current_user_provider.dart';
import '../providers/rewards_provider.dart';
import '../widgets/rewards_cards.dart';
import '../widgets/rewards_header.dart';
import '../widgets/rewards_loading_skeleton.dart';
import '../widgets/rewards_tabs.dart';

class RewardPage extends ConsumerStatefulWidget {
  const RewardPage({super.key});
  @override
  ConsumerState<RewardPage> createState() => _RewardPageState();
}

class _RewardPageState extends ConsumerState<RewardPage> {
  int _selected = 0;
  int _entryEpoch = 0;
  bool _wasActive = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final bool active = TickerMode.valuesOf(context).enabled;
    if (active && !_wasActive) _entryEpoch++;
    _wasActive = active;
  }

  @override
  Widget build(BuildContext context) {
    final UserEntity? user = ref.watch(currentUserProvider);
    final int userId = user?.id ?? 0;
    final AsyncValue<RewardsViewData> state = ref.watch(
      rewardsProvider(userId),
    );
    return Scaffold(
      backgroundColor: context.appColors.pageBackground,
      body: state.when(
        loading: () => const RewardsLoadingSkeleton(),
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
        data: (RewardsViewData data) => _content(context, user, userId, data),
      ),
    );
  }

  Widget _content(
    BuildContext context,
    UserEntity? user,
    int userId,
    RewardsViewData data,
  ) {
    final int ready = user == null
        ? 0
        : data.earns
              .where((earn) => data.completedFor(earn.id) >= earn.quantity)
              .length;
    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(rewardsProvider(userId));
        await ref.read(rewardsProvider(userId).future);
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            RewardsHeader(
              key: ValueKey<String>('rewards-header-$_entryEpoch'),
              tiers: data.rewards,
              user: user,
              ready: ready,
            ),
            const SizedBox(height: AppSpacing.sm),
            RewardsTabs(
              selected: _selected,
              onSelected: (int value) => setState(() => _selected = value),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(22, 16, 22, 140),
              child: AnimatedSwitcher(
                duration: AppMotion.duration(context, AppMotion.standard),
                switchInCurve: AppMotion.curve,
                switchOutCurve: Curves.easeIn,
                transitionBuilder:
                    (Widget child, Animation<double> animation) =>
                        FadeTransition(
                          opacity: animation,
                          child: SlideTransition(
                            position: Tween<Offset>(
                              begin: const Offset(0, 0.04),
                              end: Offset.zero,
                            ).animate(animation),
                            child: child,
                          ),
                        ),
                child: RewardsCards(
                  key: ValueKey<String>('$_entryEpoch/$_selected'),
                  data: data,
                  user: user,
                  selected: _selected,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
