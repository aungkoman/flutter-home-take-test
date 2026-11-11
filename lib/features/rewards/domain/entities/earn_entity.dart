

import '../../../product/domain/entities/product_entity.dart' show ProductEntity;

class EarnEntity {
  int id;
  int productId;
  ProductEntity productEntity;
  int quantity;
  int earnPoints;


  EarnEntity({
    required this.id,
    required this.productId,
    required this.productEntity,
    required this.quantity,
    required this.earnPoints,
  });
}
