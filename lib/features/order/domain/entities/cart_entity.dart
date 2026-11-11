import 'package:hometake/features/auth/domain/entities/user_entity.dart';
import 'package:hometake/features/product/domain/entities/product_entity.dart';
import 'package:hometake/features/product/domain/entities/shop_entity.dart';

class CartEntity {
  int id;
  int userId;
  int shopId;
  int productId;
  UserEntity user;
  ShopEntity shop;
  ProductEntity product;

  CartEntity({
    required this.id,
    required this.userId,
    required this.shopId,
    required this.productId,
    required this.user,
    required this.shop,
    required this.product,
  });
}
