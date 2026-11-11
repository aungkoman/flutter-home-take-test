import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../providers/catalog_provider.dart';

class CatalogPage extends ConsumerWidget {
  const CatalogPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<ProductCatalog> catalog = ref.watch(catalogProvider);

    return DefaultTabController(
      length: 6,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Catalog'),
          actions: [
            IconButton(
              tooltip: 'Refresh',
              onPressed: () => ref.invalidate(catalogProvider),
              icon: const Icon(Icons.refresh),
            ),
          ],
          bottom: const TabBar(
            isScrollable: true,
            tabs: [
              Tab(text: 'Products'),
              Tab(text: 'Banners'),
              Tab(text: 'Shops'),
              Tab(text: 'Types'),
              Tab(text: 'Categories'),
              Tab(text: 'Category links'),
            ],
          ),
        ),
        body: catalog.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) => Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Could not load the catalog.'),
                TextButton(
                  onPressed: () => ref.invalidate(catalogProvider),
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
          data: (ProductCatalog data) => TabBarView(
            children: [
              _CatalogList(
                children: [
                  for (final ProductEntity product in data.products)
                    ListTile(
                      leading: _CatalogImage(path: product.imageUrl),
                      title: Text(product.name),
                      subtitle: Text(
                        '${product.price?.toStringAsFixed(2) ?? "Price unavailable"} '
                        '${product.currency ?? ""} · '
                        '${product.productType.name}\n'
                        '${product.productCode ?? "No product code"} · ID ${product.id}',
                      ),
                      isThreeLine: true,
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => context.push('/products/${product.id}'),
                    ),
                ],
              ),
              _CatalogList(
                children: [
                  for (final BannerEntity banner in data.banners)
                    ListTile(
                      leading: _CatalogImage(path: banner.imageUrl),
                      title: Text(banner.name),
                      subtitle: Text('ID ${banner.id}'),
                    ),
                ],
              ),
              _CatalogList(
                children: [
                  for (final ShopEntity shop in data.shops)
                    ListTile(
                      leading: shop.imageUrl.isEmpty
                          ? const SizedBox(
                              width: 48,
                              height: 48,
                              child: Icon(Icons.storefront_outlined),
                            )
                          : _CatalogImage(path: shop.imageUrl),
                      title: Text(shop.name),
                      subtitle: Text(
                        '${shop.address}\n${shop.lat}, ${shop.lng}',
                      ),
                      isThreeLine: true,
                    ),
                ],
              ),
              _CatalogList(
                children: [
                  for (final ProductTypeEntity type in data.productTypes)
                    ListTile(
                      leading: _CatalogImage(path: type.imageUrl),
                      title: Text(type.name),
                      subtitle: Text(
                        '${type.products.length} products · Priority ${type.priorityNo}',
                      ),
                    ),
                ],
              ),
              _CatalogList(
                children: [
                  for (final CategoryEntity category in data.categories)
                    ListTile(
                      leading: _CatalogImage(path: category.imageUrl),
                      title: Text(category.name),
                      subtitle: Text(
                        '${category.categoryProducts.length} products · '
                        '${category.isActive ? "Active" : "Inactive"}',
                      ),
                    ),
                ],
              ),
              _CatalogList(
                children: [
                  for (final CategoryProductEntity link
                      in data.categoryProducts)
                    ListTile(
                      title: Text(
                        '${link.category.name} → ${link.product.name}',
                      ),
                      subtitle: Text(
                        'ID ${link.id} · Category ${link.categoryId} · '
                        'Product ${link.productId}',
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CatalogList extends StatelessWidget {
  const _CatalogList({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    if (children.isEmpty) {
      return const Center(child: Text('No items yet.'));
    }
    return ListView(children: children);
  }
}

class _CatalogImage extends StatelessWidget {
  const _CatalogImage({required this.path});

  final String path;

  @override
  Widget build(BuildContext context) {
    if (path.isEmpty) {
      return const SizedBox(
        width: 48,
        height: 48,
        child: Icon(Icons.image_outlined),
      );
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.asset(
        path,
        width: 48,
        height: 48,
        fit: BoxFit.cover,
        excludeFromSemantics: true,
        errorBuilder: (context, error, stackTrace) => const SizedBox(
          width: 48,
          height: 48,
          child: Icon(Icons.broken_image_outlined),
        ),
      ),
    );
  }
}
