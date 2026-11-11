import 'package:drift/drift.dart';

import '../../../product/data/database/product_tables.dart';
import '../../../auth/data/database/tables.dart';

@DataClassName('RewardRow')
class Rewards extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get description => text()();
  TextColumn get imageUrl => text()();
  TextColumn get colorCode => text()();
  IntColumn get rewardPoints =>
      integer().customConstraint('NOT NULL CHECK (reward_points >= 0)')();
}

@DataClassName('EarnRow')
class Earns extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get productId => integer().references(Products, #id)();
  IntColumn get quantity => integer().check(quantity.isBiggerThanValue(0))();
  IntColumn get earnPoints =>
      integer().check(earnPoints.isBiggerThanValue(0))();
}

@DataClassName('GiftRow')
class Gifts extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get description => text()();
  TextColumn get imageUrl => text()();
  IntColumn get giftPoints =>
      integer().check(giftPoints.isBiggerThanValue(0))();
}

@DataClassName('EarnProgressRow')
class EarnProgress extends Table {
  IntColumn get userId => integer().references(Users, #id)();
  IntColumn get earnId => integer().references(Earns, #id)();
  IntColumn get completedQuantity =>
      integer().customConstraint('NOT NULL CHECK (completed_quantity >= 0)')();
  @override
  Set<Column> get primaryKey => {userId, earnId};
}
