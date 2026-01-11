import 'package:dartz/dartz.dart';
import 'package:flashlight_pos/features/work_order/domain/usecases/work_order_usecases.dart';

import '../../../../core/error/failures.dart';
import '../entities/work_order.dart';

/// Abstract repository interface for work order operations.
abstract class WorkOrderRepository {
  /// Creates a new work order.
  Future<Either<Failure, WorkOrder>> createWorkOrder(WorkOrder workOrder);

  /// Gets all work orders.
  Future<Either<Failure, List<WorkOrder>>> getWorkOrders({required GetWorkOrdersParams params});

  /// Updates an existing work order.
  Future<Either<Failure, WorkOrder>> updateWorkOrder(WorkOrder workOrder);

  /// Updates work order status.
  Future<Either<Failure, WorkOrder>> updateWorkOrderStatus(String id, String status);

  /// Gets a work order by id.
  Future<Either<Failure, WorkOrder>> getWorkOrderById(String id);
}
