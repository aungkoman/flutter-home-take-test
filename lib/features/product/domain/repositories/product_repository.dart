import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/params/get_product_by_id_params.dart';
import '../entities/params/get_proudct_params.dart';
import '../entities/product_catalog.dart';

abstract class ProductRepository {
  Future<Either<Failure, ProductCatalog>> getCatalog();

  Future<Either<Failure, List<ProductEntity>>> getProducts({
    required GetProductParams getProductParams,
  });

  Future<Either<Failure, ProductEntity>> getProductById({
    required GetProductByIdParams getProductByIdParams,
  });
}
