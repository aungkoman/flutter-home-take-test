import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../core/motion/app_motion.dart';
import '../../../../core/theme/app_theme.dart';

/// Uses the photo itself to communicate earned quarters instead of a second bar.
class ChallengeArtwork extends StatelessWidget {
  const ChallengeArtwork({
    super.key,
    required this.imagePath,
    required this.progress,
    this.isDrink = false,
  });

  final String imagePath;
  final double progress;
  final bool isDrink;

  @override
  Widget build(BuildContext context) {
    final double bounded = progress.clamp(0, 1).toDouble();
    final double target = isDrink ? bounded : (bounded * 4).floor() / 4;
    final bool reducedMotion = MediaQuery.disableAnimationsOf(context);
    return Semantics(
      label: 'Challenge progress',
      value: '${(bounded * 100).round()} percent',
      child: SizedBox(
        width: 96,
        height: 100,
        child: TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: reducedMotion ? target : 0, end: target),
          duration: AppMotion.duration(context, AppMotion.entrance),
          curve: AppMotion.curve,
          builder: (BuildContext context, double value, Widget? child) =>
              isDrink ? _coffee(context, value) : _donut(value),
        ),
      ),
    );
  }

  Widget _photo() => Image.asset(
    imagePath,
    fit: BoxFit.contain,
    excludeFromSemantics: true,
    errorBuilder: (
      BuildContext context,
      Object error,
      StackTrace? stackTrace,
    ) => const Icon(Icons.bakery_dining_outlined, size: 48),
  );

  Widget _coffee(BuildContext context, double value) => CustomPaint(
    painter: ChallengeArcPainter(
      progress: value,
      color: context.appColors.orangeBadge,
      trackColor: context.appColors.progressTrack,
    ),
    child: Padding(padding: const EdgeInsets.all(16), child: _photo()),
  );

  Widget _donut(double value) => Stack(
    fit: StackFit.expand,
    children: [
      ColorFiltered(
        colorFilter: const ColorFilter.matrix([
          0.2126,
          0.7152,
          0.0722,
          0,
          0,
          0.2126,
          0.7152,
          0.0722,
          0,
          0,
          0.2126,
          0.7152,
          0.0722,
          0,
          0,
          0,
          0,
          0,
          1,
          0,
        ]),
        child: _photo(),
      ),
      ClipPath(
        clipper: ProgressWedgeClipper(progress: value),
        child: _photo(),
      ),
    ],
  );
}

/// A clockwise reveal beginning at twelve o'clock; one quarter colors one sector.
class ProgressWedgeClipper extends CustomClipper<Path> {
  ProgressWedgeClipper({required double progress})
    : progress = progress.clamp(0, 1).toDouble();

  final double progress;

  @override
  Path getClip(Size size) {
    if (progress == 0) return Path();
    if (progress == 1) return Path()..addRect(Offset.zero & size);
    final Offset center = size.center(Offset.zero);
    // An oversized pie covers the rectangular image, including its outer corners.
    final Rect arc = Rect.fromCircle(
      center: center,
      radius: math.max(size.width, size.height),
    );
    return Path()
      ..moveTo(center.dx, center.dy)
      ..arcTo(arc, -math.pi / 2, math.pi * 2 * progress, false)
      ..close();
  }

  @override
  bool shouldReclip(ProgressWedgeClipper oldClipper) =>
      oldClipper.progress != progress;
}

/// Paints a proportionate coffee challenge arc around the existing cup photo.
class ChallengeArcPainter extends CustomPainter {
  ChallengeArcPainter({
    required double progress,
    required this.color,
    required this.trackColor,
  }) : progress = progress.clamp(0, 1).toDouble();

  final double progress;
  final Color color;
  final Color trackColor;
  static const double strokeWidth = 7;

  double get sweepAngle => math.pi * 2 * progress;

  @override
  void paint(Canvas canvas, Size size) {
    final Rect bounds = Rect.fromCircle(
      center: size.center(Offset.zero),
      radius: (math.min(size.width, size.height) - strokeWidth) / 2,
    );
    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..color = trackColor;
    canvas.drawArc(bounds, -math.pi / 2, math.pi * 2, false, paint);
    if (progress == 0) return;
    paint.color = color;
    canvas.drawArc(bounds, -math.pi / 2, sweepAngle, false, paint);
  }

  @override
  bool shouldRepaint(ChallengeArcPainter oldDelegate) =>
      oldDelegate.progress != progress ||
      oldDelegate.color != color ||
      oldDelegate.trackColor != trackColor;
}
