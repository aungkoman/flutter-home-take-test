import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/usecases/get_product_by_id.dart';
export '../../domain/usecases/get_product_by_id.dart';

final productDetailProvider = AsyncNotifierProvider.autoDispose
    .family<ProductDetailNotifier, ProductEntity, int>(
      (id) => throw StateError(
        'Provide ProductDetailNotifier in the root ProviderScope.',
      ),
    );

class ProductDetailNotifier extends AsyncNotifier<ProductEntity> {
  ProductDetailNotifier(this._getProduct, this.id);
  final GetProductById _getProduct;
  final int id;
  @override
  Future<ProductEntity> build() async {
    final Either<Failure, ProductEntity> result = await _getProduct(
      GetProductByIdParams(productId: id),
    );
    return result.fold((failure) => throw failure, (product) => product);
  }
}
