import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/work_order.dart';
import '../repositories/work_order_repository.dart';

/// Use case for creating a new work order.
class CreateWorkOrder implements UseCase<WorkOrder, WorkOrder> {
  final WorkOrderRepository repository;
  CreateWorkOrder(this.repository);
  @override
  Future<Either<Failure, WorkOrder>> call(WorkOrder params) async {
    return await repository.createWorkOrder(params);
  }
}

/// Use case for getting all work orders.
class GetWorkOrders implements UseCase<List<WorkOrder>, GetWorkOrdersParams> {
  final WorkOrderRepository repository;
  GetWorkOrders(this.repository);
  @override
  Future<Either<Failure, List<WorkOrder>>> call(GetWorkOrdersParams params) async {
    return await repository.getWorkOrders(params: params);
  }
}

/// Parameters for [GetDashboardStats] use case.
class GetWorkOrdersParams {
  /// When true, returns prototype/mock data for testing.
  final bool isPrototype;

  const GetWorkOrdersParams({
    this.isPrototype = false,
  });
}
