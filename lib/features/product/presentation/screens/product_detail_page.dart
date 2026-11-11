import '../../../../core/utils/price_formatter.dart';

import 'dart:developer' show log;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../auth/presentation/providers/current_user_provider.dart';
import '../../../cart/presentation/providers/cart_provider.dart';
import '../../../cart/presentation/providers/selected_shop_provider.dart';
import '../../../cart/presentation/widgets/shop_selector_dialog.dart';
import '../providers/product_detail_provider.dart';
import '../widgets/loading_effects.dart';
import '../widgets/product_hero_tags.dart';

class ProductDetailPage extends ConsumerWidget {
  const ProductDetailPage({super.key, required this.id, this.heroData});

  final String id;
  final ProductHeroRouteData? heroData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int productId = int.tryParse(id) ?? -1;
    final AsyncValue<ProductEntity> productState = ref.watch(
      productDetailProvider(productId),
    );
    final int cartCount =
        ref
            .watch(cartProvider)
            .value
            ?.fold<int>(0, (total, item) => total + item.quantity) ??
        0;

    return Scaffold(
      backgroundColor: context.appColors.pageBackground,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark.copyWith(
          statusBarColor: Colors.transparent,
        ),
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: 48,
                child: Row(
                  children: [
                    IconButton(
                      tooltip: 'Back',
                      onPressed: () {
                        if (context.canPop()) {
                          context.pop();
                        } else {
                          context.go('/home');
                        }
                      },
                      icon: const Icon(Icons.arrow_back_rounded),
                    ),
                    const Spacer(),
                    IconButton(
                      tooltip: 'View cart',
                      onPressed: () async {
                        if (ref.read(currentUserProvider) == null) {
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
                          if (context.mounted) {
                            ScaffoldMessenger.of(context)
                                .removeCurrentSnackBar();
                            context.push('/home/cart');
                          }
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
                    ),
                    const SizedBox(width: AppSpacing.sm),
                  ],
                ),
              ),
              Expanded(
                child: productState.when(
                  loading: () => ProductDetailSkeleton(
                    productId: heroData?.product.id,
                    productName: heroData?.product.name,
                    imageUrl: heroData?.product.imageUrl,
                    heroScope: heroData?.scope,
                  ),
                  error: (error, stackTrace) => Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          error is NoDataFailure
                              ? 'Product not found.'
                              : 'Could not load this product.',
                        ),
                        TextButton(
                          onPressed: () =>
                              ref.invalidate(productDetailProvider(productId)),
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  ),
                  data: (ProductEntity product) => _ProductDetailContent(
                    product: product,
                    heroData: heroData,
                    onAddToCart: (int quantity) async {
                      final user = ref.read(currentUserProvider);
                      if (user == null) {
                        context.go('/login');
                        return _AddToCartStatus.signInRequired;
                      }
                      try {
                        final shopState = ref.read(selectedShopProvider);
                        ShopEntity? shop = shopState.value;
                        if (shop == null && shopState.isLoading) {
                          shop = await ref.read(selectedShopProvider.future);
                        }
                        if (shop == null) {
                          if (!context.mounted) {
                            return _AddToCartStatus.failed;
                          }
                          shop ??= await showShopSelector(context, ref);
                        }
                        if (shop == null) {
                          return _AddToCartStatus.shopRequired;
                        }
                        final result = await ref
                            .read(cartProvider.notifier)
                            .addProduct(product, quantity, user, shop);
                        return result.isRight()
                            ? _AddToCartStatus.added
                            : _AddToCartStatus.failed;
                      } catch (error, stackTrace) {
                        log(
                          'Could not add product to cart',
                          name: 'cart',
                          error: error,
                          stackTrace: stackTrace,
                        );
                        return _AddToCartStatus.failed;
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum _AddToCartStatus { added, signInRequired, shopRequired, failed }

class _ProductDetailContent extends StatefulWidget {
  const _ProductDetailContent({
    required this.product,
    required this.onAddToCart,
    this.heroData,
  });

  final ProductEntity product;
  final ProductHeroRouteData? heroData;
  final Future<_AddToCartStatus> Function(int quantity) onAddToCart;

  @override
  State<_ProductDetailContent> createState() => _ProductDetailContentState();
}

class _ProductDetailContentState extends State<_ProductDetailContent> {
  int _quantity = 1;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = context.colorScheme;
    final AppColors appColors = context.appColors;
    final TextTheme textTheme = context.textTheme;
    final ProductEntity product = widget.product;
    final double cardHeight = (MediaQuery.sizeOf(context).height * 0.47)
        .clamp(340.0, 440.0)
        .toDouble();
    final String description = product.description?.trim().isNotEmpty == true
        ? product.description!.trim()
        : 'A delicious treat, freshly made to brighten your day.';
    final String heroScope = widget.heroData?.scope ?? 'unmatched';
    final double? totalPrice = product.price == null
        ? null
        : product.price! * _quantity;

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 30, 20, 16),
            child: Column(
              children: [
                SizedBox(
                  height: cardHeight + 30,
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.topCenter,
                    children: [
                      Container(
                        height: cardHeight,
                        padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
                        decoration: BoxDecoration(
                          color: colorScheme.surface,
                          borderRadius: BorderRadius.circular(
                            AppRadii.detailCard,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        product.productCode ?? '',
                                        style: textTheme.labelMedium?.copyWith(
                                          color: appColors.textMuted,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      const SizedBox(height: AppSpacing.xs),
                                      _productHero(
                                        ProductHeroTags.name(
                                          product.id,
                                          heroScope,
                                        ),
                                        Material(
                                          color: Colors.transparent,
                                          child: Text(
                                            product.name,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: textTheme.headlineMedium
                                                ?.copyWith(
                                                  fontSize: 27,
                                                  height: 1.12,
                                                ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 7),
                                      Text(
                                        formatMmk(product.price),
                                        style: textTheme.titleSmall,
                                      ),
                                    ],
                                  ),
                                ),
                                if (product.isNew) ...[
                                  const SizedBox(width: AppSpacing.sm),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 13,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: appColors.orangeBadge,
                                      borderRadius: BorderRadius.circular(9),
                                    ),
                                    key: const ValueKey('product-new-badge'),
                                    child: Text(
                                      'NEW',
                                      style: textTheme.labelMedium?.copyWith(
                                        fontSize: 13,
                                        color: colorScheme.onTertiary,
                                      ),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                            const SizedBox(height: 10),
                            Expanded(
                              child: Center(
                                child: product.imageUrl.isEmpty
                                    ? Icon(
                                        Icons.bakery_dining_outlined,
                                        size: 96,
                                        color: appColors.divider,
                                      )
                                    : _productHero(
                                        ProductHeroTags.image(
                                          product.id,
                                          heroScope,
                                        ),
                                        Image.asset(
                                          product.imageUrl,
                                          fit: BoxFit.contain,
                                          semanticLabel: product.name,
                                          errorBuilder:
                                              (
                                                context,
                                                error,
                                                stackTrace,
                                              ) => Icon(
                                                Icons.bakery_dining_outlined,
                                                size: 96,
                                                color: appColors.divider,
                                              ),
                                        ),
                                      ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        child: Container(
                          height: 60,
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.md,
                          ),
                          decoration: BoxDecoration(
                            color: appColors.pageBackground,
                            borderRadius: BorderRadius.circular(32),
                            border: Border.all(
                              color: colorScheme.surface,
                              width: 2,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              _QuantityButton(
                                icon: Icons.remove,
                                tooltip: 'Decrease quantity',
                                onPressed: _quantity > 1
                                    ? () => setState(() => _quantity--)
                                    : null,
                              ),
                              SizedBox(
                                width: 54,
                                child: AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 150),
                                  child: Text(
                                    '$_quantity',
                                    key: ValueKey(_quantity),
                                    textAlign: TextAlign.center,
                                    style: textTheme.headlineMedium?.copyWith(
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                              _QuantityButton(
                                icon: Icons.add,
                                tooltip: 'Increase quantity',
                                onPressed: () => setState(() => _quantity++),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 28),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 66,
                      child: InkWell(
                        onTap: () => showDialog<void>(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text(product.name),
                            content: Text(description),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Close'),
                              ),
                            ],
                          ),
                        ),
                        borderRadius: BorderRadius.circular(AppRadii.sm),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.help,
                              size: 16,
                              color: appColors.infoGreen,
                            ),
                            const SizedBox(height: AppSpacing.xs),
                            Text(
                              "What's\nthis?",
                              style: textTheme.titleSmall?.copyWith(
                                height: 1.15,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Container(
                      width: 1,
                      constraints: const BoxConstraints(minHeight: 86),
                      color: colorScheme.surface,
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Text(
                        description,
                        style: textTheme.bodyMedium?.copyWith(height: 1.55),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
          child: SizedBox(
            height: 56,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                final _AddToCartStatus status = await widget.onAddToCart(
                  _quantity,
                );
                if (!context.mounted) return;
                if (status == _AddToCartStatus.signInRequired) return;
                final bool added = status == _AddToCartStatus.added;
                final messenger = ScaffoldMessenger.of(context);
                messenger.removeCurrentSnackBar();
                messenger.showSnackBar(
                  SnackBar(
                    duration: const Duration(seconds: 5),
                    persist: false,
                    content: Text(
                      added
                          ? '${product.name} added to cart.'
                          : status == _AddToCartStatus.shopRequired
                          ? 'Choose a shop before adding items.'
                          : 'Could not add this item. Please try again.',
                    ),
                    action: added
                        ? SnackBarAction(
                            label: 'VIEW CART',
                            onPressed: () {
                              messenger.removeCurrentSnackBar();
                              context.push('/home/cart');
                            },
                          )
                        : null,
                  ),
                );
              },
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'ADD TO CART',
                      textAlign: TextAlign.center,
                      style: textTheme.labelLarge?.copyWith(
                        fontSize: 14,
                        letterSpacing: 0.5,
                        color: colorScheme.onPrimary,
                      ),
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 24,
                    color: colorScheme.onPrimary.withValues(alpha: 0.7),
                  ),
                  Expanded(
                    child: Text(
                      totalPrice == null ? 'PRICE N/A' : formatMmk(totalPrice),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.labelLarge?.copyWith(
                        fontSize: 14,
                        letterSpacing: 0.5,
                        color: colorScheme.onPrimary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _productHero(String tag, Widget child) {
    if (widget.heroData == null) return child;
    return Hero(tag: tag, child: child);
  }
}

class _QuantityButton extends StatelessWidget {
  const _QuantityButton({
    required this.icon,
    required this.tooltip,
    required this.onPressed,
  });

  final IconData icon;
  final String tooltip;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = context.colorScheme;
    return IconButton(
      tooltip: tooltip,
      onPressed: onPressed,
      style: IconButton.styleFrom(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        disabledBackgroundColor: colorScheme.primary.withValues(alpha: 0.5),
        disabledForegroundColor: colorScheme.onPrimary,
        fixedSize: const Size(34, 34),
        padding: EdgeInsets.zero,
      ),
      icon: Icon(icon, size: 21),
    );
  }
}
