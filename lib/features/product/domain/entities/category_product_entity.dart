import 'category_entity.dart';
import 'product_entity.dart';

class CategoryProductEntity {
  int id;
  int categoryId;
  int productId;
  CategoryEntity category;
  ProductEntity product;

  CategoryProductEntity({
    required this.id,
    required this.categoryId,
    required this.productId,
    required this.category,
    required this.product,
  });
}
