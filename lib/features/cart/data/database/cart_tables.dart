import 'package:drift/drift.dart';

import '../../../auth/data/database/tables.dart';
import '../../../product/data/database/product_tables.dart';

class CartItems extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get userId =>
      integer().nullable().references(Users, #id, onDelete: KeyAction.cascade)();
  IntColumn get shopId =>
      integer().nullable().references(Shops, #id, onDelete: KeyAction.cascade)();
  IntColumn get productId =>
      integer().references(Products, #id, onDelete: KeyAction.cascade)();
  IntColumn get quantity =>
      integer().customConstraint('NOT NULL CHECK (quantity > 0)')();

  @override
  List<Set<Column>> get uniqueKeys => [
    {userId, shopId, productId},
  ];
}

class SelectedShops extends Table {
  IntColumn get id => integer().withDefault(const Constant(1))();
  IntColumn get shopId =>
      integer().references(Shops, #id, onDelete: KeyAction.cascade)();

  @override
  Set<Column> get primaryKey => {id};
}
