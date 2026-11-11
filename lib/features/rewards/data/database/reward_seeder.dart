import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:flutter/services.dart';

import '../../../auth/data/database/app_database.dart';

Future<void> seedRewards(
  AppDatabase db, {
  bool replaceDemoProgress = false,
}) async {
  final String source = await rootBundle.loadString(
    'assets/seeds/reward_seed.json',
  );
  final Map<String, dynamic> seed = jsonDecode(source) as Map<String, dynamic>;
  await db.batch((Batch batch) {
    batch.insertAll(
      db.rewards,
      (seed['rewards'] as List<dynamic>).cast<Map<String, dynamic>>().map(
        (row) => RewardsCompanion.insert(
          id: Value(row['id'] as int),
          name: row['name'] as String,
          description: row['description'] as String,
          imageUrl: row['imageUrl'] as String,
          colorCode: row['colorCode'] as String,
          rewardPoints: row['rewardPoints'] as int,
        ),
      ),
      mode: InsertMode.insertOrIgnore,
    );
    batch.insertAll(
      db.earns,
      (seed['earns'] as List<dynamic>).cast<Map<String, dynamic>>().map(
        (row) => EarnsCompanion.insert(
          id: Value(row['id'] as int),
          productId: row['productId'] as int,
          quantity: row['quantity'] as int,
          earnPoints: row['earnPoints'] as int,
        ),
      ),
      mode: InsertMode.insertOrIgnore,
    );
    batch.insertAll(
      db.gifts,
      (seed['gifts'] as List<dynamic>).cast<Map<String, dynamic>>().map(
        (row) => GiftsCompanion.insert(
          id: Value(row['id'] as int),
          name: row['name'] as String,
          description: row['description'] as String,
          imageUrl: row['imageUrl'] as String,
          giftPoints: row['giftPoints'] as int,
        ),
      ),
      mode: InsertMode.insertOrIgnore,
    );
  });
  // Resolve seed users by phone: existing installations may have different IDs.
  for (final Map<String, dynamic> row
      in (seed['progress'] as List<dynamic>).cast<Map<String, dynamic>>()) {
    final User? user = await (db.select(
      db.users,
    )..where((u) => u.phone.equals(row['phone'] as String))).getSingleOrNull();
    if (user == null) continue;
    await db
        .into(db.earnProgress)
        .insert(
          EarnProgressCompanion.insert(
            userId: user.id,
            earnId: row['earnId'] as int,
            completedQuantity: row['completedQuantity'] as int,
          ),
          mode: replaceDemoProgress
              ? InsertMode.insertOrReplace
              : InsertMode.insertOrIgnore,
        );
  }
}
