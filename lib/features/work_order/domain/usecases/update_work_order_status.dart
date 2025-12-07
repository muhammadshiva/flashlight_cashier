import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/work_order.dart';
import '../repositories/work_order_repository.dart';

class UpdateWorkOrderStatus implements UseCase<WorkOrder, WorkOrder> {
  final WorkOrderRepository repository;

  UpdateWorkOrderStatus(this.repository);

  @override
  Future<Either<Failure, WorkOrder>> call(WorkOrder params) async {
    return await repository.updateWorkOrder(params);
  }
}
