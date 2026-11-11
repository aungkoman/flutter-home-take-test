import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';

abstract class SelectedShopRepository {
  Future<Either<Failure, int?>> getSelectedShopId();
  Future<Either<Failure, Unit>> setSelectedShopId(int shopId);
}
