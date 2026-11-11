import 'package:drift/drift.dart';

import '../../../auth/data/database/app_database.dart';

class SelectedShopLocalDatasource {
  SelectedShopLocalDatasource({required this.db});

  final AppDatabase db;

  Future<int?> getSelectedShopId() async {
    final row = await (db.select(
      db.selectedShops,
    )..where((selection) => selection.id.equals(1))).getSingleOrNull();
    return row?.shopId;
  }

  Future<void> setSelectedShopId(int shopId) async {
    await db
        .into(db.selectedShops)
        .insertOnConflictUpdate(
          SelectedShopsCompanion.insert(
            id: const Value(1),
            shopId: shopId,
          ),
        );
  }
}
