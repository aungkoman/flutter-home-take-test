import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hometake/features/auth/data/database/app_database.dart';
import 'package:hometake/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:hometake/features/cart/data/datasources/cart_local_datasource.dart';
import 'package:hometake/features/cart/domain/entities/cart_item_entity.dart';
import 'package:hometake/features/product/data/datasources/product_local_datasource.dart';

void main() {
  late AppDatabase database;

  setUp(() {
    database = AppDatabase.forTesting(NativeDatabase.memory());
  });

  tearDown(() async {
    await database.close();
  });

  test('cart rows are scoped and legacy items are adopted on access', () async {
    final DateTime now = DateTime.utc(2026);
    final int userId = await database.into(database.users).insert(
      UsersCompanion.insert(createdAt: now, updatedAt: now),
    );
    final int shopId = await database.into(database.shops).insert(
      ShopsCompanion.insert(
        name: 'Central',
        description: '',
        address: 'Main Street',
        imageUrl: '',
        lat: 0,
        lng: 0,
      ),
    );
    final int productTypeId = await database
        .into(database.productTypes)
        .insert(
          ProductTypesCompanion.insert(
            name: 'Donuts',
            imageUrl: '',
            priorityNo: 0,
          ),
        );
    final int productId = await database.into(database.products).insert(
      ProductsCompanion.insert(
        name: 'Glazed',
        imageUrl: '',
        priorityNo: 0,
        isNew: false,
        productTypeId: productTypeId,
      ),
    );

    final int cartId = await database.into(database.cartItems).insert(
      CartItemsCompanion.insert(
        userId: Value(userId),
        shopId: Value(shopId),
        productId: productId,
        quantity: 2,
      ),
    );
    await database.into(database.selectedShops).insert(
      SelectedShopsCompanion.insert(id: const Value(1), shopId: shopId),
    );
    await database.into(database.cartItems).insert(
      CartItemsCompanion.insert(productId: productId, quantity: 1),
    );

    final List<CartItemEntity> items = await CartLocalDatasource(
      db: database,
      productDatasource: ProductLocalDatasourceImpl(db: database),
      authDatasource: AuthLocalDatasourceImpl(db: database),
    ).getItems(userId: userId, shopId: shopId);
    final row = await (database.select(
      database.cartItems,
    )..where((item) => item.id.equals(cartId))).getSingle();
    final selection = await database.select(database.selectedShops).getSingle();

    expect(items, hasLength(1));
    expect(items.single.quantity, 3);
    expect(row.userId, userId);
    expect(row.shopId, shopId);
    expect(row.productId, productId);
    expect(row.quantity, 3);
    expect(selection.shopId, shopId);
  });
}
