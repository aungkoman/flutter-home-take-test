import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hometake/core/motion/app_motion.dart';
import 'package:hometake/core/theme/app_theme.dart';
import 'package:hometake/features/auth/presentation/providers/current_user_provider.dart';
import 'package:hometake/features/product/domain/entities/product_entity.dart';
import 'package:hometake/features/product/domain/entities/product_type_entity.dart';
import 'package:hometake/features/rewards/domain/repositories/reward_repository.dart';
import 'package:hometake/features/rewards/presentation/providers/rewards_provider.dart';
import 'package:hometake/features/rewards/presentation/screens/reward_page.dart';
import 'package:hometake/features/rewards/presentation/widgets/reward_motion.dart';
import 'package:hometake/features/rewards/presentation/widgets/rewards_points_ring.dart';
import 'package:hometake/features/rewards/presentation/widgets/rewards_tabs.dart';
import 'package:hometake/features/rewards/presentation/widgets/rewards_tier_ladder.dart';

const String donutPhoto = 'assets/images/donut-red.png';
UserEntity rewardUser() {
  final UserEntity user = UserEntity.sample..currentPoints = 680000;
  user.member.name = 'Silver';
  return user;
}

RewardsViewData rewardsFixture() {
  final ProductTypeEntity type = ProductTypeEntity(
    id: 1,
    name: 'Donuts',
    imageUrl: donutPhoto,
    priorityNo: 1,
  );
  ProductEntity product(int id, String name, int typeId, String photo) =>
      ProductEntity(
        id: id,
        name: name,
        imageUrl: photo,
        priorityNo: id,
        price: 5000,
        currency: 'MMK',
        productCode: 'JD$id',
        description: '',
        isNew: false,
        discountPercentage: null,
        discountAmount: null,
        productTypeId: typeId,
        productType: type,
      );
  return RewardsViewData(
    rewards: [
      RewardEntity(
        id: 1,
        name: 'Silver',
        description: 'Your first rewards',
        imageUrl: '',
        colorCode: '#BAC0C7',
        rewardPoints: 0,
      ),
      RewardEntity(
        id: 2,
        name: 'Gold',
        description: 'More treats',
        imageUrl: '',
        colorCode: '#E3C46D',
        rewardPoints: 1000000,
      ),
      RewardEntity(
        id: 3,
        name: 'Platinum',
        description: 'Our sweetest tier',
        imageUrl: '',
        colorCode: '#8BCDDD',
        rewardPoints: 2000000,
      ),
    ],
    earns: [
      EarnEntity(
        id: 1,
        productId: 1,
        productEntity: product(1, 'Coco donuts', 1, donutPhoto),
        quantity: 4,
        earnPoints: 100,
      ),
      EarnEntity(
        id: 2,
        productId: 2,
        productEntity: product(2, 'Coco donuts', 1, donutPhoto),
        quantity: 4,
        earnPoints: 100,
      ),
      EarnEntity(
        id: 3,
        productId: 3,
        productEntity: product(
          3,
          'Americano',
          2,
          'assets/images/1766383605558-SC Hot Coffee Americano_.png',
        ),
        quantity: 12,
        earnPoints: 100,
      ),
    ],
    gifts: [
      GiftEntity(
        id: 1,
        name: 'Donut gift',
        description: 'A sweet treat',
        imageUrl: donutPhoto,
        giftPoints: 100,
      ),
    ],
    progress: [
      const EarnProgressEntity(userId: 1, earnId: 1, completedQuantity: 4),
      const EarnProgressEntity(userId: 1, earnId: 2, completedQuantity: 1),
      const EarnProgressEntity(userId: 1, earnId: 3, completedQuantity: 9),
    ],
  );
}

class RewardFixtureRepository implements RewardRepository {
  RewardFixtureRepository(this.data);
  final RewardsViewData data;
  @override
  Future<Either<Failure, List<RewardEntity>>> getRewards() async =>
      Right(data.rewards);
  @override
  Future<Either<Failure, List<EarnEntity>>> getEarns() async =>
      Right(data.earns);
  @override
  Future<Either<Failure, List<GiftEntity>>> getGifts() async =>
      Right(data.gifts);
  @override
  Future<Either<Failure, List<EarnProgressEntity>>> getEarnProgress({
    required int userId,
  }) async => Right(data.progress.where((p) => p.userId == userId).toList());
}

