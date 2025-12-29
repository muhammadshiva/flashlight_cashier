import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/work_order.dart';
import '../repositories/work_order_repository.dart';

class UpdateWorkOrderStatus implements UseCase<WorkOrder, UpdateWorkOrderStatusParams> {
  final WorkOrderRepository repository;

  UpdateWorkOrderStatus(this.repository);

  @override
  Future<Either<Failure, WorkOrder>> call(UpdateWorkOrderStatusParams params) async {
    return await repository.updateWorkOrderStatus(params.id, params.status);
  }
}

class UpdateWorkOrderStatusParams extends Equatable {
  final String id;
  final String status;

  const UpdateWorkOrderStatusParams({required this.id, required this.status});

  @override
  List<Object> get props => [id, status];
}
