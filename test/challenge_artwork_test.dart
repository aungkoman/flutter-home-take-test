import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hometake/core/motion/app_motion.dart';
import 'package:hometake/core/theme/app_theme.dart';
import 'package:hometake/features/rewards/presentation/widgets/challenge_artwork.dart';

const String photo = 'assets/images/donut-red.png';

Widget host(Widget child, {bool reducedMotion = false}) => MaterialApp(
  theme: AppTheme.light,
  builder: (BuildContext context, Widget? child) => MediaQuery(
    data: MediaQuery.of(context).copyWith(disableAnimations: reducedMotion),
    child: child!,
  ),
  home: Scaffold(body: Center(child: child)),
);

void main() {
  test('one earned quarter reveals only the clockwise top-right sector', () {
    final Path quarter = ProgressWedgeClipper(progress: 0.25)
        .getClip(const Size(100, 100));
    expect(quarter.contains(const Offset(75, 25)), isTrue);
    expect(quarter.contains(const Offset(25, 25)), isFalse);
    expect(quarter.contains(const Offset(75, 75)), isFalse);
    expect(quarter.contains(const Offset(25, 75)), isFalse);
  });

  test('no progress leaves the image gray and four quarters reveal it all', () {
    expect(
      ProgressWedgeClipper(progress: -1)
          .getClip(const Size(100, 100))
          .contains(const Offset(75, 25)),
      isFalse,
    );
    final Path complete = ProgressWedgeClipper(progress: 2)
        .getClip(const Size(100, 100));
    for (final Offset point in [
      const Offset(25, 25),
      const Offset(75, 25),
      const Offset(25, 75),
      const Offset(75, 75),
    ]) {
      expect(complete.contains(point), isTrue);
    }
  });

  test('nine of twelve coffees paints exactly three quarters of the arc', () {
    final ChallengeArcPainter painter = ChallengeArcPainter(
      progress: 9 / 12,
      color: Colors.orange,
      trackColor: Colors.grey,
    );
    expect(painter.progress, 0.75);
    expect(painter.sweepAngle, closeTo(math.pi * 1.5, 0.0001));
    expect(
      ChallengeArcPainter(
        progress: 3,
        color: Colors.orange,
        trackColor: Colors.grey,
      ).progress,
      1,
    );
  });

  testWidgets('donut color reveal animates from gray to its earned quarter', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      host(const ChallengeArtwork(imagePath: photo, progress: 0.25)),
    );
    ProgressWedgeClipper clipper() =>
        tester
                .widget<ClipPath>(
                  find.descendant(
                    of: find.byType(ChallengeArtwork),
                    matching: find.byType(ClipPath),
                  ),
                )
                .clipper!
            as ProgressWedgeClipper;
    expect(clipper().progress, 0);
    expect(find.byType(ColorFiltered), findsOneWidget);
    await tester.pump(AppMotion.entrance ~/ 2);
    expect(clipper().progress, greaterThan(0));
    expect(clipper().progress, lessThan(0.25));
    await tester.pumpAndSettle();
    expect(clipper().progress, 0.25);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Reduce Motion shows completed donut art immediately', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      host(
        const ChallengeArtwork(imagePath: photo, progress: 1),
        reducedMotion: true,
      ),
    );
    final ProgressWedgeClipper clipper =
        tester
                .widget<ClipPath>(
                  find.descendant(
                    of: find.byType(ChallengeArtwork),
                    matching: find.byType(ClipPath),
                  ),
                )
                .clipper!
            as ProgressWedgeClipper;
    expect(clipper.progress, 1);
    expect(tester.takeException(), isNull);
  });

  testWidgets(
    'Reduce Motion shows the coffee arc at nine of twelve immediately',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        host(
          const ChallengeArtwork(
            imagePath: photo,
            progress: 9 / 12,
            isDrink: true,
          ),
          reducedMotion: true,
        ),
      );
      final CustomPaint customPaint = tester.widget<CustomPaint>(
        find
            .descendant(
              of: find.byType(ChallengeArtwork),
              matching: find.byType(CustomPaint),
            )
            .first,
      );
      expect((customPaint.painter! as ChallengeArcPainter).progress, 0.75);
      expect(tester.takeException(), isNull);
    },
  );
}
