import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/selected_shop_repository.dart';

export '../../../../core/error/failures.dart';

class GetSelectedShopId implements UseCase<int?, NoParams> {
  GetSelectedShopId({required this.repository});

  final SelectedShopRepository repository;

  @override
  Future<Either<Failure, int?>> call(NoParams params) =>
      repository.getSelectedShopId();
}
