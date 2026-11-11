import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../providers/product_detail_provider.dart';
import '../widgets/loading_effects.dart';
import '../widgets/product_hero_tags.dart';

const Color _pageBackground = Color(0xFFF0F1F2);
const Color _accent = Color(0xFF55C9E1);

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

    return Scaffold(
      backgroundColor: _pageBackground,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark.copyWith(
          statusBarColor: Colors.transparent,
        ),
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: 48,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
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

class _ProductDetailContent extends StatefulWidget {
  const _ProductDetailContent({required this.product, this.heroData});

  final ProductEntity product;
  final ProductHeroRouteData? heroData;

  @override
  State<_ProductDetailContent> createState() => _ProductDetailContentState();
}

class _ProductDetailContentState extends State<_ProductDetailContent> {
  int _quantity = 1;

  String _priceLabel(double? value) {
    if (value == null) return 'Price unavailable';
    final double rounded = value;
    final String amount = rounded
        .toStringAsFixed(rounded == rounded.truncateToDouble() ? 0 : 2)
        .replaceAllMapped(
          RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
          (match) => '${match[1]},',
        );
    return '$amount ${widget.product.currency ?? ''}'.trim();
  }

  @override
  Widget build(BuildContext context) {
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
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(17),
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
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Color(0xFF8A96A3),
                                        ),
                                      ),
                                      const SizedBox(height: 4),
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
                                            style: const TextStyle(
                                              fontSize: 27,
                                              height: 1.12,
                                              fontWeight: FontWeight.w800,
                                              color: Color(0xFF222222),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 7),
                                      Text(
                                        _priceLabel(product.price),
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xFF272727),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                if (product.isNew) ...[
                                  const SizedBox(width: 8),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 13,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFFF7B1B),
                                      borderRadius: BorderRadius.circular(9),
                                    ),
                                    child: const Text(
                                      'New',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w700,
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
                                    ? const Icon(
                                        Icons.bakery_dining_outlined,
                                        size: 96,
                                        color: Color(0xFFD4D7D9),
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
                                              ) => const Icon(
                                                Icons.bakery_dining_outlined,
                                                size: 96,
                                                color: Color(0xFFD4D7D9),
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
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF0F1F2),
                            borderRadius: BorderRadius.circular(32),
                            border: Border.all(color: Colors.white, width: 2),
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
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFF333940),
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
                        borderRadius: BorderRadius.circular(8),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.help,
                              size: 16,
                              color: Color(0xFF83C341),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "What's\nthis?",
                              style: TextStyle(
                                fontSize: 14,
                                height: 1.15,
                                fontWeight: FontWeight.w800,
                                color: Color(0xFF3B3D3F),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      width: 1,
                      constraints: const BoxConstraints(minHeight: 86),
                      color: Colors.white,
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Text(
                        description,
                        style: const TextStyle(
                          fontSize: 14,
                          height: 1.55,
                          color: Color(0xFF666B70),
                        ),
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
              onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Cart is not available yet.'),
                  behavior: SnackBarBehavior.floating,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: _accent,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: const StadiumBorder(),
              ),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'ADD TO CART',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        letterSpacing: 0.5,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  Container(width: 1, height: 24, color: Colors.white70),
                  Expanded(
                    child: Text(
                      totalPrice == null
                          ? 'PRICE N/A'
                          : _priceLabel(totalPrice),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        letterSpacing: 0.5,
                        fontWeight: FontWeight.w800,
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
  Widget build(BuildContext context) => IconButton(
    tooltip: tooltip,
    onPressed: onPressed,
    style: IconButton.styleFrom(
      backgroundColor: _accent,
      foregroundColor: Colors.white,
      disabledBackgroundColor: _accent.withValues(alpha: 0.5),
      disabledForegroundColor: Colors.white,
      fixedSize: const Size(34, 34),
      padding: EdgeInsets.zero,
    ),
    icon: Icon(icon, size: 21),
  );
}
