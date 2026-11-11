import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_theme.dart';
import '../widgets/donut_sticker.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

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
            top: -40,
            left: -40,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: appColors.cyanLight,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            top: 100,
            left: 50,
            right: 50,
            child: Container(
              height: 250,
              decoration: BoxDecoration(
                color: appColors.pinkSoft,
                shape: BoxShape.circle,
              ),
            ),
          ),
          const Positioned(
            top: 8,
            left: 10,
            child: DonutSticker(
              asset: 'assets/images/donut-red.png',
              size: 112,
              rotation: -0.22,
            ),
          ),
          Positioned(
            top: 122,
            left: 0,
            child: DonutSticker(
              asset: 'assets/images/donut-yellow.png',
              size: 118,
              backgroundColor: appColors.pinkSoft,
              rotation: 0.18,
            ),
          ),
          const Positioned(
            top: 174,
            right: 18,
            child: DonutSticker(
              asset: 'assets/images/donut-brown.png',
              size: 104,
              rotation: -0.35,
            ),
          ),
          const Positioned(
            top: 270,
            right: 48,
            child: DonutSticker(
              asset: 'assets/images/donut-red.png',
              size: 68,
              rotation: 0.3,
            ),
          ),

          // Foreground Content
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Title
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.xl,
                  ),
                  child: Text(
                    'Round food for\nevery mood',
                    textAlign: TextAlign.center,
                    style: textTheme.displaySmall?.copyWith(
                      fontSize: 36,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.xxl),

                // Primary Action Button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {
                        context.go('/login');
                      },
                      child: Text(
                        'LET\'S GET STARTED',
                        style: textTheme.labelLarge?.copyWith(
                          fontSize: 16,
                          letterSpacing: 1.2,
                          color: colorScheme.onPrimary,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),

                // Secondary Login Text
                GestureDetector(
                  onTap: () => context.go('/login'),
                  child: RichText(
                    text: TextSpan(
                      text: 'Already have an account? ',
                      style: textTheme.bodyMedium?.copyWith(fontSize: 15),
                      children: [
                        TextSpan(
                          text: 'Log In',
                          style: TextStyle(
                            color: colorScheme.secondary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.xxl),

                // Social Icons Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildSocialIcon(
                      context,
                      Icons.g_mobiledata,
                      appColors.socialGoogle,
                    ),
                    const SizedBox(width: AppSpacing.xl),
                    _buildSocialIcon(
                      context,
                      Icons.apple,
                      appColors.socialApple,
                    ),
                    const SizedBox(width: AppSpacing.xl),
                    _buildSocialIcon(
                      context,
                      Icons.facebook,
                      appColors.socialFacebook,
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.xxl),

                // Footer Terms
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.xxl,
                  ),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text:
                          'By continuing, you acknowledge that you have read and\nagree to our ',
                      style: textTheme.labelSmall?.copyWith(
                        fontSize: 12,
                        height: 1.5,
                      ),
                      children: [
                        TextSpan(
                          text: 'Terms of Use',
                          style: TextStyle(color: colorScheme.secondary),
                        ),
                        const TextSpan(text: ' and '),
                        TextSpan(
                          text: 'Privacy Policy.',
                          style: TextStyle(color: colorScheme.secondary),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper widget to generate consistent social icons
  Widget _buildSocialIcon(BuildContext context, IconData icon, Color color) {
    final ColorScheme colorScheme = context.colorScheme;
    final AppColors appColors = context.appColors;
    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: appColors.shadow,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: IconButton(icon: Icon(icon, color: color, size: 28), onPressed: () {}),
    );
  }
}
