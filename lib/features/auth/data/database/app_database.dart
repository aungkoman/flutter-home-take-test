// lib/data/database/app_database.dart
import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:flutter/services.dart';

import 'tables.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [Users, Members])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : _seedOnCreate = true, super(_openConnection());

  AppDatabase.forTesting(super.e, {bool seedOnCreate = false})
    : _seedOnCreate = seedOnCreate;

  final bool _seedOnCreate;

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) => transaction(() async {
      await m.createAll();
      if (_seedOnCreate) {
        await _seedAuthData();
      }
    }),
    onUpgrade: (m, from, to) async {
      if (from < 2) {
        await m.alterTable(TableMigration(users));
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
