import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/cart_repository.dart';

export '../../../../core/error/failures.dart';

class AddCartItemParams {
  const AddCartItemParams({
    required this.userId,
    required this.shopId,
    required this.productId,
    required this.quantity,
  });

  final int userId;
  final int shopId;
  final int productId;
  final int quantity;
}

class AddCartItem implements UseCase<int, AddCartItemParams> {
  AddCartItem({required this.repository});

  final CartRepository repository;

  @override
  Future<Either<Failure, int>> call(AddCartItemParams params) =>
      repository.addItem(
        userId: params.userId,
        shopId: params.shopId,
        productId: params.productId,
        quantity: params.quantity,
      );
}
