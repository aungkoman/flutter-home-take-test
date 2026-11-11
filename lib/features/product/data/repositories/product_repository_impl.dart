import 'dart:developer' show log;

import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entities/product_catalog.dart';
import '../../domain/entities/params/get_product_by_id_params.dart';
import '../../domain/entities/params/get_proudct_params.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_local_datasource.dart';

class ProductRepositoryImpl implements ProductRepository {
  ProductRepositoryImpl({required this.localDatasource});

  final ProductLocalDatasource localDatasource;

  @override
  Future<Either<Failure, ProductCatalog>> getCatalog() async {
    try {
      return Right(await localDatasource.getCatalog());
    } catch (error, stackTrace) {
      log(
        'ProductRepositoryImpl.getCatalog failed',
        name: 'product.catalog',
        error: error,
        stackTrace: stackTrace,
      );
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getProducts({
    required GetProductParams getProductParams,
  }) async {
    if (getProductParams.page < 1) {
      return Left(
        ValidationFailure(
          errors: {
            'page': ['Page must be at least 1.'],
          },
        ),
      );
    }
    const int pageSize = 20;
    final Either<Failure, ProductCatalog> result = await getCatalog();
    return result.map(
      (catalog) => catalog.products
          .skip((getProductParams.page - 1) * pageSize)
          .take(pageSize)
          .toList(),
    );
  }

  @override
  Future<Either<Failure, ProductEntity>> getProductById({
    required GetProductByIdParams getProductByIdParams,
  }) async {
    final Either<Failure, ProductCatalog> result = await getCatalog();
    return result.fold((failure) => Left(failure), (catalog) {
      for (final ProductEntity product in catalog.products) {
        if (product.id == getProductByIdParams.productId) {
          return Right(product);
        }
      }
      return Left(NoDataFailure());
    });
  }
}
