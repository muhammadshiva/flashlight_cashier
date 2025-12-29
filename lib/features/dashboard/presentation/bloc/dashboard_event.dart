import 'package:equatable/equatable.dart';

abstract class DashboardEvent extends Equatable {
  const DashboardEvent();

  @override
  List<Object> get props => [];
}

class LoadDashboardStats extends DashboardEvent {}

class RefreshDashboard extends DashboardEvent {}

class FilterWorkOrders extends DashboardEvent {
  final String? status;
  final String? searchQuery;

  const FilterWorkOrders({this.status, this.searchQuery});

  @override
  List<Object> get props =>
      [if (status != null) status!, if (searchQuery != null) searchQuery!];
}

class UpdateWorkOrderStatusEvent extends DashboardEvent {
  final String workOrderId;
  final String newStatus;

  const UpdateWorkOrderStatusEvent({
    required this.workOrderId,
    required this.newStatus,
  });

  @override
  List<Object> get props => [workOrderId, newStatus];
}

class AddWorkOrderItemEvent extends DashboardEvent {
  final String workOrderId;
  final Map<String, dynamic> item; // Simulating item object for now
  final String type; // 'Service' or 'Product'

  const AddWorkOrderItemEvent({
    required this.workOrderId,
    required this.item,
    required this.type,
  });

  @override
  List<Object> get props => [workOrderId, item, type];
}

class RemoveWorkOrderItemEvent extends DashboardEvent {
  final String workOrderId;
  final String itemId;
  final String type; // 'Service' or 'Product'

  const RemoveWorkOrderItemEvent({
    required this.workOrderId,
    required this.itemId,
    required this.type,
  });

  @override
  List<Object> get props => [workOrderId, itemId, type];
}
