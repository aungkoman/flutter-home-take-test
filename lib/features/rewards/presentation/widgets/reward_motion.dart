import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../core/motion/app_motion.dart';
import '../../../../core/theme/app_theme.dart';

/// A finite entrance that does not keep hidden tabs or widget tests ticking.
class RewardEntrance extends StatefulWidget {
  const RewardEntrance({
    super.key,
    required this.child,
    this.index = 0,
    this.pop = false,
  });
  final Widget child;
  final int index;
  final bool pop;
  @override
  State<RewardEntrance> createState() => _RewardEntranceState();
}

class _RewardEntranceState extends State<RewardEntrance>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _entrance;
  bool _started = false;

  @override
  void initState() {
    super.initState();
    final Duration delay = AppMotion.stagger * widget.index.clamp(0, 8);
    final Duration total = delay + AppMotion.entrance;
    _controller = AnimationController(vsync: this, duration: total);
    _entrance = CurvedAnimation(
      parent: _controller,
      curve: Interval(
        delay.inMicroseconds / total.inMicroseconds,
        1,
        curve: AppMotion.curve,
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (MediaQuery.disableAnimationsOf(context)) {
      _controller.value = 1;
    } else if (!_started) {
      _controller.forward();
    }
    _started = true;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
    animation: _entrance,
    child: widget.child,
    builder: (context, child) => Opacity(
      opacity: _entrance.value,
      child: Transform.translate(
        offset: Offset(0, (1 - _entrance.value) * 14),
        child: Transform.scale(
          scale: widget.pop ? 0.7 + _entrance.value * 0.3 : 1,
          child: child,
        ),
      ),
    ),
  );
}

class RewardEarnButton extends StatefulWidget {
  const RewardEarnButton({
    super.key,
    required this.eligible,
    required this.onPressed,
  });
  final bool eligible;
  final VoidCallback onPressed;
  @override
  State<RewardEarnButton> createState() => _RewardEarnButtonState();
}

class _RewardEarnButtonState extends State<RewardEarnButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _attention;
  bool _pressed = false;
  bool _started = false;
  @override
  void initState() {
    super.initState();
    _attention = AnimationController(
      vsync: this,
      duration: AppMotion.attention,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (MediaQuery.disableAnimationsOf(context)) {
      _attention.value = 1;
    } else if (!_started && widget.eligible) {
      _attention.forward();
    }
    _started = true;
  }

  @override
  void didUpdateWidget(covariant RewardEarnButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!oldWidget.eligible &&
        widget.eligible &&
        !MediaQuery.disableAnimationsOf(context)) {
      _attention.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _attention.dispose();
    super.dispose();
  }

  void _press(bool value) {
    if (widget.eligible && _pressed != value) setState(() => _pressed = value);
  }

  @override
  Widget build(BuildContext context) => Listener(
    onPointerDown: (_) => _press(true),
    onPointerUp: (_) => _press(false),
    onPointerCancel: (_) => _press(false),
    child: AnimatedScale(
      scale: _pressed ? 0.94 : 1,
      duration: AppMotion.duration(context, AppMotion.fast),
      child: AnimatedBuilder(
        animation: _attention,
        builder: (context, child) => Transform.scale(
          scale: widget.eligible && !MediaQuery.disableAnimationsOf(context)
              ? 1 + math.sin(_attention.value * math.pi) * 0.07
              : 1,
          child: child,
        ),
        child: FilledButton(
          style: FilledButton.styleFrom(
            backgroundColor: context.colorScheme.primary,
            foregroundColor: context.colorScheme.onPrimary,
            disabledBackgroundColor: context.appColors.progressTrack,
            disabledForegroundColor: context.appColors.textMuted,
          ),
          onPressed: widget.eligible ? widget.onPressed : null,
          child: const Text('EARN'),
        ),
      ),
    ),
  );
}
