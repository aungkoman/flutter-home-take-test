import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth/presentation/providers/current_user_provider.dart';
import '../../../order/domain/entities/cart_entity.dart';
import '../../../product/domain/entities/product_entity.dart';
import '../../domain/usecases/add_cart_item.dart';
import '../../domain/usecases/get_cart_items.dart';
import '../../domain/usecases/remove_cart_item.dart';
import '../../domain/usecases/set_cart_item_quantity.dart';
import 'selected_shop_provider.dart';

export '../../domain/entities/cart_item_entity.dart';
export '../../domain/usecases/add_cart_item.dart';
export '../../domain/usecases/get_cart_items.dart';
export '../../domain/usecases/remove_cart_item.dart';
export '../../domain/usecases/set_cart_item_quantity.dart';

final cartProvider = AsyncNotifierProvider<CartNotifier, List<CartItemEntity>>(
  () => throw StateError('Provide CartNotifier in the root ProviderScope.'),
);

class CartNotifier extends AsyncNotifier<List<CartItemEntity>> {
  CartNotifier({
    required this.getCartItems,
    required this.addCartItem,
    required this.setCartItemQuantity,
    required this.removeCartItem,
  });

  final GetCartItems getCartItems;
  final AddCartItem addCartItem;
  final SetCartItemQuantity setCartItemQuantity;
  final RemoveCartItem removeCartItem;
  int? _loadedUserId;
  int? _loadedShopId;

  @override
  Future<List<CartItemEntity>> build() async {
    final UserEntity? user = ref.watch(currentUserProvider);
    final ShopEntity? shop = ref.watch(selectedShopProvider).value;
    if (user == null || shop == null) {
      _loadedUserId = null;
      _loadedShopId = null;
      return const [];
    }

    final Either<Failure, List<CartItemEntity>> result = await getCartItems(
      GetCartItemsParams(userId: user.id, shopId: shop.id),
    );
    final List<CartItemEntity> items = result.fold(
      (failure) => throw StateError('Could not load the cart. Try again.'),
      (items) => items,
    );
    _loadedUserId = user.id;
    _loadedShopId = shop.id;
    return items;
  }

  Future<Either<Failure, Unit>> addProduct(
    ProductEntity product,
    int quantity,
    UserEntity user,
    ShopEntity shop,
  ) async {
    final Either<Failure, int> result = await addCartItem(
      AddCartItemParams(
        userId: user.id,
        shopId: shop.id,
        productId: product.id,
        quantity: quantity,
      ),
    );
    result.fold((failure) {}, (cartItemId) {
      final List<CartItemEntity>? current = state.value;
      if (current == null ||
          _loadedUserId != user.id ||
          _loadedShopId != shop.id) {
        ref.invalidateSelf();
        return;
      }
      final int index = current.indexWhere(
        (item) => item.product.id == product.id,
      );
      final List<CartItemEntity> updated = [...current];
      if (index == -1) {
        updated.add(
          CartItemEntity(
            cart: CartEntity(
              id: cartItemId,
              userId: user.id,
              shopId: shop.id,
              productId: product.id,
              user: user,
              shop: shop,
              product: product,
            ),
            quantity: quantity,
          ),
        );
      } else {
        updated[index] = updated[index].copyWith(
          quantity: updated[index].quantity + quantity,
        );
      }
      state = AsyncData(updated);
    });
    return result.map((_) => unit);
  }

  Future<Either<Failure, Unit>> setQuantity(
    int cartItemId,
    int quantity,
  ) async {
    final UserEntity? user = ref.read(currentUserProvider);
    final ShopEntity? shop = ref.read(selectedShopProvider).value;
    if (user == null || shop == null) return Left(_missingScopeFailure());

    final Either<Failure, Unit> result = await setCartItemQuantity(
      SetCartItemQuantityParams(
        userId: user.id,
        shopId: shop.id,
        cartItemId: cartItemId,
        quantity: quantity,
      ),
    );
    result.fold((failure) {}, (_) {
      final List<CartItemEntity>? current = state.value;
      if (current == null) {
        ref.invalidateSelf();
        return;
      }
      state = AsyncData([
        for (final CartItemEntity item in current)
          if (item.id == cartItemId)
            item.copyWith(quantity: quantity)
          else
            item,
      ]);
    });
    return result;
  }

  Future<Either<Failure, Unit>> remove(int cartItemId) async {
    final UserEntity? user = ref.read(currentUserProvider);
    final ShopEntity? shop = ref.read(selectedShopProvider).value;
    if (user == null || shop == null) return Left(_missingScopeFailure());

    final Either<Failure, Unit> result = await removeCartItem(
      RemoveCartItemParams(
        userId: user.id,
        shopId: shop.id,
        cartItemId: cartItemId,
      ),
    );
    result.fold((failure) {}, (_) {
      final List<CartItemEntity>? current = state.value;
      if (current == null) {
        ref.invalidateSelf();
        return;
      }
      state = AsyncData(current.where((item) => item.id != cartItemId).toList());
    });
    return result;
  }

  Failure _missingScopeFailure() => ValidationFailure(
    errors: {
      'cart': ['Sign in and select a shop before updating your cart.'],
    },
  );
}
