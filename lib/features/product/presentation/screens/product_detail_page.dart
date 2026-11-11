import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/product_detail_provider.dart';
import '../widgets/loading_effects.dart';
import '../widgets/product_hero_tags.dart';

class ProductDetailPage extends ConsumerWidget {
  const ProductDetailPage({super.key, required this.id, this.initialProduct});

  final String id;
  final ProductEntity? initialProduct;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int productId = int.tryParse(id) ?? -1;
    final AsyncValue<ProductEntity> productState = ref.watch(
      productDetailProvider(productId),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Product details')),
      body: productState.when(
        loading: () => ProductDetailSkeleton(
          productId: initialProduct?.id,
          productName: initialProduct?.name,
          imageUrl: initialProduct?.imageUrl,
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
        data: (ProductEntity product) {
          return Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 520),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (product.imageUrl.isNotEmpty)
                      Hero(
                        tag: ProductHeroTags.image(product.id),
                        child: Image.asset(
                          product.imageUrl,
                          height: 240,
                          fit: BoxFit.contain,
                          semanticLabel: product.name,
                          errorBuilder: (context, error, stackTrace) =>
                              const SizedBox(
                                height: 240,
                                child: Icon(
                                  Icons.broken_image_outlined,
                                  size: 64,
                                ),
                              ),
                        ),
                      ),
                    const SizedBox(height: 24),
                    Hero(
                      tag: ProductHeroTags.name(product.id),
                      child: Material(
                        color: Colors.transparent,
                        child: Text(
                          product.name,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(product.productCode ?? 'No product code'),
                    const SizedBox(height: 24),
                    StaggeredEntrance(
                      index: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${product.price?.toStringAsFixed(2) ?? "Price unavailable"} '
                            '${product.currency ?? ""}',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 16),
                          Text('Type: ${product.productType.name}'),
                          if (product.categoryProducts.isNotEmpty)
                            Text(
                              'Categories: ${product.categoryProducts.map((link) => link.category.name).join(", ")}',
                            ),
                          if (product.isNew)
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Chip(label: Text('New')),
                            ),
                          if ((product.discountPercentage ?? 0) > 0)
                            Text('Discount: ${product.discountPercentage}%'),
                          if ((product.discountAmount ?? 0) > 0)
                            Text('Discount amount: ${product.discountAmount}'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    StaggeredEntrance(
                      index: 2,
                      child: Text(
                        product.description?.trim().isNotEmpty == true
                            ? product.description!
                            : 'No description available.',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
