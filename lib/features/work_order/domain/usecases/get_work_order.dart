import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/work_order.dart';
import '../repositories/work_order_repository.dart';
import 'work_order_usecases.dart';

class GetWorkOrder implements UseCase<WorkOrder, GetWorkOrderByIdParams> {
  final WorkOrderRepository repository;

  GetWorkOrder(this.repository);

  @override
  Future<Either<Failure, WorkOrder>> call(GetWorkOrderByIdParams params) async {
    return await repository.getWorkOrderById(params);
  }
}
