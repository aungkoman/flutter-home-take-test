import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:flutter/services.dart';

import '../../../auth/data/database/app_database.dart';

Future<void> seedProductCatalog(AppDatabase db) async {
  final String source = await rootBundle.loadString(
    'assets/seeds/product_seed.json',
  );
  final Map<String, dynamic> seed = jsonDecode(source) as Map<String, dynamic>;

  await db.batch((batch) {
    batch.insertAllOnConflictUpdate(
      db.productTypes,
      (seed['productTypes'] as List).cast<Map<String, dynamic>>().map(
        (row) => ProductTypesCompanion.insert(
          id: Value(row['id'] as int),
          name: row['name'] as String,
          imageUrl: row['imageUrl'] as String,
          priorityNo: row['priorityNo'] as int,
        ),
      ),
    );
    batch.insertAllOnConflictUpdate(
      db.products,
      (seed['products'] as List).cast<Map<String, dynamic>>().map(
        (row) => ProductsCompanion.insert(
          id: Value(row['id'] as int),
          name: row['name'] as String,
          imageUrl: row['imageUrl'] as String,
          priorityNo: row['priorityNo'] as int,
          price: Value((row['price'] as num?)?.toDouble()),
          currency: Value(row['currency'] as String?),
          productCode: Value(row['productCode'] as String?),
          description: Value(row['description'] as String?),
          isNew: row['isNew'] as bool,
          discountPercentage: Value(
            (row['discountPercentage'] as num?)?.toDouble(),
          ),
          discountAmount: Value((row['discountAmount'] as num?)?.toDouble()),
          productTypeId: row['productTypeId'] as int,
        ),
      ),
    );
    batch.insertAllOnConflictUpdate(
      db.banners,
      (seed['banners'] as List).cast<Map<String, dynamic>>().map(
        (row) => BannersCompanion.insert(
          id: Value(row['id'] as int),
          name: row['name'] as String,
          imageUrl: row['imageUrl'] as String,
        ),
      ),
    );
    batch.insertAllOnConflictUpdate(
      db.shops,
      (seed['shops'] as List).cast<Map<String, dynamic>>().map(
        (row) => ShopsCompanion.insert(
          id: Value(row['id'] as int),
          name: row['name'] as String,
          description: row['description'] as String,
          address: row['address'] as String,
          imageUrl: row['imageUrl'] as String,
          lat: (row['lat'] as num).toDouble(),
          lng: (row['lng'] as num).toDouble(),
        ),
      ),
    );
    batch.insertAllOnConflictUpdate(
      db.categories,
      (seed['categories'] as List).cast<Map<String, dynamic>>().map(
        (row) => CategoriesCompanion.insert(
          id: Value(row['id'] as int),
          name: row['name'] as String,
          imageUrl: row['imageUrl'] as String,
          priorityNo: row['priorityNo'] as int,
          isActive: row['isActive'] as bool,
        ),
      ),
    );
    batch.insertAll(
      db.categoryProducts,
      (seed['categoryProducts'] as List).cast<Map<String, dynamic>>().map(
        (row) => CategoryProductsCompanion.insert(
          categoryId: row['categoryId'] as int,
          productId: row['productId'] as int,
        ),
      ),
      mode: InsertMode.insertOrIgnore,
    );
  });
}

Future<void> seedProductPrices(AppDatabase db) async {
  final String source = await rootBundle.loadString(
    'assets/seeds/product_seed.json',
  );
  final Map<String, dynamic> seed = jsonDecode(source) as Map<String, dynamic>;

  for (final Map<String, dynamic> row
      in (seed['products'] as List).cast<Map<String, dynamic>>()) {
    await (db.update(db.products)..where(
          (product) =>
              product.id.equals(row['id'] as int) & product.price.isNull(),
        ))
        .write(
          ProductsCompanion(price: Value((row['price'] as num).toDouble())),
        );
  }
}
