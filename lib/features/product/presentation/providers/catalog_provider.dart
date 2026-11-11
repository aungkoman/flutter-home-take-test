import 'package:riverpod/riverpod.dart';

import '../../../../core/usecase/usecase.dart';
import '../../domain/usecases/get_product_catalog.dart';

export '../../domain/usecases/get_product_catalog.dart';

final catalogProvider = AsyncNotifierProvider<CatalogNotifier, ProductCatalog>(
  () => throw StateError('Provide CatalogNotifier in the root ProviderScope.'),
);

class CatalogNotifier extends AsyncNotifier<ProductCatalog> {
  CatalogNotifier(this._getCatalog);

  final GetProductCatalog _getCatalog;

  @override
  Future<ProductCatalog> build() async {
    final Either<Failure, ProductCatalog> result = await _getCatalog(
      NoParams(),
    );
    return result.fold(
      (failure) => throw StateError('Could not load the catalog. Try again.'),
      (catalog) => catalog,
    );
  }
}
