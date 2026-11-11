import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../product/domain/entities/product_entity.dart';
import 'home_product_section.dart';

/// Presentation suggestions, randomly selected rather than purchase history.
class HomeOrderAgainSection extends StatefulWidget {
  const HomeOrderAgainSection({super.key, required this.products});

  final List<ProductEntity> products;

  @override
  State<HomeOrderAgainSection> createState() => _HomeOrderAgainSectionState();
}

class _HomeOrderAgainSectionState extends State<HomeOrderAgainSection> {
  late List<ProductEntity> _products;

  @override
  void initState() {
    super.initState();
    _pickProducts();
  }

  @override
  void didUpdateWidget(HomeOrderAgainSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.products != widget.products) _pickProducts();
  }

  void _pickProducts() {
    const types = {
      'donut',
      'donuts',
      'cookie',
      'cookies',
      'bread',
      'cake',
      'cakes',
      'beverage',
      'beverages',
    };
    final groups = <int, List<ProductEntity>>{};
    final seen = <int>{};
    for (final product in widget.products) {
      if (types.contains(product.productType.name.trim().toLowerCase()) &&
          seen.add(product.id)) {
        groups.putIfAbsent(product.productTypeId, () => []).add(product);
      }
    }
    final pools = groups.values.toList()..shuffle();
    for (final pool in pools) {
      pool.shuffle();
    }
    _products = [];
    // Sample each type in turn so the row includes a mix of treats.
    while (_products.length < 10 && pools.any((pool) => pool.isNotEmpty)) {
      for (final pool in pools) {
        if (pool.isNotEmpty && _products.length < 10) {
          _products.add(pool.removeLast());
        }
      }
    }
    _products.shuffle();
  }

  @override
  Widget build(BuildContext context) {
    if (_products.isEmpty) return const SizedBox.shrink();
    return HomeProductSection(
      title: 'Order again',
      products: _products,
      heroScope: 'home-order-again',
      onViewAll: () => context.push('/home/catalog'),
    );
  }
}
