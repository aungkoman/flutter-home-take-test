import 'package:hometake/features/auth/domain/entities/user_entity.dart';
import 'package:hometake/features/product/domain/entities/product_entity.dart';
import 'package:hometake/features/product/domain/entities/shop_entity.dart';

class OrderItemEntity {
  int id;
  int orderId;
  int quantity;
  int productId;
  ProductEntity product;

  OrderItemEntity({
    required this.id,
    required this.orderId,
    required this.quantity,
    required this.productId,
    required this.product
  });
}
