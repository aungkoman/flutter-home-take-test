// lib/data/database/tables.dart
import 'package:drift/drift.dart';

class Users extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get firstName => text().withDefault(const Constant(''))();
  TextColumn get lastName =>
      text().withDefault(const Constant(''))(); // ← auth only
  TextColumn get phone => text().withDefault(const Constant(''))();
  DateTimeColumn get dob => dateTime().nullable()(); // ← auth only
  IntColumn get currentPoints => integer().withDefault(const Constant(0))();
  IntColumn get memberId => integer().withDefault(const Constant(0))();
  BoolColumn get isVerified =>
      boolean().withDefault(const Constant(false))(); // ← new
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
}

class Members extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withDefault(const Constant(''))();
  TextColumn get description => text().withDefault(const Constant(''))();
  TextColumn get imageUrl => text().withDefault(const Constant(''))();
  IntColumn get memberPoints => integer().withDefault(const Constant(0))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
}
