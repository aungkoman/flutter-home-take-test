import 'banner_entity.dart';
import 'category_entity.dart';
import 'category_product_entity.dart';
import 'product_entity.dart';
import 'product_type_entity.dart';
import 'shop_entity.dart';

export 'banner_entity.dart';
export 'category_entity.dart';
export 'category_product_entity.dart';
export 'product_entity.dart';
export 'product_type_entity.dart';
export 'shop_entity.dart';

class ProductCatalog {
  final List<ProductEntity> products;
  final List<BannerEntity> banners;
  final List<ShopEntity> shops;
  final List<ProductTypeEntity> productTypes;
  final List<CategoryEntity> categories;
  final List<CategoryProductEntity> categoryProducts;

  ProductCatalog({
    required this.products,
    required this.banners,
    required this.shops,
    required this.productTypes,
    required this.categories,
    required this.categoryProducts,
  });
}
