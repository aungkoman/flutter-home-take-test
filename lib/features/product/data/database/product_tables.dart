import 'package:drift/drift.dart';

class ProductTypes extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get imageUrl => text()();
  IntColumn get priorityNo => integer()();
}

class Products extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get imageUrl => text()();
  IntColumn get priorityNo => integer()();
  RealColumn get price => real().nullable()();
  TextColumn get currency => text().nullable()();
  TextColumn get productCode => text().nullable()();
  TextColumn get description => text().nullable()();
  BoolColumn get isNew => boolean()();
  RealColumn get discountPercentage => real().nullable()();
  RealColumn get discountAmount => real().nullable()();
  IntColumn get productTypeId => integer().references(ProductTypes, #id)();
}

class Banners extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get imageUrl => text()();
}

class Shops extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get description => text()();
  TextColumn get address => text()();
  TextColumn get imageUrl => text()();
  RealColumn get lat => real()();
  RealColumn get lng => real()();
}

class Categories extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get imageUrl => text()();
  IntColumn get priorityNo => integer()();
  BoolColumn get isActive => boolean()();
}

class CategoryProducts extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get categoryId => integer().references(Categories, #id)();
  IntColumn get productId => integer().references(Products, #id)();

  @override
  List<Set<Column>> get uniqueKeys => [
    {categoryId, productId},
  ];
}
