import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/selected_shop_repository.dart';

export '../../../../core/error/failures.dart';

class SetSelectedShopId implements UseCase<Unit, SetSelectedShopIdParams> {
  SetSelectedShopId({required this.repository});

  final SelectedShopRepository repository;

  @override
  Future<Either<Failure, Unit>> call(SetSelectedShopIdParams params) =>
      repository.setSelectedShopId(params.shopId);
}

class SetSelectedShopIdParams {
  const SetSelectedShopIdParams({required this.shopId});

  final int shopId;
}
