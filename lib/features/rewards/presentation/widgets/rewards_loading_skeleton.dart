import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../product/presentation/widgets/loading_effects.dart';

class RewardsLoadingSkeleton extends StatelessWidget {
  const RewardsLoadingSkeleton({super.key});
  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = context.colorScheme;
    final AppColors appColors = context.appColors;
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: appColors.blushHeader,
              padding: const EdgeInsets.fromLTRB(22, 24, 22, 24),
              child: Column(
                children: [
                  const Row(
                    children: [
                      SkeletonBlock(width: 170, height: 26),
                      Spacer(),
                      SkeletonBlock(
                        width: 94,
                        height: 38,
                        borderRadius: AppRadii.cardXl,
                      ),
                    ],
                  ),
                  const SizedBox(height: 28),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for (int index = 0; index < 3; index++) ...[
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SkeletonBlock(
                                    width: 32,
                                    height: 36,
                                    borderRadius: 18,
                                  ),
                                  const SizedBox(width: AppSpacing.sm),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SkeletonBlock(
                                          width: index == 1 ? 76 : 95,
                                          height: 15,
                                        ),
                                        const SizedBox(height: 6),
                                        const SkeletonBlock(
                                          width: 112,
                                          height: 11,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              if (index < 2)
                                const Padding(
                                  padding: EdgeInsets.only(left: 15, top: 4),
                                  child: SkeletonBlock(
                                    width: 2,
                                    height: 20,
                                    borderRadius: 1,
                                  ),
                                ),
                              if (index < 2)
                                const SizedBox(height: AppSpacing.sm),
                            ],
                          ],
                        ),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      const SkeletonBlock(
                        width: 132,
                        height: 132,
                        borderRadius: 66,
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  const SkeletonBlock(width: 230, height: 14),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 22),
              child: Row(
                children: [
                  Expanded(
                    child: SkeletonBlock(
                      width: double.infinity,
                      height: 42,
                      borderRadius: AppRadii.cardXl,
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: SkeletonBlock(
                      width: double.infinity,
                      height: 42,
                      borderRadius: AppRadii.cardXl,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(22, 16, 22, 140),
              child: Column(
                children: [
                  for (int index = 0; index < 3; index++) ...[
                    Container(
                      margin: const EdgeInsets.only(bottom: AppSpacing.lg),
                      padding: const EdgeInsets.all(AppSpacing.lg),
                      decoration: BoxDecoration(
                        color: colorScheme.surface,
                        borderRadius: BorderRadius.circular(AppRadii.cardLg),
                      ),
                      child: Row(
                        children: [
                          const SkeletonBlock(
                            width: 88,
                            height: 88,
                            borderRadius: 44,
                          ),
                          const SizedBox(width: AppSpacing.lg),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SkeletonBlock(
                                  width: index == 1 ? 150 : 185,
                                  height: 16,
                                ),
                                const SizedBox(height: 10),
                                const SkeletonBlock(width: 74, height: 13),
                                const SizedBox(height: AppSpacing.md),
                                const Row(
                                  children: [
                                    SkeletonBlock(
                                      width: 78,
                                      height: 34,
                                      borderRadius: 18,
                                    ),
                                    SizedBox(width: AppSpacing.md),
                                    SkeletonBlock(width: 48, height: 13),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
