import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
  Widget build(BuildContext context) => Scaffold(
    extendBody: true,
    backgroundColor: const Color(0xFFF0F1F3),
    body: navigationShell,
    bottomNavigationBar: SafeArea(
      top: false,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: 32,
            child: ColoredBox(color: Color(0xFFDC629F)),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(18, 0, 18, 0),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFF60C1DE),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(24),
              ),
              border: Border.all(color: Colors.white),
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
                              ? const Color(0xFFDC629F)
                              : Colors.transparent,
                          shape: StadiumBorder(
                            side: BorderSide(
                              color: navigationShell.currentIndex == index
                                  ? Colors.white
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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      _icons[index],
                                      size: 22,
                                      color: Colors.white,
                                    ),
                                    if (navigationShell.currentIndex ==
                                        index) ...[
                                      const SizedBox(width: 6),
                                      Flexible(
                                        child: Text(
                                          _labels[index],
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 12,
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
