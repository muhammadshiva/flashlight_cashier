import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/work_order.dart';
import '../repositories/work_order_repository.dart';

class GetWorkOrder implements UseCase<WorkOrder, String> {
  final WorkOrderRepository repository;

  GetWorkOrder(this.repository);

  @override
  Future<Either<Failure, WorkOrder>> call(String params) async {
    return await repository.getWorkOrderById(params);
  }
}
