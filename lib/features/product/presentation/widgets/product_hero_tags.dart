import '../../domain/entities/product_entity.dart';

class ProductHeroTags {
  const ProductHeroTags._();

  static String image(int productId, String scope) =>
      'product-image-$scope-$productId';

  static String name(int productId, String scope) =>
      'product-name-$scope-$productId';

  static String collectionImage(String kind, int collectionId) =>
      '$kind-image-$collectionId';

  static String collectionTitle(String kind, int collectionId) =>
      '$kind-title-$collectionId';
}

class ProductHeroRouteData {
  const ProductHeroRouteData({required this.product, required this.scope});

  final ProductEntity product;
  final String scope;
}
