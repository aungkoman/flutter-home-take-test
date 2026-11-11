import 'dart:developer' show log;

import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../domain/repositories/selected_shop_repository.dart';
import '../datasources/selected_shop_local_datasource.dart';

class SelectedShopRepositoryImpl implements SelectedShopRepository {
  SelectedShopRepositoryImpl({required this.localDatasource});

  final SelectedShopLocalDatasource localDatasource;

  @override
  Future<Either<Failure, int?>> getSelectedShopId() async {
    try {
      return Right(await localDatasource.getSelectedShopId());
    } catch (error, stackTrace) {
      log(
        'SelectedShopRepositoryImpl.getSelectedShopId failed',
        name: 'cart',
        error: error,
        stackTrace: stackTrace,
      );
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> setSelectedShopId(int shopId) async {
    if (shopId < 1) {
      return Left(
        ValidationFailure(
          errors: {
            'shopId': ['Shop id must be valid.'],
          },
        ),
      );
    }
    try {
      await localDatasource.setSelectedShopId(shopId);
      return const Right(unit);
    } catch (error, stackTrace) {
      log(
        'SelectedShopRepositoryImpl.setSelectedShopId failed',
        name: 'cart',
        error: error,
        stackTrace: stackTrace,
      );
      return Left(CacheFailure());
    }
  }
}
