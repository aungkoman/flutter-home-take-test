import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dartz/dartz.dart';

import '../../domain/usecases/get_category_products.dart';
import '../../domain/usecases/get_product_type_products.dart';
export '../../domain/usecases/get_category_products.dart';
export '../../domain/usecases/get_product_type_products.dart';
export '../../domain/entities/product_entity.dart';

final categoryProductsProvider = AsyncNotifierProvider.autoDispose
    .family<CategoryProductsNotifier, ProductCollection, int>(
      (id) => throw StateError(
        'Provide CategoryProductsNotifier in the root ProviderScope.',
      ),
    );
final productTypeProductsProvider = AsyncNotifierProvider.autoDispose
    .family<ProductTypeProductsNotifier, ProductCollection, int>(
      (id) => throw StateError(
        'Provide ProductTypeProductsNotifier in the root ProviderScope.',
      ),
    );

class CategoryProductsNotifier extends AsyncNotifier<ProductCollection> {
  CategoryProductsNotifier(this._getProducts, this.id);
  final GetCategoryProducts _getProducts;
  final int id;
  @override
  Future<ProductCollection> build() async {
    final Either<Failure, ProductCollection> result = await _getProducts(
      GetCategoryProductsParams(categoryId: id),
    );
    return result.fold((failure) => throw failure, (collection) => collection);
  }
}

class ProductTypeProductsNotifier extends AsyncNotifier<ProductCollection> {
  ProductTypeProductsNotifier(this._getProducts, this.id);
  final GetProductTypeProducts _getProducts;
  final int id;
  @override
  Future<ProductCollection> build() async {
    final Either<Failure, ProductCollection> result = await _getProducts(
      GetProductTypeProductsParams(productTypeId: id),
    );
    return result.fold((failure) => throw failure, (collection) => collection);
  }
}
