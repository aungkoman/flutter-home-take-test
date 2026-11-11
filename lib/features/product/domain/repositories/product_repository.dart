import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/params/get_product_by_id_params.dart';
import '../entities/params/get_proudct_params.dart';
import '../entities/product_catalog.dart';

import '../entities/product_collection.dart';

abstract class ProductRepository {
  Future<Either<Failure, ProductCollection>> getCategoryProducts({
    required int categoryId,
  });
  Future<Either<Failure, ProductCollection>> getProductTypeProducts({
    required int productTypeId,
  });
  Future<Either<Failure, ProductCatalog>> getCatalog();

  Future<Either<Failure, List<ProductEntity>>> getProducts({
    required GetProductParams getProductParams,
  });

  Future<Either<Failure, ProductEntity>> getProductById({
    required GetProductByIdParams getProductByIdParams,
  });
}
