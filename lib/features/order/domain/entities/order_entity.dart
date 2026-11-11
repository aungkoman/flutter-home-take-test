import 'package:hometake/features/auth/domain/entities/user_entity.dart';
import 'package:hometake/features/order/domain/entities/order_item_entity.dart';
import 'package:hometake/features/product/domain/entities/product_entity.dart';
import 'package:hometake/features/product/domain/entities/shop_entity.dart';

class OrderEntity {
  int id;
  int userId;
  int shopId;
  String status; // pending, delivered, cancelled
  UserEntity user;
  ShopEntity shop;
  List<OrderItemEntity> orderItems;

  OrderEntity({
    required this.id,
    required this.userId,
    required this.shopId,
    required this.user,
    required this.shop,
    required this.status,
    required this.orderItems,
  });
}
