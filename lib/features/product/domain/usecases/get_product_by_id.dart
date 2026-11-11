import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/product_entity.dart';
import '../entities/params/get_product_by_id_params.dart';
import '../repositories/product_repository.dart';

export '../../../../core/error/failures.dart';
export '../entities/product_entity.dart';
export '../entities/params/get_product_by_id_params.dart';

class GetProductById implements UseCase<ProductEntity, GetProductByIdParams> {
  GetProductById({required this.repository});
  final ProductRepository repository;

  @override
  Future<Either<Failure, ProductEntity>> call(GetProductByIdParams params) =>
      repository.getProductById(getProductByIdParams: params);
}
