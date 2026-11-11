import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/product_collection.dart';
import '../entities/params/get_category_products_params.dart';
import '../repositories/product_repository.dart';

export '../../../../core/error/failures.dart';
export '../entities/product_collection.dart';
export '../entities/params/get_category_products_params.dart';

class GetCategoryProducts
    implements UseCase<ProductCollection, GetCategoryProductsParams> {
  GetCategoryProducts({required this.repository});
  final ProductRepository repository;

  @override
  Future<Either<Failure, ProductCollection>> call(
    GetCategoryProductsParams params,
  ) => repository.getCategoryProducts(categoryId: params.categoryId);
}
