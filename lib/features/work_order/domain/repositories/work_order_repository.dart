import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/work_order.dart';

abstract class WorkOrderRepository {
  Future<Either<Failure, WorkOrder>> createWorkOrder(WorkOrder workOrder);
  Future<Either<Failure, List<WorkOrder>>> getWorkOrders({bool isPrototype = false});
  Future<Either<Failure, WorkOrder>> updateWorkOrder(
      WorkOrder workOrder); // Simplified update for now
  Future<Either<Failure, WorkOrder>> updateWorkOrderStatus(String id, String status);
  Future<Either<Failure, WorkOrder>> getWorkOrderById(String id);
}