Widget motionHost(
  Widget child, {
  bool reducedMotion = false,
  double textScale = 1,
}) => MaterialApp(
  theme: AppTheme.light,
  builder: (context, child) => MediaQuery(
    data: MediaQuery.of(context).copyWith(
      disableAnimations: reducedMotion,
      textScaler: TextScaler.linear(textScale),
    ),
    child: child!,
  ),
  home: Scaffold(body: Center(child: child)),
);
Widget rewardPageHost({bool reducedMotion = false, double textScale = 1}) {
  final RewardFixtureRepository repository = RewardFixtureRepository(
    rewardsFixture(),
  );
  return ProviderScope(
    overrides: [
      currentUserProvider.overrideWithValue(rewardUser()),
      rewardsProvider.overrideWith2(
        (userId) => RewardsNotifier(
          getRewards: GetRewards(repository: repository),
          getEarns: GetEarns(repository: repository),
          getGifts: GetGifts(repository: repository),
          getEarnProgress: GetEarnProgress(repository: repository),
          userId: userId,
        ),
      ),
    ],
    child: motionHost(
      const RewardPage(),
      reducedMotion: reducedMotion,
      textScale: textScale,
    ),
  );
}

RewardsRingPainter ringPainter(WidgetTester tester) => tester
    .widgetList<CustomPaint>(
      find.descendant(
        of: find.byType(RewardsPointsRing),
        matching: find.byType(CustomPaint),
      ),
    )
    .map((p) => p.painter)
    .whereType<RewardsRingPainter>()
    .single;
