import 'dart:developer' show log;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../auth/domain/entities/user_entity.dart';
import '../../../cart/presentation/providers/cart_provider.dart';
import '../../../cart/presentation/providers/selected_shop_provider.dart';
import '../../../cart/presentation/widgets/shop_selector_dialog.dart';

class HomeAccountHeader extends ConsumerWidget {
  const HomeAccountHeader({super.key, required this.user});

  final UserEntity? user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ColorScheme colorScheme = context.colorScheme;
    final AppColors appColors = context.appColors;
    final TextTheme textTheme = context.textTheme;
    final int cartCount =
        ref
            .watch(cartProvider)
            .value
            ?.fold<int>(0, (total, item) => total + item.quantity) ??
        0;
    final ShopEntity? selectedShop = ref.watch(selectedShopProvider).value;
    final String name = user == null
        ? "Welcome to J' Donuts"
        : '${user!.firstName} ${user!.lastName}'.trim();
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 24, 16, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 54,
                  height: 54,
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: appColors.pinkSoft,
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    'assets/images/home-01-j-donuts-new-logo-1.png',
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name.isEmpty ? 'Hello, donut lover' : name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.headlineSmall?.copyWith(fontSize: 21),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        user?.phone ?? 'A little moment of joy',
                        style: textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                IconButton(
                  tooltip: 'View catalog',
                  onPressed: () => context.push('/home/catalog'),
                  icon: const Icon(Icons.grid_view_rounded),
                  style: IconButton.styleFrom(
                    backgroundColor: colorScheme.surface.withValues(alpha: 0.6),
                  ),
                ),
                const SizedBox(width: 4),
                IconButton(
                  tooltip: 'View cart',
                  onPressed: () async {
                    if (user == null) {
                      context.go('/login');
                      return;
                    }
                    try {
                      final shopState = ref.read(selectedShopProvider);
                      ShopEntity? shop = shopState.value;
                      if (shop == null && shopState.isLoading) {
                        shop = await ref.read(selectedShopProvider.future);
                      }
                      if (shop == null) {
                        if (!context.mounted) return;
                        shop = await showShopSelector(context, ref);
                        if (shop == null || !context.mounted) return;
                      }
                      if (context.mounted) context.push('/home/cart');
                    } catch (error, stackTrace) {
                      log(
                        'Could not open cart',
                        name: 'cart',
                        error: error,
                        stackTrace: stackTrace,
                      );
                      if (!context.mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Could not open your cart.'),
                        ),
                      );
                    }
                  },
                  icon: Badge(
                    isLabelVisible: cartCount > 0,
                    label: Text('$cartCount'),
                    child: const Icon(Icons.shopping_bag_outlined),
                  ),
                  style: IconButton.styleFrom(
                    backgroundColor: colorScheme.surface.withValues(alpha: 0.6),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton.icon(
                onPressed: () async {
                  try {
                    await showShopSelector(context, ref);
                  } catch (error, stackTrace) {
                    log(
                      'Could not load available shops',
                      name: 'cart',
                      error: error,
                      stackTrace: stackTrace,
                    );
                    if (!context.mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Could not load available shops.'),
                      ),
                    );
                  }
                },
                icon: const Icon(Icons.storefront_outlined),
                label: Text(selectedShop?.name ?? 'Choose a shop'),
              ),
            ),
            const SizedBox(height: 8),
            Material(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(AppRadii.cardXl),
              child: InkWell(
                borderRadius: BorderRadius.circular(AppRadii.cardXl),
                onTap: user == null ? () => context.go('/login') : null,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.lg,
                    vertical: 11,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.workspace_premium_outlined,
                        color: colorScheme.secondary,
                        size: 20,
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Flexible(
                        child: Text(
                          user == null
                              ? 'Sign in for membership rewards'
                              : '${user!.currentPoints} points · ${user!.member.name} member',
                          style: textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: colorScheme.onSurface,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
