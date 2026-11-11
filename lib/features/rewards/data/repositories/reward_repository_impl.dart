import 'dart:developer' show log;

import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entities/reward_entity.dart';
import '../../domain/entities/earn_entity.dart';
import '../../domain/entities/gift_entity.dart';
import '../../domain/entities/earn_progress_entity.dart';
import '../../domain/repositories/reward_repository.dart';
import '../datasources/reward_local_datasource.dart';

class RewardRepositoryImpl implements RewardRepository {
  RewardRepositoryImpl({required this.localDatasource});
  final RewardLocalDatasource localDatasource;
  @override
  Future<Either<Failure, List<RewardEntity>>> getRewards() =>
      _load('getRewards', localDatasource.getRewards);
  @override
  Future<Either<Failure, List<EarnEntity>>> getEarns() =>
      _load('getEarns', localDatasource.getEarns);
  @override
  Future<Either<Failure, List<GiftEntity>>> getGifts() =>
      _load('getGifts', localDatasource.getGifts);
  @override
  Future<Either<Failure, List<EarnProgressEntity>>> getEarnProgress({
    required int userId,
  }) => _load(
    'getEarnProgress',
    () => localDatasource.getEarnProgress(userId: userId),
  );
  Future<Either<Failure, T>> _load<T>(
    String method,
    Future<T> Function() request,
  ) async {
    try {
      return Right(await request());
    } catch (error, stackTrace) {
      log(
        'RewardRepositoryImpl.$method failed',
        name: 'rewards',
        error: error,
        stackTrace: stackTrace,
      );
      return Left(CacheFailure());
    }
  }
}
