// lib/data/database/app_database.dart
import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:flutter/services.dart';

import 'tables.dart';
import '../../../product/data/database/product_tables.dart';
import '../../../product/data/database/product_seeder.dart';

import '../../../cart/data/database/cart_tables.dart';
import '../../../rewards/data/database/reward_tables.dart';
import '../../../rewards/data/database/reward_seeder.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    Users,
    Members,
    ProductTypes,
    Products,
    Banners,
    Shops,
    Categories,
    CategoryProducts,
    CartItems,
    SelectedShops,
    Rewards,
    Earns,
    Gifts,
    EarnProgress,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : _seedOnCreate = true, super(_openConnection());

  AppDatabase.forTesting(super.e, {this._seedOnCreate = false});

  final bool _seedOnCreate;

  @override
  int get schemaVersion => 12;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) => transaction(() async {
      await m.createAll();
      if (_seedOnCreate) {
        await _seedAuthData();
        await seedProductCatalog(this);
        await seedRewards(this);
      }
    }),
    onUpgrade: (m, from, to) async {
      if (from < 2) {
        await m.alterTable(TableMigration(users));
      }
      if (from < 3) {
        await transaction(() async {
          await m.createTable(productTypes);
          await m.createTable(products);
          await m.createTable(banners);
          await m.createTable(shops);
          await m.createTable(categories);
          await m.createTable(categoryProducts);
          if (_seedOnCreate) {
            await seedProductCatalog(this);
          }
        });
      }
      if (from == 3) {
        await transaction(() async {
          await m.alterTable(TableMigration(products));
          if (_seedOnCreate) {
            await seedProductCatalog(this);
          }
        });
      }
      if (from == 4 && _seedOnCreate) {
        await transaction(() => seedProductPrices(this));
      }
      if (from >= 4 && from < 6 && _seedOnCreate) {
        await transaction(() => seedProductCodes(this));
      }
      if (from >= 4 && from < 7 && _seedOnCreate) {
        await transaction(() => seedShops(this));
      }
      if (from >= 4 && from < 8 && _seedOnCreate) {
        await transaction(() => seedHomeCatalog(this));
      }
      if (from < 9) {
        await transaction(() async {
          await m.createTable(rewards);
          await m.createTable(earns);
          await m.createTable(gifts);
          await m.createTable(earnProgress);
          if (_seedOnCreate) await seedRewards(this);
        });
      }
      if (from < 10 && _seedOnCreate) {
        await transaction(() => seedProductDescriptions(this));
      }
      if (from < 11) {
        await m.createTable(cartItems);
      } else if (from < 12) {
        await customStatement(
          'ALTER TABLE cart_items RENAME TO cart_items_v11',
        );
        await m.createTable(cartItems);
        await customStatement(
          'INSERT INTO cart_items (user_id, shop_id, product_id, quantity) '
          'SELECT NULL, NULL, product_id, quantity FROM cart_items_v11',
        );
        await customStatement('DROP TABLE cart_items_v11');
      }
      if (from < 12) await m.createTable(selectedShops);
    },
    beforeOpen: (details) async {
      // Foreign keys are enforced only if enabled per connection.
      await customStatement('PRAGMA foreign_keys = ON');
    },
  );

  Future<void> _seedAuthData() async {
    final source = await rootBundle.loadString('assets/seeds/auth_seed.json');
    final seed = jsonDecode(source) as Map<String, dynamic>;
    final timestamp = DateTime.now().toUtc();

    await batch((batch) {
      final tierRows = (seed['members'] as List)
          .cast<Map<String, dynamic>>()
          .map(
            (row) => MembersCompanion.insert(
              id: Value(row['id'] as int),
              name: Value(row['name'] as String),
              memberPoints: Value(row['memberPoints'] as int),
              createdAt: timestamp,
              updatedAt: timestamp,
            ),
          );
      final userRows = (seed['users'] as List).cast<Map<String, dynamic>>().map(
        (row) => UsersCompanion.insert(
          firstName: Value(row['firstName'] as String),
          lastName: Value(row['lastName'] as String),
          phone: Value(row['phone'] as String),
          currentPoints: Value(row['currentPoints'] as int),
          memberId: Value(row['memberId'] as int),
          createdAt: timestamp,
          updatedAt: timestamp,
        ),
      );

      batch.insertAll(members, tierRows);
      batch.insertAll(users, userRows);
    });
  }
}

DatabaseConnection _openConnection() {
  return driftDatabase(name: 'hometake');
}
