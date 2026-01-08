import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../shared/models/ui_state_model.dart';
import '../entities/dashboard_stats.dart';

abstract class DashboardRepository {
  Future<Either<Failure, UIStateModel<DashboardStats>>> getDashboardStats(
      {bool isPrototype = false});
}
