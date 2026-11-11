import 'package:flutter/material.dart';

import '../../../../core/motion/app_motion.dart';
import '../../../../core/theme/app_theme.dart';

/// One shared pill moves with the selected destination.
class AnimatedTabBar extends StatelessWidget {
  const AnimatedTabBar({
    super.key,
    required this.currentIndex,
    required this.onSelected,
    required this.labels,
    required this.icons,
  }) : assert(labels.length == icons.length);
  final int currentIndex;
  final ValueChanged<int> onSelected;
  final List<String> labels;
  final List<IconData> icons;

  @override
  Widget build(BuildContext context) {
    final Duration duration = AppMotion.duration(context, AppMotion.standard);
    final ColorScheme colors = context.colorScheme;
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        // Keep four unselected tap targets at least 44px on narrow phones.
        final int selectedWeight = constraints.maxWidth < 310 ? 2 : 3;
        final double unit =
            constraints.maxWidth / (labels.length - 1 + selectedWeight);
        return SizedBox(
          height: 48,
          child: Stack(
            children: [
              AnimatedPositioned(
                duration: duration,
                curve: AppMotion.curve,
                top: 0,
                bottom: 0,
                left: currentIndex * unit,
                width: selectedWeight * unit,
                child: DecoratedBox(
                  key: const ValueKey('navigation-pill'),
                  decoration: ShapeDecoration(
                    color: colors.secondary,
                    shape: StadiumBorder(
                      side: BorderSide(color: colors.surface),
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  for (int index = 0; index < labels.length; index++)
                    AnimatedContainer(
                      duration: duration,
                      curve: AppMotion.curve,
                      width:
                          unit * (index == currentIndex ? selectedWeight : 1),
                      height: 48,
                      child: Semantics(
                        selected: index == currentIndex,
                        button: true,
                        label: labels[index],
                        child: Tooltip(
                          message: labels[index],
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              customBorder: const StadiumBorder(),
                              onTap: () => onSelected(index),
                              child: ExcludeSemantics(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      icons[index],
                                      size: 22,
                                      color: colors.onPrimary,
                                    ),
                                    if (index == currentIndex) ...[
                                      const SizedBox(width: 6),
                                      Flexible(
                                        child: Text(
                                          labels[index],
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: context.textTheme.labelMedium
                                              ?.copyWith(
                                                color: colors.onPrimary,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
