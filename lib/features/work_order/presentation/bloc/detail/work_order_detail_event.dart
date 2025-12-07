import 'package:equatable/equatable.dart';

abstract class WorkOrderDetailEvent extends Equatable {
  const WorkOrderDetailEvent();
}

class LoadWorkOrderDetail extends WorkOrderDetailEvent {
  final String id;

  const LoadWorkOrderDetail(this.id);

  @override
  List<Object> get props => [id];
}

class UpdateWorkOrderStatusEvent extends WorkOrderDetailEvent {
  final String id;
  final String status;

  const UpdateWorkOrderStatusEvent(this.id, this.status);

  @override
  List<Object> get props => [id, status];
}
