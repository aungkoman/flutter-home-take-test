import 'package:dartz/dartz.dart';
import 'package:hometake/features/order/domain/entities/order_entity.dart';
import 'package:hometake/features/order/domain/entities/order_item_entity.dart';

import '../../../../core/error/failures.dart';


abstract class OrderRepository {
  Future<Either<Failure, List<OrderEntity>>> getItems({
    required int userId,
    required int shopId,
  });
  Future<Either<Failure, int>> createOrder({
    required int userId,
    required int shopId,
    required List<OrderItemEntity> orderItems,
  });
}
