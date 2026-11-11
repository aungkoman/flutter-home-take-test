import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_theme.dart';

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
          // Background layout with donuts (placeholders used here as we don't have the assets)
          Positioned(
            top: -20,
            left: -20,
            child: _buildPlaceholderDonut(
              context,
              appColors.placeholderSky,
              colorScheme.primary,
            ),
          ),
          Positioned(
            top: 40,
            right: -40,
            child: _buildPlaceholderDonut(
              context,
              appColors.pinkSoft,
              colorScheme.secondary,
            ),
          ),
          Positioned(
            top: 250,
            left: -30,
            child: _buildPlaceholderDonut(
              context,
              appColors.pinkSoft,
              appColors.pinkDeep,
            ),
          ),
          Positioned(
            top: 350,
            right: -20,
            child: _buildPlaceholderDonut(
              context,
              appColors.placeholderPeach,
              appColors.placeholderCocoa,
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

  // Helper method to create placeholder colored squares for the donuts
  Widget _buildPlaceholderDonut(
    BuildContext context,
    Color bgColor,
    Color donutColor,
  ) {
    return Container(
      width: 220,
      height: 280,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(AppRadii.pill),
      ),
      child: Center(
        child: Container(
          width: 140,
          height: 140,
          decoration: BoxDecoration(
            color: donutColor,
            shape: BoxShape.circle,
            border: Border.all(
              color: context.colorScheme.surface.withValues(alpha: 0.3),
              width: 20,
            ),
          ),
        ),
      ),
    );
  }
}
