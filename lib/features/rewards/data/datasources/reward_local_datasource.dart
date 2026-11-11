import 'package:drift/drift.dart';

import '../../../auth/data/database/app_database.dart';
import '../../../product/data/datasources/product_local_datasource.dart';
import '../../../product/domain/entities/product_catalog.dart';
import '../../domain/entities/reward_entity.dart';
import '../../domain/entities/earn_entity.dart';
import '../../domain/entities/gift_entity.dart';
import '../../domain/entities/earn_progress_entity.dart';

abstract class RewardLocalDatasource {
  Future<List<RewardEntity>> getRewards();
  Future<List<EarnEntity>> getEarns();
  Future<List<GiftEntity>> getGifts();
  Future<List<EarnProgressEntity>> getEarnProgress({required int userId});
}

class RewardLocalDatasourceImpl implements RewardLocalDatasource {
  RewardLocalDatasourceImpl({
    required this.db,
    required this.productLocalDatasource,
  });
  final AppDatabase db;
  final ProductLocalDatasource productLocalDatasource;

  @override
  Future<List<RewardEntity>> getRewards() async {
    await Future<void>.delayed(const Duration(seconds: 3));
    final List<RewardRow> rows =
        await (db.select(db.rewards)..orderBy([
              (r) => OrderingTerm.asc(r.rewardPoints),
              (r) => OrderingTerm.asc(r.id),
            ]))
            .get();
    return rows
        .map(
          (r) => RewardEntity(
            id: r.id,
            name: r.name,
            description: r.description,
            imageUrl: r.imageUrl,
            colorCode: r.colorCode,
            rewardPoints: r.rewardPoints,
          ),
        )
        .toList();
  }

  @override
  Future<List<EarnEntity>> getEarns() async {
    // Catalog loading already includes the three-second local delay.
    final ProductCatalog catalog = await productLocalDatasource.getCatalog();
    final Map<int, ProductEntity> products = {
      for (final ProductEntity product in catalog.products) product.id: product,
    };
    final List<EarnRow> rows = await (db.select(
      db.earns,
    )..orderBy([(r) => OrderingTerm.asc(r.id)])).get();
    return rows.map((r) {
      final ProductEntity? product = products[r.productId];
      if (product == null) {
        throw StateError('Earning offer ${r.id} references a missing product.');
      }
      return EarnEntity(
        id: r.id,
        productId: r.productId,
        productEntity: product,
        quantity: r.quantity,
        earnPoints: r.earnPoints,
      );
    }).toList();
  }

  @override
  Future<List<GiftEntity>> getGifts() async {
    await Future<void>.delayed(const Duration(seconds: 3));
    final List<GiftRow> rows =
        await (db.select(db.gifts)..orderBy([
              (r) => OrderingTerm.asc(r.giftPoints),
              (r) => OrderingTerm.asc(r.id),
            ]))
            .get();
    return rows
        .map(
          (r) => GiftEntity(
            id: r.id,
            name: r.name,
            description: r.description,
            imageUrl: r.imageUrl,
            giftPoints: r.giftPoints,
          ),
        )
        .toList();
  }

  @override
  Future<List<EarnProgressEntity>> getEarnProgress({
    required int userId,
  }) async {
    await Future<void>.delayed(const Duration(seconds: 3));
    final List<EarnProgressRow> rows = await (db.select(
      db.earnProgress,
    )..where((r) => r.userId.equals(userId))).get();
    return rows
        .map(
          (r) => EarnProgressEntity(
            userId: r.userId,
            earnId: r.earnId,
            completedQuantity: r.completedQuantity,
          ),
        )
        .toList();
  }
}
