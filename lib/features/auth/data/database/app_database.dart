// lib/data/database/app_database.dart
import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import 'tables.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [Users, Members])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  /// For tests / in‑memory:
  AppDatabase.forTesting(super.e);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async {
      await m.createAll();
    },
    onUpgrade: (m, from, to) async {
      // Add incremental migrations here as the schema evolves.
      // For now, v1 is the baseline; nothing to upgrade.
    },
    beforeOpen: (details) async {
      // Foreign keys are enforced only if enabled per connection.
      await customStatement('PRAGMA foreign_keys = ON');
    },
  );
}

DatabaseConnection _openConnection() {
  return driftDatabase(name: 'hometake');
}