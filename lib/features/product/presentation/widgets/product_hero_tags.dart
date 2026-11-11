class ProductHeroTags {
  const ProductHeroTags._();

  static String image(int productId) => 'product-image-$productId';

  static String name(int productId) => 'product-name-$productId';

  static String collectionImage(String kind, int collectionId) =>
      '$kind-image-$collectionId';

  static String collectionTitle(String kind, int collectionId) =>
      '$kind-title-$collectionId';
}
