import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hometake/core/theme/app_theme.dart';
import 'package:hometake/features/home/presentation/widgets/animated_tab_bar.dart';

const List<String> _labels = ['Home', 'Reward', 'Order', 'Wallet', 'Settings'];
const List<IconData> _icons = [
  Icons.home_outlined,
  Icons.workspace_premium_outlined,
  Icons.donut_large_outlined,
  Icons.account_balance_wallet_outlined,
  Icons.settings_outlined,
];
const ValueKey<String> _pillKey = ValueKey('navigation-pill');

Future<void> _pumpBar(
  WidgetTester tester, {
  required double width,
  double textScale = 1,
  bool disableAnimations = false,
  ValueChanged<int>? onSelected,
}) async {
  int currentIndex = 0;
  await tester.pumpWidget(
    MaterialApp(
      theme: AppTheme.light,
      builder: (BuildContext context, Widget? child) => MediaQuery(
        data: MediaQuery.of(context).copyWith(
          textScaler: TextScaler.linear(textScale),
          disableAnimations: disableAnimations,
        ),
        child: child!,
      ),
      home: Scaffold(
        body: Center(
          child: SizedBox(
            width: width,
            child: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) =>
                  AnimatedTabBar(
                    currentIndex: currentIndex,
                    onSelected: (int index) {
                      onSelected?.call(index);
                      setState(() => currentIndex = index);
                    },
                    labels: _labels,
                    icons: _icons,
                  ),
            ),
          ),
        ),
      ),
    ),
  );
}

Finder _destinationSemantics(String label) => find.byWidgetPredicate(
  (Widget widget) =>
      widget is Semantics &&
      widget.properties.label == label &&
      widget.properties.button == true,
);

void main() {
  testWidgets(
    'one shared selection pill slides through intermediate positions',
    (WidgetTester tester) async {
      await _pumpBar(tester, width: 350);
      final Rect start = tester.getRect(find.byKey(_pillKey));
      final Duration duration = tester
          .widget<AnimatedPositioned>(find.byType(AnimatedPositioned))
          .duration;
      expect(duration, greaterThan(Duration.zero));

      await tester.tap(find.byTooltip('Reward'));
      await tester.pump();
      expect(
        tester.getRect(find.byKey(_pillKey)).left,
        closeTo(start.left, 0.01),
      );

      await tester.pump(Duration(microseconds: duration.inMicroseconds ~/ 2));
      final Rect middle = tester.getRect(find.byKey(_pillKey));
      const double unit = 350 / 7;
      expect(middle.left, greaterThan(start.left));
      expect(middle.left, lessThan(start.left + unit));

      await tester.pumpAndSettle();
      final Rect end = tester.getRect(find.byKey(_pillKey));
      expect(end.left, closeTo(start.left + unit, 0.01));
      expect(end.width, closeTo(start.width, 0.01));
      expect(find.byKey(_pillKey), findsOneWidget);
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets(
    'each destination invokes its index and exposes selected semantics',
    (WidgetTester tester) async {
      final List<int> selections = [];
      await _pumpBar(tester, width: 350, onSelected: selections.add);

      for (int index = 0; index < _labels.length; index++) {
        await tester.tap(find.byTooltip(_labels[index]));
        await tester.pumpAndSettle();
        for (int other = 0; other < _labels.length; other++) {
          final Semantics semantics = tester.widget<Semantics>(
            _destinationSemantics(_labels[other]),
          );
          expect(semantics.properties.selected, other == index);
        }
      }
      expect(selections, [0, 1, 2, 3, 4]);
      expect(tester.takeException(), isNull);
    },
  );

  for (final double screenWidth in [320, 369]) {
    testWidgets('all destinations fit at $screenWidth with enlarged text', (
      WidgetTester tester,
    ) async {
      tester.view.devicePixelRatio = 1;
      tester.view.physicalSize = Size(screenWidth, 800);
      addTearDown(tester.view.resetDevicePixelRatio);
      addTearDown(tester.view.resetPhysicalSize);
      // MainShell reserves 54px for its margin, padding and border.
      final double barWidth = screenWidth - 54;
      await _pumpBar(tester, width: barWidth, textScale: 1.3);
      final Rect bar = tester.getRect(find.byType(AnimatedTabBar));
      final int selectedWeight = barWidth < 310 ? 2 : 3;
      final double unit = barWidth / (4 + selectedWeight);

      for (int index = 0; index < _labels.length; index++) {
        await tester.tap(find.byTooltip(_labels[index]));
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull);
        final Rect pill = tester.getRect(find.byKey(_pillKey));
        expect(pill.left, closeTo(bar.left + unit * index, 0.01));
        expect(pill.width, closeTo(unit * selectedWeight, 0.01));
        for (final String label in _labels) {
          final Size targetSize = tester.getSize(find.byTooltip(label));
          expect(targetSize.width, greaterThanOrEqualTo(44));
          expect(targetSize.height, greaterThanOrEqualTo(44));
        }
      }
    });
  }

  testWidgets(
    'Reduce Motion places the pill immediately without an animation',
    (WidgetTester tester) async {
      await _pumpBar(tester, width: 350, disableAnimations: true);
      final Rect start = tester.getRect(find.byKey(_pillKey));
      expect(
        tester
            .widget<AnimatedPositioned>(find.byType(AnimatedPositioned))
            .duration,
        Duration.zero,
      );

      await tester.tap(find.byTooltip('Settings'));
      await tester.pump();
      expect(
        tester.getRect(find.byKey(_pillKey)).left,
        closeTo(start.left + 4 * (350 / 7), 0.01),
      );
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
    },
  );
}
