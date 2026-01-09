import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/dashboard_stats.dart';

/// Repository interface for Dashboard feature.
///
/// This is part of the Domain layer and defines the contract
/// for data operations. Implementations are in the Data layer.
abstract class DashboardRepository {
  /// Fetches dashboard statistics.
  ///
  /// Returns [DashboardStats] on success or [Failure] on error.
  /// The [isPrototype] flag enables prototype/mock data for testing.
  Future<Either<Failure, DashboardStats>> getDashboardStats({
    bool isPrototype = false,
  });
}
