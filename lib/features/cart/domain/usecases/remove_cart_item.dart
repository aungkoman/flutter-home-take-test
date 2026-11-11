import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/cart_repository.dart';

export '../../../../core/error/failures.dart';

class RemoveCartItemParams {
  const RemoveCartItemParams({
    required this.userId,
    required this.shopId,
    required this.cartItemId,
  });

  final int userId;
  final int shopId;
  final int cartItemId;
}

class RemoveCartItem implements UseCase<Unit, RemoveCartItemParams> {
  RemoveCartItem({required this.repository});

  final CartRepository repository;

  @override
  Future<Either<Failure, Unit>> call(RemoveCartItemParams params) =>
      repository.removeItem(
        userId: params.userId,
        shopId: params.shopId,
        cartItemId: params.cartItemId,
      );
}
