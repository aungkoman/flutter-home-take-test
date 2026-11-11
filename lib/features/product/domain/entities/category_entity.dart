import 'category_product_entity.dart';

class CategoryEntity {
  int id;
  String name;
  String imageUrl;
  int priorityNo;
  bool isActive;
  List<CategoryProductEntity> categoryProducts;

  CategoryEntity({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.priorityNo,
    required this.isActive,
    List<CategoryProductEntity>? categoryProducts,
  }) : categoryProducts = categoryProducts ?? [];
}
