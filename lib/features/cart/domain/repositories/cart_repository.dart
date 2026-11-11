import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/cart_item_entity.dart';

abstract class CartRepository {
  Future<Either<Failure, List<CartItemEntity>>> getItems({
    required int userId,
    required int shopId,
  });
  Future<Either<Failure, int>> addItem({
    required int userId,
    required int shopId,
    required int productId,
    required int quantity,
  });
  Future<Either<Failure, Unit>> setQuantity({
    required int userId,
    required int shopId,
    required int cartItemId,
    required int quantity,
  });
  Future<Either<Failure, Unit>> removeItem({
    required int userId,
    required int shopId,
    required int cartItemId,
  });
}
