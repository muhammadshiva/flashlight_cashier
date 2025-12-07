import 'package:equatable/equatable.dart';
import 'work_order_service.dart';
import 'work_order_product.dart';

class WorkOrder extends Equatable {
  final String id;
  final String workOrderCode;
  final String customerId;
  final String vehicleDataId;
  final String queueNumber;
  final String estimatedTime;
  final String status;
  final String? paymentStatus; // 'pending', 'paid', 'partially_paid'
  final String? paymentMethod; // 'cash', 'card', 'transfer'
  final int paidAmount;
  final int totalPrice;
  final List<WorkOrderService> services;
  final List<WorkOrderProduct> products;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? completedAt;

  const WorkOrder({
    required this.id,
    required this.workOrderCode,
    required this.customerId,
    required this.vehicleDataId,
    required this.queueNumber,
    required this.estimatedTime,
    required this.status,
    this.paymentStatus,
    this.paymentMethod,
    this.paidAmount = 0,
    required this.totalPrice,
    this.services = const [],
    this.products = const [],
    this.createdAt,
    this.updatedAt,
    this.completedAt,
  });

  @override
  List<Object?> get props => [
        id,
        workOrderCode,
        customerId,
        vehicleDataId,
        queueNumber,
        estimatedTime,
        status,
        paymentStatus,
        paymentMethod,
        paidAmount,
        totalPrice,
        services,
        products,
        createdAt,
        updatedAt,
        completedAt,
      ];
}
