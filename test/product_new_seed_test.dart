import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hometake/features/auth/data/database/app_database.dart';
import 'package:hometake/features/product/data/database/product_seeder.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test(
    'new flags cover a subset and update existing rows without changing prices',
    () async {
      final seed = jsonDecode(
        await rootBundle.loadString('assets/seeds/product_seed.json'),
      ) as Map<String, dynamic>;
      final products = (seed['products'] as List).cast<Map<String, dynamic>>();
      final flagged = products.where((row) => row['isNew'] == true).toList();
      expect(flagged, isNotEmpty);
      expect(flagged.length, lessThan(products.length));
      final db = AppDatabase.forTesting(NativeDatabase.memory());
      addTearDown(db.close);
      await db
          .into(db.productTypes)
          .insert(
            ProductTypesCompanion.insert(
              id: const Value(1),
              name: 'Donuts',
              imageUrl: '',
              priorityNo: 0,
            ),
          );
      final row = flagged.first;
      await db
          .into(db.products)
          .insert(
            ProductsCompanion.insert(
              id: Value(row['id'] as int),
              name: 'Demo',
              imageUrl: '',
              priorityNo: 0,
              price: const Value(9999),
              isNew: false,
              productTypeId: 1,
            ),
          );
      await seedProductNewFlags(db);
      await seedProductNewFlags(db);
      final product = await db.select(db.products).getSingle();
      expect(product.isNew, isTrue);
      expect(product.price, 9999);
    },
  );
}
