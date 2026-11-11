// lib/data/database/app_database.dart
import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:flutter/services.dart';

import 'tables.dart';
import '../../../product/data/database/product_tables.dart';
import '../../../product/data/database/product_seeder.dart';

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
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : _seedOnCreate = true, super(_openConnection());

  AppDatabase.forTesting(super.e, {bool seedOnCreate = false})
    : _seedOnCreate = seedOnCreate;

  final bool _seedOnCreate;

  @override
  int get schemaVersion => 5;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) => transaction(() async {
      await m.createAll();
      if (_seedOnCreate) {
        await _seedAuthData();
        await seedProductCatalog(this);
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
