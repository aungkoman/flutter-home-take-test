import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/catalog_provider.dart';

class ProductDetailPage extends ConsumerWidget {
  const ProductDetailPage({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<ProductCatalog> catalog = ref.watch(catalogProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Product details')),
      body: catalog.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Could not load this product.'),
              TextButton(
                onPressed: () => ref.invalidate(catalogProvider),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
        data: (ProductCatalog data) {
          final int? productId = int.tryParse(id);
          final ProductEntity? product = data.products
              .where((product) => product.id == productId)
              .firstOrNull;
          if (product == null) {
            return const Center(child: Text('Product not found.'));
          }
          return Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 520),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (product.imageUrl.isNotEmpty)
                      Image.asset(
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
                    const SizedBox(height: 24),
                    Text(
                      product.name,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 8),
                    Text(product.productCode ?? 'No product code'),
                    const SizedBox(height: 16),
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
                    const SizedBox(height: 16),
                    Text(
                      product.description?.trim().isNotEmpty == true
                          ? product.description!
                          : 'No description available.',
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
