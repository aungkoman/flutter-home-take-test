import 'dart:developer' show log;

import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entities/product_catalog.dart';
import '../../domain/entities/params/get_product_by_id_params.dart';
import '../../domain/entities/params/get_proudct_params.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_local_datasource.dart';

import '../../domain/entities/product_collection.dart';

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
    return _load<ProductEntity>(
      'getProductById',
      () => localDatasource.getProductById(
        productId: getProductByIdParams.productId,
      ),
    );
  }

  @override
  Future<Either<Failure, ProductCollection>> getCategoryProducts({
    required int categoryId,
  }) => _load<ProductCollection>(
    'getCategoryProducts',
    () => localDatasource.getCategoryProducts(categoryId: categoryId),
  );

  @override
  Future<Either<Failure, ProductCollection>> getProductTypeProducts({
    required int productTypeId,
  }) => _load<ProductCollection>(
    'getProductTypeProducts',
    () => localDatasource.getProductTypeProducts(productTypeId: productTypeId),
  );

  Future<Either<Failure, T>> _load<T>(
    String method,
    Future<T?> Function() request,
  ) async {
    try {
      final T? value = await request();
      return value == null ? Left(NoDataFailure()) : Right(value);
    } catch (error, stackTrace) {
      log(
        'ProductRepositoryImpl.$method failed',
        name: 'product',
        error: error,
        stackTrace: stackTrace,
      );
      return Left(CacheFailure());
    }
  }
}
