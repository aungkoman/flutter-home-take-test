import 'category_product_entity.dart';
import 'product_type_entity.dart';

class ProductEntity {
  int id;
  String name;
  String imageUrl;
  int priorityNo;
  double? price;
  String? currency;
  String? productCode;
  String? description;
  bool isNew;
  double? discountPercentage;
  double? discountAmount;
  int productTypeId;
  ProductTypeEntity productType;
  List<CategoryProductEntity> categoryProducts;

  ProductEntity({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.priorityNo,
    required this.price,
    required this.currency,
    required this.productCode,
    required this.description,
    required this.isNew,
    required this.discountPercentage,
    required this.discountAmount,
    required this.productTypeId,
    required this.productType,
    List<CategoryProductEntity>? categoryProducts,
  }) : categoryProducts = categoryProducts ?? [];
}
