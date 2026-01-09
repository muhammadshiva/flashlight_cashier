import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entities/dashboard_stats.dart';
import '../../domain/repositories/dashboard_repository.dart';
import '../datasources/dashboard_remote_data_source.dart';

/// Implementation of [DashboardRepository].
///
/// This class is part of the Data layer and handles data operations
/// by delegating to appropriate data sources.
class DashboardRepositoryImpl implements DashboardRepository {
  final DashboardRemoteDataSource remoteDataSource;

  DashboardRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, DashboardStats>> getDashboardStats({
    bool isPrototype = false,
  }) async {
    try {
      final result = await remoteDataSource.getDashboardStats(
        isPrototype: isPrototype,
      );
      // Convert data model to domain entity
      final entity = result.toEntity();
      return Right(entity);
    } on Failure catch (failure) {
      return Left(failure);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
