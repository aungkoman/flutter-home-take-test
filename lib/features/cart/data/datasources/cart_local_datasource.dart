import 'package:drift/drift.dart';

import '../../../auth/data/database/app_database.dart';
import '../../../auth/data/datasources/auth_local_datasource.dart';
import '../../../auth/domain/entities/user_entity.dart';
import '../../../order/domain/entities/cart_entity.dart';
import '../../../product/data/datasources/product_local_datasource.dart';
import '../../../product/domain/entities/shop_entity.dart';
import '../../domain/entities/cart_item_entity.dart';

class CartLocalDatasource {
  CartLocalDatasource({
    required this.db,
    required this.productDatasource,
    required this.authDatasource,
  });

  final AppDatabase db;
  final ProductLocalDatasource productDatasource;
  final AuthLocalDatasource authDatasource;

  Future<List<CartItemEntity>> getItems({
    required int userId,
    required int shopId,
  }) async {
    await _adoptLegacyItems(userId: userId, shopId: shopId);
    final rows = await (db.select(db.cartItems)
          ..where(
            (item) =>
                item.userId.equals(userId) & item.shopId.equals(shopId),
          )
          ..orderBy([(item) => OrderingTerm.asc(item.id)]))
        .get();
    final UserEntity? user = await authDatasource.getUserById(userId: userId);
    final shopRow = await (db.select(
      db.shops,
    )..where((shop) => shop.id.equals(shopId))).getSingleOrNull();
    if (user == null || shopRow == null) {
      throw StateError('The cart user or shop no longer exists.');
    }
    final ShopEntity shop = ShopEntity(
      id: shopRow.id,
      name: shopRow.name,
      description: shopRow.description,
      address: shopRow.address,
      imageUrl: shopRow.imageUrl,
      lat: shopRow.lat,
      lng: shopRow.lng,
    );
    return Future.wait(
      rows.map((row) async {
        final product = await productDatasource.getProductById(
          productId: row.productId,
        );
        if (product == null) {
          throw StateError('Cart product ${row.productId} no longer exists.');
        }
        return CartItemEntity(
          cart: CartEntity(
            id: row.id,
            userId: row.userId!,
            shopId: row.shopId!,
            productId: row.productId,
            user: user,
            shop: shop,
            product: product,
          ),
          quantity: row.quantity,
        );
      }),
    );
  }

  Future<void> _adoptLegacyItems({
    required int userId,
    required int shopId,
  }) async {
    await db.transaction(() async {
      final legacyRows = await (db.select(db.cartItems)
            ..where((item) => item.userId.isNull() & item.shopId.isNull()))
          .get();
      for (final legacy in legacyRows) {
        final scoped = await (db.select(db.cartItems)
              ..where(
                (item) =>
                    item.userId.equals(userId) &
                    item.shopId.equals(shopId) &
                    item.productId.equals(legacy.productId),
              ))
            .getSingleOrNull();
        if (scoped == null) {
          await (db.update(db.cartItems)
                ..where((item) => item.id.equals(legacy.id)))
              .write(
                CartItemsCompanion(
                  userId: Value(userId),
                  shopId: Value(shopId),
                ),
              );
        } else {
          await (db.update(db.cartItems)
                ..where((item) => item.id.equals(scoped.id)))
              .write(
                CartItemsCompanion(
                  quantity: Value(scoped.quantity + legacy.quantity),
                ),
              );
          await (db.delete(
            db.cartItems,
          )..where((item) => item.id.equals(legacy.id))).go();
        }
      }
    });
  }

  Future<int> addItem({
    required int userId,
    required int shopId,
    required int productId,
    required int quantity,
  }) async {
    return db.transaction(() async {
      final current = await (db.select(db.cartItems)
            ..where(
              (item) =>
                  item.userId.equals(userId) &
                  item.shopId.equals(shopId) &
                  item.productId.equals(productId),
            ))
          .getSingleOrNull();
      if (current != null) {
        await (db.update(db.cartItems)
              ..where((item) => item.id.equals(current.id)))
            .write(
              CartItemsCompanion(
                quantity: Value(current.quantity + quantity),
              ),
            );
        return current.id;
      }
      return db.into(db.cartItems).insert(
        CartItemsCompanion.insert(
          userId: Value(userId),
          shopId: Value(shopId),
          productId: productId,
          quantity: quantity,
        ),
      );
    });
  }

  Future<void> setQuantity({
    required int userId,
    required int shopId,
    required int cartItemId,
    required int quantity,
  }) async {
    await (db.update(db.cartItems)
          ..where(
            (item) =>
                item.id.equals(cartItemId) &
                item.userId.equals(userId) &
                item.shopId.equals(shopId),
          ))
        .write(CartItemsCompanion(quantity: Value(quantity)));
  }

  Future<void> removeItem({
    required int userId,
    required int shopId,
    required int cartItemId,
  }) async {
    await (db.delete(db.cartItems)
          ..where(
            (item) =>
                item.id.equals(cartItemId) &
                item.userId.equals(userId) &
                item.shopId.equals(shopId),
          ))
        .go();
  }
}
