import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/product_catalog.dart';
import '../repositories/product_repository.dart';

export 'package:dartz/dartz.dart' show Either;

export '../../../../core/error/failures.dart' show Failure;
export '../entities/product_catalog.dart';

class GetProductCatalog implements UseCase<ProductCatalog, NoParams> {
  GetProductCatalog({required this.repository});

  final ProductRepository repository;

  @override
  Future<Either<Failure, ProductCatalog>> call(NoParams params) {
    return repository.getCatalog();
  }
}
