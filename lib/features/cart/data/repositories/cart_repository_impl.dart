import 'dart:developer' show log;

import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entities/cart_item_entity.dart';
import '../../domain/repositories/cart_repository.dart';
import '../datasources/cart_local_datasource.dart';

class CartRepositoryImpl implements CartRepository {
  CartRepositoryImpl({required this.localDatasource});

  final CartLocalDatasource localDatasource;

  @override
  Future<Either<Failure, List<CartItemEntity>>> getItems({
    required int userId,
    required int shopId,
  }) async {
    try {
      return Right(
        await localDatasource.getItems(userId: userId, shopId: shopId),
      );
    } catch (error, stackTrace) {
      log(
        'CartRepositoryImpl.getItems failed',
        name: 'cart',
        error: error,
        stackTrace: stackTrace,
      );
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, int>> addItem({
    required int userId,
    required int shopId,
    required int productId,
    required int quantity,
  }) async {
    if (userId < 1 || shopId < 1 || productId < 1 || quantity < 1) {
      return Left(
        ValidationFailure(
          errors: {
            'cartItem': ['User, shop, product, and quantity must be valid.'],
          },
        ),
      );
    }
    return _writeValue(
      'addItem',
      () => localDatasource.addItem(
        userId: userId,
        shopId: shopId,
        productId: productId,
        quantity: quantity,
      ),
    );
  }

  @override
  Future<Either<Failure, Unit>> setQuantity({
    required int userId,
    required int shopId,
    required int cartItemId,
    required int quantity,
  }) {
    if (userId < 1 || shopId < 1 || cartItemId < 1 || quantity < 1) {
      return Future.value(
        Left(
          ValidationFailure(
            errors: {
              'quantity': ['Quantity must be at least one.'],
            },
          ),
        ),
      );
    }
    return _write(
      'setQuantity',
      () => localDatasource.setQuantity(
        userId: userId,
        shopId: shopId,
        cartItemId: cartItemId,
        quantity: quantity,
      ),
    );
  }

  @override
  Future<Either<Failure, Unit>> removeItem({
    required int userId,
    required int shopId,
    required int cartItemId,
  }) {
    if (userId < 1 || shopId < 1 || cartItemId < 1) {
      return Future.value(
        Left(
          ValidationFailure(
            errors: {
              'cartItemId': ['Cart item id must be valid.'],
            },
          ),
        ),
      );
    }
    return _write(
      'removeItem',
      () => localDatasource.removeItem(
        userId: userId,
        shopId: shopId,
        cartItemId: cartItemId,
      ),
    );
  }

  Future<Either<Failure, int>> _writeValue(
    String method,
    Future<int> Function() operation,
  ) async {
    try {
      return Right(await operation());
    } catch (error, stackTrace) {
      log(
        'CartRepositoryImpl.$method failed',
        name: 'cart',
        error: error,
        stackTrace: stackTrace,
      );
      return Left(CacheFailure());
    }
  }

  Future<Either<Failure, Unit>> _write(
    String method,
    Future<void> Function() operation,
  ) async {
    try {
      await operation();
      return const Right(unit);
    } catch (error, stackTrace) {
      log(
        'CartRepositoryImpl.$method failed',
        name: 'cart',
        error: error,
        stackTrace: stackTrace,
      );
      return Left(CacheFailure());
    }
  }
}
