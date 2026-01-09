import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/dashboard_stats.dart';
import '../repositories/dashboard_repository.dart';

/// Use case for fetching dashboard statistics.
///
/// This use case follows clean architecture principles:
/// - Returns [Either<Failure, DashboardStats>] for proper error handling
/// - Domain layer remains pure without UI concerns
/// - BLoC handles UI state management (loading, success, error states)
class GetDashboardStats implements UseCase<DashboardStats, DashboardParams> {
  final DashboardRepository repository;

  GetDashboardStats(this.repository);

  @override
  Future<Either<Failure, DashboardStats>> call(DashboardParams params) async {
    return await repository.getDashboardStats(isPrototype: params.isPrototype);
  }
}

/// Parameters for [GetDashboardStats] use case.
class DashboardParams extends Equatable {
  /// When true, returns prototype/mock data for testing.
  final bool isPrototype;

  const DashboardParams({
    this.isPrototype = false,
  });

  @override
  List<Object?> get props => [isPrototype];
}
