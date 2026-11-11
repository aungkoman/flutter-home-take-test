import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_theme.dart';

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
    final ColorScheme colorScheme = context.colorScheme;
    final AppColors appColors = context.appColors;
    return Scaffold(
      extendBody: true,
      backgroundColor: appColors.pageBackground,
      body: navigationShell,
      bottomNavigationBar: GoRouterState.of(context).uri.path.startsWith('/home/')
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
                    child: ColoredBox(color: colorScheme.secondary),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(18, 0, 18, 0),
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.sm,
                      vertical: AppSpacing.md,
                    ),
                    decoration: BoxDecoration(
                      color: colorScheme.primary,
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(AppRadii.cardXl),
                      ),
                      border: Border.all(color: colorScheme.surface),
                    ),
                    child: Row(
                      children: [
                        for (int index = 0; index < _labels.length; index++)
                          Expanded(
                            flex: navigationShell.currentIndex == index ? 3 : 1,
                            child: Semantics(
                              selected: navigationShell.currentIndex == index,
                              button: true,
                              label: _labels[index],
                              child: Tooltip(
                                message: _labels[index],
                                child: Material(
                                  color: navigationShell.currentIndex == index
                                      ? colorScheme.secondary
                                      : Colors.transparent,
                                  shape: StadiumBorder(
                                    side: BorderSide(
                                      color:
                                          navigationShell.currentIndex == index
                                          ? colorScheme.surface
                                          : Colors.transparent,
                                    ),
                                  ),
                                  child: InkWell(
                                    customBorder: const StadiumBorder(),
                                    onTap: () => navigationShell.goBranch(
                                      index,
                                      initialLocation:
                                          index == navigationShell.currentIndex,
                                    ),
                                    child: SizedBox(
                                      height: 48,
                                      child: ExcludeSemantics(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              _icons[index],
                                              size: 22,
                                              color: colorScheme.onPrimary,
                                            ),
                                            if (navigationShell.currentIndex ==
                                                index) ...[
                                              const SizedBox(width: 6),
                                              Flexible(
                                                child: Text(
                                                  _labels[index],
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: context
                                                      .textTheme
                                                      .labelMedium
                                                      ?.copyWith(
                                                        color: colorScheme
                                                            .onPrimary,
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
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
