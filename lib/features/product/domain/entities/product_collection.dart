import 'product_entity.dart';

/// A category or product type with its products, ready for a listing page.
class ProductCollection {
  const ProductCollection({
    required this.name,
    required this.imageUrl,
    required this.products,
  });
  final String name;
  final String imageUrl;
  final List<ProductEntity> products;
}
