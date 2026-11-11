import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_theme.dart';
import '../widgets/donut_sticker.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = context.colorScheme;
    final AppColors appColors = context.appColors;
    final TextTheme textTheme = context.textTheme;
    return Scaffold(
      backgroundColor: appColors.blushBackground,
      body: Stack(
        children: [
          Positioned(
            top: -20,
            left: -20,
            child: DonutSticker(
              asset: 'assets/images/donut-brown.png',
              size: 205,
              backgroundColor: appColors.placeholderSky,
              rotation: -0.2,
            ),
          ),
          Positioned(
            top: 40,
            right: -40,
            child: DonutSticker(
              asset: 'assets/images/donut-red.png',
              size: 195,
              backgroundColor: appColors.pinkSoft,
              rotation: 0.18,
            ),
          ),
          Positioned(
            top: 250,
            left: -30,
            child: DonutSticker(
              asset: 'assets/images/donut-yellow.png',
              size: 180,
              backgroundColor: appColors.pinkSoft,
              rotation: -0.32,
            ),
          ),
          Positioned(
            top: 350,
            right: -20,
            child: DonutSticker(
              asset: 'assets/images/donut-brown.png',
              size: 178,
              backgroundColor: appColors.placeholderPeach,
              rotation: 0.25,
            ),
          ),
          const Positioned(
            top: 195,
            right: 112,
            child: DonutSticker(
              asset: 'assets/images/donut-yellow.png',
              size: 78,
              rotation: 0.2,
            ),
          ),
          const Positioned(
            top: 430,
            left: 115,
            child: DonutSticker(
              asset: 'assets/images/donut-red.png',
              size: 64,
              rotation: -0.3,
            ),
          ),

          // Gradient overlay for bottom section text
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    colorScheme.surface.withValues(alpha: 0.0),
                    appColors.blushBackground.withValues(alpha: 0.8),
                    appColors.blushBackground,
                  ],
                  stops: const [0.5, 0.7, 1.0],
                ),
              ),
            ),
          ),

          // Content overlay
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Spacer(),
                Text(
                  'Welcome to the\nworld of J\'donuts',
                  textAlign: TextAlign.center,
                  style: textTheme.headlineLarge,
                ),
                const SizedBox(height: AppSpacing.xxl),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: AppSpacing.xxl,
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () => context.go('/home'),
                      child: Text(
                        'LET\'S EXPLORE',
                        style: textTheme.labelLarge?.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.5,
                          color: colorScheme.onPrimary,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
