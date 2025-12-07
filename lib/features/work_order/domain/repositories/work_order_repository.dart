import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/work_order.dart';

abstract class WorkOrderRepository {
  Future<Either<Failure, WorkOrder>> createWorkOrder(WorkOrder workOrder);
  Future<Either<Failure, List<WorkOrder>>> getWorkOrders();
  Future<Either<Failure, WorkOrder>> updateWorkOrder(
      WorkOrder workOrder); // Simplified update for now
}
