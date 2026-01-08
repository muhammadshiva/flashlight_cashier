import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../shared/models/ui_state_model.dart';
import '../entities/dashboard_stats.dart';
import '../repositories/dashboard_repository.dart';

class GetDashboardStats implements UseCase<UIStateModel<DashboardStats>, DashboardParams> {
  final DashboardRepository repository;

  GetDashboardStats(this.repository);

  @override
  Future<Either<Failure, UIStateModel<DashboardStats>>> call(DashboardParams params) async {
    return await repository.getDashboardStats(isPrototype: params.isPrototype);
  }
}

/// Parameters for GetDashboardStats use case
class DashboardParams extends Equatable {
  final bool isPrototype;

  const DashboardParams({
    this.isPrototype = false,
  });

  @override
  List<Object?> get props => [isPrototype];
}
