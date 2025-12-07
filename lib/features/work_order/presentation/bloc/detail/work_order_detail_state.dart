import 'package:equatable/equatable.dart';
import '../../../domain/entities/work_order.dart';

abstract class WorkOrderDetailState extends Equatable {
  const WorkOrderDetailState();

  @override
  List<Object?> get props => [];
}

class WorkOrderDetailInitial extends WorkOrderDetailState {}

class WorkOrderDetailLoading extends WorkOrderDetailState {}

class WorkOrderDetailLoaded extends WorkOrderDetailState {
  final WorkOrder workOrder;

  const WorkOrderDetailLoaded(this.workOrder);

  @override
  List<Object?> get props => [workOrder];
}

class WorkOrderDetailError extends WorkOrderDetailState {
  final String message;

  const WorkOrderDetailError(this.message);

  @override
  List<Object?> get props => [message];
}
