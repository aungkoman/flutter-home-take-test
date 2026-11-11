import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/cart_item_entity.dart';
import '../repositories/cart_repository.dart';

export '../../../../core/error/failures.dart';
export '../entities/cart_item_entity.dart';

class GetCartItems
    implements UseCase<List<CartItemEntity>, GetCartItemsParams> {
  GetCartItems({required this.repository});

  final CartRepository repository;

  @override
  Future<Either<Failure, List<CartItemEntity>>> call(
    GetCartItemsParams params,
  ) => repository.getItems(userId: params.userId, shopId: params.shopId);
}

class GetCartItemsParams {
  const GetCartItemsParams({required this.userId, required this.shopId});

  final int userId;
  final int shopId;
}
