import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/cart_repository.dart';

export '../../../../core/error/failures.dart';

class SetCartItemQuantityParams {
  const SetCartItemQuantityParams({
    required this.userId,
    required this.shopId,
    required this.cartItemId,
    required this.quantity,
  });

  final int userId;
  final int shopId;
  final int cartItemId;
  final int quantity;
}

class SetCartItemQuantity implements UseCase<Unit, SetCartItemQuantityParams> {
  SetCartItemQuantity({required this.repository});

  final CartRepository repository;

  @override
  Future<Either<Failure, Unit>> call(SetCartItemQuantityParams params) =>
      repository.setQuantity(
        userId: params.userId,
        shopId: params.shopId,
        cartItemId: params.cartItemId,
        quantity: params.quantity,
      );
}
