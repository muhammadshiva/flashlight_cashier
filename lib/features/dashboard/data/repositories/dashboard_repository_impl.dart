import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../shared/models/ui_state_model.dart';
import '../../domain/entities/dashboard_stats.dart';
import '../../domain/repositories/dashboard_repository.dart';
import '../datasources/dashboard_remote_data_source.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  final DashboardRemoteDataSource remoteDataSource;

  DashboardRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, UIStateModel<DashboardStats>>> getDashboardStats({
    bool isPrototype = false,
  }) async {
    try {
      final result = await remoteDataSource.getDashboardStats(isPrototype: isPrototype);
      final entity = result.toEntity();

      // Wrap entity in UIStateModel.success
      return Right(UIStateModel.success(data: entity));
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
