import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../providers/catalog_provider.dart';

enum ProductCollectionKind { category, productType }

class ProductCollectionPage extends ConsumerStatefulWidget {
  const ProductCollectionPage({
    super.key,
    required this.id,
    required this.kind,
  });

  final String id;
  final ProductCollectionKind kind;

  @override
  ConsumerState<ProductCollectionPage> createState() =>
      _ProductCollectionPageState();
}

class _ProductCollectionPageState extends ConsumerState<ProductCollectionPage> {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';

  @override
  void didUpdateWidget(covariant ProductCollectionPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.id != widget.id || oldWidget.kind != widget.kind) {
      _searchController.clear();
      _query = '';
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _back() {
    if (context.canPop()) {
      context.pop();
    } else {
      context.go('/home');
    }
  }

  String _priceLabel(ProductEntity product) {
    final double? price = product.price;
    if (price == null) return 'Price unavailable';
    final String amount = price
        .toStringAsFixed(price == price.truncateToDouble() ? 0 : 2)
        .replaceAllMapped(
          RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
          (match) => '${match[1]},',
        );
    return '$amount ${product.currency ?? ""}'.trim();
  }

  @override
  Widget build(BuildContext context) {
    final AsyncValue<ProductCatalog> catalog = ref.watch(catalogProvider);
    final String fallbackTitle = widget.kind == ProductCollectionKind.category
        ? 'Category'
        : 'Product type';

    return catalog.when(
      loading: () => Scaffold(
        appBar: AppBar(title: Text(fallbackTitle)),
        body: const Center(child: CircularProgressIndicator()),
      ),
      error: (error, stackTrace) => Scaffold(
        appBar: AppBar(title: Text(fallbackTitle)),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Could not load these products.'),
              TextButton(
                onPressed: () => ref.invalidate(catalogProvider),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
      data: (ProductCatalog data) {
        final int? id = int.tryParse(widget.id);
        final String title;
        final String collectionImage;
        final List<ProductEntity> products;
        if (widget.kind == ProductCollectionKind.category) {
          final CategoryEntity? category = data.categories
              .where((category) => category.id == id)
              .firstOrNull;
          if (category == null) return _notFound(fallbackTitle);
          title = category.name;
          collectionImage = category.imageUrl;
          products = category.name.trim().toLowerCase() == 'all'
              ? data.products
              : category.categoryProducts.map((link) => link.product).toList();
        } else {
          final ProductTypeEntity? type = data.productTypes
              .where((type) => type.id == id)
              .firstOrNull;
          if (type == null) return _notFound(fallbackTitle);
          title = type.name;
          collectionImage = type.imageUrl;
          products = type.products;
        }
        final String image = collectionImage.isNotEmpty
            ? collectionImage
            : (products.firstOrNull?.imageUrl ??
                  'assets/images/home-01-j-donuts-new-logo-1.png');
        final String query = _query.trim().toLowerCase();
        final List<ProductEntity> results = products
            .where(
              (product) =>
                  product.name.toLowerCase().contains(query) ||
                  (product.productCode ?? '').toLowerCase().contains(query),
            )
            .toList();

        return Scaffold(
          backgroundColor: Colors.white,
          body: CustomScrollView(
            key: ValueKey('${widget.kind.name}/${widget.id}'),
            slivers: [
              SliverAppBar(
                pinned: true,
                expandedHeight: 180,
                backgroundColor: const Color(0xFFC7703D),
                foregroundColor: Colors.white,
                leading: IconButton(
                  tooltip: 'Back',
                  onPressed: _back,
                  icon: const Icon(Icons.arrow_back_rounded),
                ),
                flexibleSpace: FlexibleSpaceBar(
                  titlePadding: const EdgeInsets.fromLTRB(24, 0, 20, 18),
                  title: Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                  background: ColoredBox(
                    color: widget.kind == ProductCollectionKind.category
                        ? const Color(0xFFDB8C4B)
                        : const Color(0xFF72BFD2),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: FractionallySizedBox(
                        widthFactor: 0.58,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(12, 32, 20, 20),
                          child: Image.asset(
                            image,
                            fit: BoxFit.contain,
                            excludeFromSemantics: true,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(
                                  Icons.bakery_dining_outlined,
                                  size: 72,
                                  color: Colors.white,
                                ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: ColoredBox(
                  color: const Color(0xFFF0F1F3),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
                    child: TextField(
                      controller: _searchController,
                      onChanged: (String value) =>
                          setState(() => _query = value),
                      textInputAction: TextInputAction.search,
                      decoration: InputDecoration(
                        hintText: 'Search',
                        prefixIcon: const Icon(Icons.search_rounded),
                        suffixIcon: _query.isEmpty
                            ? null
                            : IconButton(
                                tooltip: 'Clear search',
                                onPressed: () {
                                  _searchController.clear();
                                  setState(() => _query = '');
                                },
                                icon: const Icon(Icons.close_rounded),
                              ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 18,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              if (results.isEmpty)
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Text(
                        query.isEmpty
                            ? 'No products yet.'
                            : 'No products match your search.',
                      ),
                    ),
                  ),
                )
              else
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
                  sliver: SliverLayoutBuilder(
                    builder: (context, constraints) {
                      final int columns = (constraints.crossAxisExtent / 170)
                          .floor()
                          .clamp(2, 5);
                      final double width =
                          (constraints.crossAxisExtent - (columns - 1) * 14) /
                          columns;
                      final double imageHeight = width / 1.1;
                      final double nameHeight =
                          MediaQuery.textScalerOf(context).scale(14) * 2.5;
                      final double priceHeight =
                          MediaQuery.textScalerOf(context).scale(14) * 1.4;
                      return SliverGrid(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: columns,
                          crossAxisSpacing: 14,
                          mainAxisSpacing: 24,
                          mainAxisExtent:
                              imageHeight + nameHeight + priceHeight + 18,
                        ),
                        delegate: SliverChildBuilderDelegate((context, index) {
                          final ProductEntity product = results[index];
                          return InkWell(
                            borderRadius: BorderRadius.circular(16),
                            onTap: () =>
                                context.push('/products/${product.id}'),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Container(
                                  height: imageHeight,
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      color: const Color(0xFFDFE2E2),
                                    ),
                                  ),
                                  child: Image.asset(
                                    product.imageUrl,
                                    fit: BoxFit.contain,
                                    excludeFromSemantics: true,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            const Icon(
                                              Icons.bakery_dining_outlined,
                                              size: 48,
                                            ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                  ),
                                  child: SizedBox(
                                    height: nameHeight,
                                    child: Text(
                                      product.name,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        height: 1.25,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                  ),
                                  child: Text(
                                    _priceLabel(product),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      height: 1.4,
                                      color: Color(0xFF454B4F),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }, childCount: results.length),
                      );
                    },
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _notFound(String title) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: const Center(child: Text('Collection not found.')),
    );
  }
}
