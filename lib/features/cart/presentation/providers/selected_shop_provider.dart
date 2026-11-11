import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/usecase/usecase.dart';
import '../../../product/presentation/providers/catalog_provider.dart';
import '../../domain/usecases/get_selected_shop_id.dart';
import '../../domain/usecases/set_selected_shop_id.dart';

export '../../../product/domain/entities/shop_entity.dart';

final selectedShopProvider =
    AsyncNotifierProvider<SelectedShopNotifier, ShopEntity?>(
      () => throw StateError(
        'Provide SelectedShopNotifier in the root ProviderScope.',
      ),
    );

class SelectedShopNotifier extends AsyncNotifier<ShopEntity?> {
  SelectedShopNotifier({
    required this.getSelectedShopId,
    required this.setSelectedShopId,
  });

  final GetSelectedShopId getSelectedShopId;
  final SetSelectedShopId setSelectedShopId;

  @override
  Future<ShopEntity?> build() async {
    final Either<Failure, int?> result = await getSelectedShopId(NoParams());
    final int? selectedId = result.fold(
      (failure) => throw StateError('Could not load the selected shop.'),
      (id) => id,
    );
    if (selectedId == null) return null;

    final ProductCatalog catalog = await ref.watch(catalogProvider.future);
    for (final ShopEntity shop in catalog.shops) {
      if (shop.id == selectedId) return shop;
    }
    throw StateError('The selected shop is not available in the catalog.');
  }

  Future<void> selectShop(ShopEntity shop) async {
    final Either<Failure, Unit> result = await setSelectedShopId(
      SetSelectedShopIdParams(shopId: shop.id),
    );
    result.fold(
      (failure) => throw StateError('Could not save the selected shop.'),
      (_) {
        state = AsyncData(shop);
      },
    );
  }
}
