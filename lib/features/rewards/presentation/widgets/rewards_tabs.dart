import 'package:flutter/material.dart';

import '../../../../core/motion/app_motion.dart';
import '../../../../core/theme/app_theme.dart';

class RewardsTabs extends StatelessWidget {
  const RewardsTabs({
    super.key,
    required this.selected,
    required this.onSelected,
  });
  final int selected;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 22),
    child: LayoutBuilder(
      builder: (context, constraints) {
        final double wide = constraints.maxWidth * 0.76;
        final double narrow = constraints.maxWidth - wide;
        return SizedBox(
          height: 48,
          child: Stack(
            children: [
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: context.appColors.pageBackground,
                    borderRadius: BorderRadius.circular(AppRadii.pill),
                  ),
                ),
              ),
              AnimatedPositioned(
                key: const ValueKey<String>('rewards-tab-indicator'),
                duration: AppMotion.duration(context, AppMotion.standard),
                curve: AppMotion.curve,
                left: selected == 0 ? 0 : wide,
                top: 0,
                bottom: 0,
                width: selected == 0 ? wide : narrow,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: context.colorScheme.primary,
                    borderRadius: BorderRadius.circular(AppRadii.pill),
                    border: Border.all(
                      color: context.colorScheme.surface,
                      width: 2,
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  _tab(context, 0, 'Eat more Earn more', wide),
                  _tab(context, 1, 'Gift', narrow),
                ],
              ),
            ],
          ),
        );
      },
    ),
  );

  Widget _tab(BuildContext context, int index, String label, double width) =>
      SizedBox(
        width: width,
        height: 48,
        child: Semantics(
          selected: selected == index,
          button: true,
          label: label,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(AppRadii.pill),
              onTap: () => onSelected(index),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.textTheme.labelMedium?.copyWith(
                      fontSize: 13,
                      fontWeight: selected == index
                          ? FontWeight.w700
                          : FontWeight.w400,
                      color: selected == index
                          ? context.colorScheme.onPrimary
                          : context.appColors.textMuted,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}
