import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_theme.dart';
import 'widgets/animated_tab_bar.dart';

class MainShell extends StatelessWidget {
  const MainShell({super.key, required this.navigationShell});
  final StatefulNavigationShell navigationShell;

  static const List<String> _labels = [
    'Home',
    'Reward',
    'Order',
    'Wallet',
    'Settings',
  ];
  static const List<IconData> _icons = [
    Icons.home_outlined,
    Icons.workspace_premium_outlined,
    Icons.donut_large_outlined,
    Icons.account_balance_wallet_outlined,
    Icons.settings_outlined,
  ];

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = context.colorScheme;
    return Scaffold(
      extendBody: true,
      backgroundColor: context.appColors.pageBackground,
      body: navigationShell,
      bottomNavigationBar:
          GoRouterState.of(context).uri.path.startsWith('/home/')
          ? null
          : SafeArea(
              top: false,
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    height: 32,
                    child: ColoredBox(color: colors.secondary),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 18),
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.sm,
                      vertical: AppSpacing.md,
                    ),
                    decoration: BoxDecoration(
                      color: colors.primary,
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(AppRadii.cardXl),
                      ),
                      border: Border.all(color: colors.surface),
                    ),
                    child: AnimatedTabBar(
                      currentIndex: navigationShell.currentIndex,
                      labels: _labels,
                      icons: _icons,
                      onSelected: (int index) => navigationShell.goBranch(
                        index,
                        initialLocation: index == navigationShell.currentIndex,
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
