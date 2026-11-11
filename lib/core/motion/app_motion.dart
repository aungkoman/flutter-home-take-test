import 'package:flutter/material.dart';

/// Shared timings for purposeful UI motion. Reduce Motion skips decoration.
abstract final class AppMotion {
  static const Duration fast = Duration(milliseconds: 150);
  static const Duration standard = Duration(milliseconds: 300);
  static const Duration entrance = Duration(milliseconds: 500);
  static const Duration rewards = Duration(milliseconds: 1200);
  static const Duration stagger = Duration(milliseconds: 80);
  static const Duration attention = Duration(milliseconds: 700);
  static const Curve curve = Curves.easeOutCubic;

  static Duration duration(BuildContext context, Duration normal) =>
      MediaQuery.disableAnimationsOf(context) ? Duration.zero : normal;
}
