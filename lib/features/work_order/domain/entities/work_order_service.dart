import 'package:equatable/equatable.dart';
import '../../../service/domain/entities/service_entity.dart';

class WorkOrderService extends Equatable {
  final String id;
  final String workOrderId;
  final String serviceId;
  final int quantity;
  final int priceAtOrder;
  final int subtotal;
  final ServiceEntity? service;

  const WorkOrderService({
    required this.id,
    required this.workOrderId,
    required this.serviceId,
    required this.quantity,
    required this.priceAtOrder,
    required this.subtotal,
    this.service,
  });

  @override
  List<Object?> get props =>
      [id, workOrderId, serviceId, quantity, priceAtOrder, subtotal, service];
}
