import 'product_entity.dart';

class ProductTypeEntity {
  int id;
  String name;
  String imageUrl;
  int priorityNo;
  List<ProductEntity> products;

  ProductTypeEntity({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.priorityNo,
    List<ProductEntity>? products,
  }) : products = products ?? [];
}
