import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../auth/presentation/providers/session_provider.dart';
import '../../../auth/presentation/providers/login_provider.dart';
import '../../../auth/presentation/providers/otp_verify_provider.dart';
import '../../../auth/presentation/providers/register_provider.dart';

import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../home/presentation/widgets/tab_ui.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ColorScheme colorScheme = context.colorScheme;
    final AppColors appColors = context.appColors;
    final TextTheme textTheme = context.textTheme;
    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: appColors.headerCyan,
              padding: const EdgeInsets.fromLTRB(24, 28, 24, 20),
              child: SafeArea(
                bottom: false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 26,
                          backgroundColor: colorScheme.secondary,
                          child: Icon(
                            Icons.person_outline,
                            color: colorScheme.onSecondary,
                            size: 34,
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Your account',
                                style: textTheme.headlineSmall?.copyWith(
                                  fontSize: 23,
                                ),
                              ),
                              const SizedBox(height: AppSpacing.xs),
                              const Text('J’Donuts customer'),
                            ],
                          ),
                        ),
                        TextButton(
                          onPressed: () => showTabSheet(
                            context,
                            'Edit Profile',
                            'Your profile details will appear here.',
                          ),
                          child: const Text('EDIT'),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        backgroundColor: colorScheme.surface,
                      ),
                      onPressed: () => showTabSheet(
                        context,
                        'Membership',
                        'Explore Silver, Gold and Platinum rewards.',
                      ),
                      label: const Text('E-wallet Customer'),
                      icon: const Icon(Icons.chevron_right),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            _item(
              context,
              Icons.assignment_outlined,
              'My Orders',
              'No orders yet.',
            ),
            _item(
              context,
              Icons.favorite_border,
              'My Favorites',
              'No favorites yet.',
            ),
            _item(
              context,
              Icons.person_outline,
              'Account',
              'Your account details will appear here.',
            ),
            _item(
              context,
              Icons.confirmation_number_outlined,
              'Promotions',
              'No promotions available.',
            ),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 28),
              minVerticalPadding: 12,
              leading: const Icon(Icons.translate),
              title: const Text('Language'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'ENGLISH',
                    style: textTheme.labelMedium?.copyWith(
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const Icon(Icons.chevron_right),
                ],
              ),
              onTap: () => showTabSheet(context, 'Language', 'English'),
            ),
            _item(context, Icons.info_outline, 'About', 'Welcome to J’Donuts.'),
            _item(
              context,
              Icons.article_outlined,
              'Terms & Conditions',
              'Terms and conditions will appear here.',
            ),
            _item(
              context,
              Icons.fact_check_outlined,
              'Privacy Policy',
              'Privacy policy will appear here.',
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () async {
                final bool cleared = await ref
                    .read(sessionProvider.notifier)
                    .signOut();
                if (!context.mounted) return;
                if (!cleared) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Could not log out. Try again.'),
                    ),
                  );
                  return;
                }
                ref.invalidate(loginProvider);
                ref.invalidate(otpVerifyProvider);
                ref.invalidate(registerProvider);
                context.go('/');
              },
            ),
            const SizedBox(height: 20),
            Text(
              'J’Donuts',
              style: textTheme.titleMedium?.copyWith(
                color: appColors.textMuted,
              ),
            ),
            const SizedBox(height: 140),
          ],
        ),
      ),
    );
  }

  Widget _item(
    BuildContext context,
    IconData icon,
    String title,
    String message,
  ) => ListTile(
    contentPadding: const EdgeInsets.symmetric(horizontal: 28),
    minVerticalPadding: 12,
    leading: Icon(icon),
    title: Text(title),
    trailing: const Icon(Icons.chevron_right),
    onTap: () => showTabSheet(context, title, message),
  );
}
