import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../core/motion/app_motion.dart';
import '../../../../core/theme/app_theme.dart';

String rewardNumber(int value) => value.toString().replaceAllMapped(
  RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
  (Match match) => '${match[1]},',
);

class RewardsPointsRing extends StatelessWidget {
  const RewardsPointsRing({
    super.key,
    required this.points,
    required this.progress,
  });
  final int points;
  final double progress;

  @override
  Widget build(BuildContext context) => Semantics(
    label: 'Total points ${rewardNumber(points)}. Progress to next reward tier',
    value: '${(progress.clamp(0, 1) * 100).round()} percent',
    child: ExcludeSemantics(
      child: TweenAnimationBuilder<double>(
        key: ValueKey<String>('$points/$progress'),
        tween: Tween<double>(begin: 0, end: 1),
        duration: AppMotion.duration(context, AppMotion.rewards),
        curve: AppMotion.curve,
        builder: (BuildContext context, double value, Widget? child) =>
            AspectRatio(
              aspectRatio: 1,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned.fill(
                    child: CustomPaint(
                      painter: RewardsRingPainter(
                        progress: progress.clamp(0, 1) * value,
                        color: context.colorScheme.secondary,
                        trackColor: context.appColors.progressTrack,
                        sprinkleColor: context.colorScheme.onSecondary,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Total points',
                          textAlign: TextAlign.center,
                          style: context.textTheme.labelMedium?.copyWith(
                            color: context.colorScheme.secondary,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            rewardNumber((points * value).round()),
                            key: const ValueKey<String>('rewards-point-total'),
                            style: context.textTheme.headlineMedium?.copyWith(
                              color: context.colorScheme.secondary,
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
    ),
  );
}

class RewardsRingPainter extends CustomPainter {
  RewardsRingPainter({
    required double progress,
    required this.color,
    required this.trackColor,
    required this.sprinkleColor,
  }) : progress = progress.clamp(0, 1);
  final double progress;
  final Color color;
  final Color trackColor;
  final Color sprinkleColor;

  @override
  void paint(Canvas canvas, Size size) {
    final double stroke = size.shortestSide * 0.19;
    final Offset center = size.center(Offset.zero);
    final double radius = (size.shortestSide - stroke) / 2;
    final Rect bounds = Rect.fromCircle(center: center, radius: radius);
    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round;
    canvas.drawCircle(center, radius, paint..color = trackColor);
    if (progress <= 0) return;
    canvas.drawArc(
      bounds,
      -math.pi / 2,
      math.pi * 2 * progress,
      false,
      paint..color = color,
    );
    final Paint sprinkle = Paint()
      ..color = sprinkleColor.withValues(alpha: 0.45)
      ..strokeWidth = stroke * 0.1
      ..strokeCap = StrokeCap.round;
    for (int index = 0; index < 20; index++) {
      final double fraction = (index + 0.5) / 20;
      if (fraction > progress) break;
      final double angle = -math.pi / 2 + math.pi * 2 * fraction;
      final double sprinkleRadius =
          radius + (index.isEven ? 1 : -1) * stroke * 0.18;
      final Offset at =
          center + Offset(math.cos(angle), math.sin(angle)) * sprinkleRadius;
      final Offset direction =
          Offset(math.cos(angle + 0.7), math.sin(angle + 0.7)) * stroke * 0.11;
      canvas.drawLine(at - direction, at + direction, sprinkle);
    }
  }

  @override
  bool shouldRepaint(covariant RewardsRingPainter oldDelegate) =>
      progress != oldDelegate.progress ||
      color != oldDelegate.color ||
      trackColor != oldDelegate.trackColor ||
      sprinkleColor != oldDelegate.sprinkleColor;
}
