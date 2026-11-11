import 'dart:developer' show log;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../auth/presentation/providers/current_user_provider.dart';
import '../../../product/presentation/widgets/loading_effects.dart';
import '../providers/cart_provider.dart';
import '../providers/selected_shop_provider.dart';
import '../widgets/shop_selector_dialog.dart';

class CartPage extends ConsumerWidget {
  const CartPage({super.key});

  String _priceLabel(double? value, String? currency) {
    if (value == null) return 'Price unavailable';
    final String amount = value
        .toStringAsFixed(value == value.truncateToDouble() ? 0 : 2)
        .replaceAllMapped(
          RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
          (match) => '${match[1]},',
        );
    return '$amount ${currency ?? ''}'.trim();
  }

  void _showFailure(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Could not update your cart. Try again.')),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ColorScheme colorScheme = context.colorScheme;
    final AppColors appColors = context.appColors;
    final TextTheme textTheme = context.textTheme;
    final AsyncValue<List<CartItemEntity>> cart = ref.watch(cartProvider);
    final UserEntity? user = ref.watch(currentUserProvider);
    final AsyncValue<ShopEntity?> selectedShop = ref.watch(
      selectedShopProvider,
    );
    return Scaffold(
      backgroundColor: appColors.pageBackground,
      appBar: AppBar(
        title: const Text('Your cart'),
        backgroundColor: appColors.pageBackground,
      ),
      body: user == null
          ? Center(
              child: FilledButton(
                onPressed: () => context.go('/login'),
                child: const Text('Sign in to view your cart'),
              ),
            )
          : selectedShop.when(
              loading: () => const _CartSkeleton(),
              error: (error, stackTrace) => Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Could not load the selected shop.'),
                    TextButton(
                      onPressed: () => ref.invalidate(selectedShopProvider),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
              data: (shop) => shop == null
                  ? Center(
                      child: FilledButton(
                        onPressed: () async {
                          try {
                            await showShopSelector(context, ref);
                          } catch (error, stackTrace) {
                            log(
                              'Could not open shop selector',
                              name: 'cart',
                              error: error,
                              stackTrace: stackTrace,
                            );
                            if (!context.mounted) return;
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Could not load available shops.',
                                ),
                              ),
                            );
                          }
                        },
                        child: const Text('Choose a shop'),
                      ),
                    )
                  : cart.when(
                      loading: () => const _CartSkeleton(),
                      error: (error, stackTrace) => Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text('Could not load your cart.'),
                            TextButton(
                              onPressed: () => ref.invalidate(cartProvider),
                              child: const Text('Retry'),
                            ),
                          ],
                        ),
                      ),
                      data: (List<CartItemEntity> items) {
                        if (items.isEmpty) {
                          return Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.shopping_bag_outlined,
                                  size: 72,
                                  color: appColors.textMuted,
                                ),
                                const SizedBox(height: AppSpacing.md),
                                Text(
                                  'Your cart is empty',
                                  style: textTheme.titleLarge,
                                ),
                                const SizedBox(height: AppSpacing.sm),
                                const Text(
                                  'Add a treat and it will appear here.',
                                ),
                                const SizedBox(height: 18),
                                FilledButton(
                                  onPressed: () {
                                    if (context.canPop()) {
                                      context.pop();
                                    } else {
                                      context.go('/home');
                                    }
                                  },
                                  child: const Text('Browse treats'),
                                ),
                              ],
                            ),
                          );
                        }

                        final double total = items.fold(
                          0,
                          (sum, item) => sum + (item.subtotal ?? 0),
                        );
                        final String currency =
                            items
                                .map((item) => item.product.currency)
                                .whereType<String>()
                                .firstOrNull ??
                            '';

                        return Column(
                          children: [
                            Expanded(
                              child: RefreshIndicator(
                                onRefresh: () async {
                                  ref.invalidate(cartProvider);
                                  await ref.read(cartProvider.future);
                                },
                                child: ListView.builder(
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  padding: const EdgeInsets.fromLTRB(
                                    20,
                                    8,
                                    20,
                                    24,
                                  ),
                                  itemCount: items.length,
                                  itemBuilder: (context, index) {
                                    final CartItemEntity item = items[index];
                                    return Container(
                                      margin: const EdgeInsets.only(bottom: 14),
                                      padding: const EdgeInsets.all(14),
                                      decoration: BoxDecoration(
                                        color: colorScheme.surface,
                                        borderRadius: BorderRadius.circular(
                                          AppRadii.cardLg,
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                              AppRadii.input,
                                            ),
                                            child: Container(
                                              width: 84,
                                              height: 84,
                                              color: appColors.surfaceMuted,
                                              padding: const EdgeInsets.all(
                                                AppSpacing.sm,
                                              ),
                                              child: Image.asset(
                                                item.product.imageUrl,
                                                fit: BoxFit.contain,
                                                errorBuilder:
                                                    (
                                                      context,
                                                      error,
                                                      stackTrace,
                                                    ) => const Icon(
                                                      Icons
                                                          .bakery_dining_outlined,
                                                      size: 36,
                                                    ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 14),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  item.product.name,
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: textTheme.titleMedium,
                                                ),
                                                const SizedBox(height: 6),
                                                Text(
                                                  _priceLabel(
                                                    item.product.price,
                                                    item.product.currency,
                                                  ),
                                                  style: textTheme.bodyMedium,
                                                ),
                                                const SizedBox(height: 10),
                                                Row(
                                                  children: [
                                                    _QuantityControl(
                                                      icon: Icons.remove,
                                                      tooltip:
                                                          'Decrease quantity',
                                                      onPressed: () async {
                                                        final result =
                                                            item.quantity == 1
                                                            ? await ref
                                                                  .read(
                                                                    cartProvider
                                                                        .notifier,
                                                                  )
                                                                  .remove(
                                                                    item.id,
                                                                  )
                                                            : await ref
                                                                  .read(
                                                                    cartProvider
                                                                        .notifier,
                                                                  )
                                                                  .setQuantity(
                                                                    item.id,
                                                                    item.quantity -
                                                                        1,
                                                                  );
                                                        if (result.isLeft() &&
                                                            context.mounted) {
                                                          _showFailure(context);
                                                        }
                                                      },
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.symmetric(
                                                            horizontal:
                                                                AppSpacing.md,
                                                          ),
                                                      child: Text(
                                                        '${item.quantity}',
                                                        style: textTheme
                                                            .titleMedium,
                                                      ),
                                                    ),
                                                    _QuantityControl(
                                                      icon: Icons.add,
                                                      tooltip:
                                                          'Increase quantity',
                                                      onPressed: () async {
                                                        final result = await ref
                                                            .read(
                                                              cartProvider
                                                                  .notifier,
                                                            )
                                                            .setQuantity(
                                                              item.id,
                                                              item.quantity + 1,
                                                            );
                                                        if (result.isLeft() &&
                                                            context.mounted) {
                                                          _showFailure(context);
                                                        }
                                                      },
                                                    ),
                                                    const Spacer(),
                                                    IconButton(
                                                      tooltip: 'Remove item',
                                                      onPressed: () async {
                                                        final result = await ref
                                                            .read(
                                                              cartProvider
                                                                  .notifier,
                                                            )
                                                            .remove(item.id);
                                                        if (result.isLeft() &&
                                                            context.mounted) {
                                                          _showFailure(context);
                                                        }
                                                      },
                                                      icon: const Icon(
                                                        Icons
                                                            .delete_outline_rounded,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.fromLTRB(
                                20,
                                16,
                                20,
                                18,
                              ),
                              decoration: BoxDecoration(
                                color: colorScheme.surface,
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(AppRadii.cardXl),
                                ),
                              ),
                              child: SafeArea(
                                top: false,
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Total (${items.fold<int>(0, (sum, item) => sum + item.quantity)} items)',
                                          style: textTheme.titleMedium
                                              ?.copyWith(
                                                fontWeight: FontWeight.w600,
                                              ),
                                        ),
                                        Text(
                                          _priceLabel(total, currency),
                                          style: textTheme.titleLarge?.copyWith(
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 14),
                                    SizedBox(
                                      height: 52,
                                      width: double.infinity,
                                      child: FilledButton(
                                        onPressed: () =>
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                                  const SnackBar(
                                                    content: Text(
                                                      'Checkout is not available yet.',
                                                    ),
                                                  ),
                                                ),
                                        child: Text(
                                          'CONTINUE',
                                          style: textTheme.labelLarge?.copyWith(
                                            color: colorScheme.onPrimary,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
            ),
    );
  }
}

class _QuantityControl extends StatelessWidget {
  const _QuantityControl({
    required this.icon,
    required this.tooltip,
    required this.onPressed,
  });

  final IconData icon;
  final String tooltip;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = context.colorScheme;
    final AppColors appColors = context.appColors;
    return SizedBox(
      width: 30,
      height: 30,
      child: IconButton(
        tooltip: tooltip,
        onPressed: onPressed,
        padding: EdgeInsets.zero,
        style: IconButton.styleFrom(
          backgroundColor: appColors.cyanSoft,
          foregroundColor: colorScheme.primary,
        ),
        icon: Icon(icon, size: 18),
      ),
    );
  }
}

class _CartSkeleton extends StatelessWidget {
  const _CartSkeleton();

  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.all(20),
    children: [
      for (int index = 0; index < 3; index++)
        Container(
          margin: const EdgeInsets.only(bottom: 14),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: context.colorScheme.surface,
            borderRadius: BorderRadius.circular(AppRadii.cardLg),
          ),
          child: const Row(
            children: [
              SkeletonBlock(
                width: 84,
                height: 84,
                borderRadius: AppRadii.input,
              ),
              SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SkeletonBlock(width: 170, height: 17),
                    SizedBox(height: 9),
                    SkeletonBlock(width: 100, height: 15),
                    SizedBox(height: 12),
                    SkeletonBlock(width: 118, height: 30, borderRadius: 18),
                  ],
                ),
              ),
            ],
          ),
        ),
    ],
  );
}