void main() {
  testWidgets(
    'points and painted ring sweep together to the local member total',
    (tester) async {
      await tester.pumpWidget(
        motionHost(
          const SizedBox(
            width: 200,
            child: RewardsPointsRing(points: 680000, progress: 0.68),
          ),
        ),
      );
      expect(find.text('0'), findsOneWidget);
      expect(ringPainter(tester).progress, 0);
      await tester.pump(AppMotion.rewards ~/ 2);
      final int displayed = int.parse(
        tester
            .widget<Text>(
              find.byKey(const ValueKey<String>('rewards-point-total')),
            )
            .data!
            .replaceAll(',', ''),
      );
      expect(displayed, greaterThan(0));
      expect(displayed, lessThan(680000));
      expect(ringPainter(tester).progress, greaterThan(0));
      expect(ringPainter(tester).progress, lessThan(0.68));
      await tester.pumpAndSettle();
      expect(find.text('680,000'), findsOneWidget);
      expect(ringPainter(tester).progress, 0.68);
      expect(tester.takeException(), isNull);
    },
  );
  testWidgets('Reduce Motion shows the final ring and total immediately', (
    tester,
  ) async {
    await tester.pumpWidget(
      motionHost(
        const SizedBox(
          width: 200,
          child: RewardsPointsRing(points: 680000, progress: 0.68),
        ),
        reducedMotion: true,
      ),
    );
    expect(find.text('680,000'), findsOneWidget);
    expect(ringPainter(tester).progress, 0.68);
    await tester.pump(AppMotion.rewards);
    expect(ringPainter(tester).progress, 0.68);
  });
  testWidgets(
    'tier ladder enters in order and highlights the current member tier',
    (tester) async {
      await tester.pumpWidget(
        motionHost(
          SizedBox(
            width: 180,
            child: RewardsTierLadder(
              tiers: rewardsFixture().rewards,
              user: rewardUser(),
              points: 680000,
            ),
          ),
        ),
      );
      double opacity(int index) => tester
          .widget<Opacity>(
            find.descendant(
              of: find.byType(RewardEntrance).at(index),
              matching: find.byType(Opacity),
            ),
          )
          .opacity;
      expect(opacity(0), 0);
      expect(opacity(1), 0);
      await tester.pump(AppMotion.stagger);
      expect(opacity(0), greaterThan(0));
      expect(opacity(1), lessThan(opacity(0)));
      await tester.pumpAndSettle();
      expect(opacity(2), 1);
      final Container selected = tester.widget<Container>(
        find.byKey(const ValueKey<String>('reward-tier-1')),
      );
      expect(
        (selected.decoration! as BoxDecoration).color,
        isNot(Colors.transparent),
      );
      expect(find.text('You’re here now'), findsOneWidget);
    },
  );
  testWidgets(
    'Reward badge pop is finite and reduced motion skips its entrance',
    (tester) async {
      await tester.pumpWidget(
        motionHost(const RewardEntrance(pop: true, child: Text('Rewards 3'))),
      );
      expect(tester.widget<Opacity>(find.byType(Opacity)).opacity, 0);
      await tester.pumpAndSettle();
      expect(tester.widget<Opacity>(find.byType(Opacity)).opacity, 1);
      await tester.pumpWidget(
        motionHost(
          const RewardEntrance(
            key: ValueKey<String>('reduced'),
            pop: true,
            child: Text('Rewards 3'),
          ),
          reducedMotion: true,
        ),
      );
      expect(tester.widget<Opacity>(find.byType(Opacity)).opacity, 1);
    },
  );
  testWidgets(
    'complete Earn pulses once and supplies press feedback without changing points',
    (tester) async {
      int presses = 0;
      await tester.pumpWidget(
        motionHost(
          RewardEarnButton(eligible: true, onPressed: () => presses++),
        ),
      );
      await tester.pump(AppMotion.attention ~/ 2);
      final Transform pulse = tester.widget<Transform>(
        find
            .descendant(
              of: find.byType(RewardEarnButton),
              matching: find.byType(Transform),
            )
            .last,
      );
      expect(pulse.transform.storage[0], greaterThan(1));
      await tester.pumpAndSettle();
      final TestGesture touch = await tester.startGesture(
        tester.getCenter(find.text('EARN')),
      );
      await tester.pump();
      expect(
        tester.widget<AnimatedScale>(find.byType(AnimatedScale)).scale,
        0.94,
      );
      await touch.up();
      await tester.pumpAndSettle();
      expect(presses, 1);
      await tester.pumpWidget(
        motionHost(
          RewardEarnButton(eligible: false, onPressed: () => presses++),
        ),
      );
      expect(
        tester.widget<FilledButton>(find.byType(FilledButton)).onPressed,
        isNull,
      );
      final FilledButton disabled = tester.widget<FilledButton>(
        find.byType(FilledButton),
      );
      expect(
        disabled.style!.backgroundColor!.resolve({WidgetState.disabled}),
        AppColors.light.progressTrack,
      );
      expect(
        disabled.style!.foregroundColor!.resolve({WidgetState.disabled}),
        AppColors.light.textMuted,
      );
    },
  );
  testWidgets('Earn Gift indicator moves through an intermediate position', (
    tester,
  ) async {
    int selected = 0;
    await tester.pumpWidget(
      motionHost(
        SizedBox(
          width: 300,
          child: StatefulBuilder(
            builder: (context, setState) => RewardsTabs(
              selected: selected,
              onSelected: (v) => setState(() => selected = v),
            ),
          ),
        ),
      ),
    );
    final Finder indicator = find.byKey(
      const ValueKey<String>('rewards-tab-indicator'),
    );
    final double begin = tester.getRect(indicator).left;
    await tester.ensureVisible(find.text('Gift'));
    await tester.tap(find.text('Gift'));
    await tester.pump();
    await tester.pump(AppMotion.standard ~/ 2);
    final double middle = tester.getRect(indicator).left;
    expect(middle, greaterThan(begin));
    await tester.pumpAndSettle();
    expect(tester.getRect(indicator).left, greaterThan(middle));
  });
  testWidgets('Rewards data drives challenge states and Gift list transition', (
    tester,
  ) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(369, 800);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.view.resetPhysicalSize);
    await tester.pumpWidget(rewardPageHost());
    await tester.pumpAndSettle();
    expect(find.text('680,000'), findsOneWidget);
    expect(find.text('Rewards 1'), findsOneWidget);
    expect(find.text('4/4 • 100% complete'), findsOneWidget);
    expect(find.text('1/4 • 25% complete'), findsOneWidget);
    expect(find.text('9/12 • 75% complete'), findsOneWidget);
    final List<FilledButton> buttons = tester
        .widgetList<FilledButton>(find.byType(FilledButton))
        .toList();
    expect(buttons.first.onPressed, isNotNull);
    expect(buttons[1].onPressed, isNull);
    await tester.ensureVisible(find.text('Gift'));
    await tester.tap(find.text('Gift'));
    await tester.pump();
    expect(find.byType(AnimatedSwitcher), findsOneWidget);
    await tester.pumpAndSettle();
    expect(find.text('Donut gift'), findsOneWidget);
    expect(find.text('4/4 • 100% complete'), findsNothing);
    expect(tester.takeException(), isNull);
  });
  testWidgets('Rewards remains readable at 320 width and 1.3 text scale', (
    tester,
  ) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(320, 700);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.view.resetPhysicalSize);
    await tester.pumpWidget(
      rewardPageHost(reducedMotion: true, textScale: 1.3),
    );
    await tester.pumpAndSettle();
    expect(find.text('680,000'), findsOneWidget);
    expect(tester.takeException(), isNull);
    await tester.ensureVisible(find.text('Gift'));
    await tester.tap(find.text('Gift'));
    await tester.pumpAndSettle();
    expect(find.text('Donut gift'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
