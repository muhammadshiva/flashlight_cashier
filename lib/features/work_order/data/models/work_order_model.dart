// ignore_for_file: invalid_annotation_target

import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/work_order.dart';
import 'work_order_product_model.dart';
import 'work_order_service_model.dart';

part 'work_order_model.freezed.dart';
part 'work_order_model.g.dart';

WorkOrderModel workOrderModelFromJson(String str) => WorkOrderModel.fromJson(json.decode(str));

String workOrderModelToJson(WorkOrderModel data) => json.encode(data.toJson());

@freezed
abstract class WorkOrderModel with _$WorkOrderModel {
  const WorkOrderModel._();

  @JsonSerializable(explicitToJson: true)
  const factory WorkOrderModel({
    @JsonKey(name: "id") required String id,
    @JsonKey(name: "workOrderCode") required String workOrderCode,
    @JsonKey(name: "customerId") required String customerId,
    @JsonKey(name: "vehicleDataId") required String vehicleDataId,
    @JsonKey(name: "queueNumber") required String queueNumber,
    @JsonKey(name: "estimatedTime") required String estimatedTime,
    @JsonKey(name: "status") required String status,
    @JsonKey(name: "paymentStatus") String? paymentStatus,
    @JsonKey(name: "paymentMethod") String? paymentMethod,
    @JsonKey(name: "paidAmount") @Default(0) int paidAmount,
    @JsonKey(name: "totalPrice") required int totalPrice,
    @JsonKey(name: "services") @Default([]) List<WorkOrderServiceModel> serviceModels,
    @JsonKey(name: "products") @Default([]) List<WorkOrderProductModel> productModels,
    @JsonKey(name: "createdAt") DateTime? createdAt,
    @JsonKey(name: "updatedAt") DateTime? updatedAt,
    @JsonKey(name: "completedAt") DateTime? completedAt,
  }) = _WorkOrderModel;

  factory WorkOrderModel.fromJson(Map<String, dynamic> json) => _$WorkOrderModelFromJson(json);

  WorkOrder toEntity() => WorkOrder(
        id: id,
        workOrderCode: workOrderCode,
        customerId: customerId,
        vehicleDataId: vehicleDataId,
        queueNumber: queueNumber,
        estimatedTime: estimatedTime,
        status: status,
        paymentStatus: paymentStatus,
        paymentMethod: paymentMethod,
        paidAmount: paidAmount,
        totalPrice: totalPrice,
        services: serviceModels.map((e) => e.toEntity()).toList(),
        products: productModels.map((e) => e.toEntity()).toList(),
        createdAt: createdAt,
        updatedAt: updatedAt,
        completedAt: completedAt,
      );
}

@freezed
abstract class WorkOrderResponseModel with _$WorkOrderResponseModel {
  const factory WorkOrderResponseModel({
    @JsonKey(name: "success") required bool success,
    @JsonKey(name: "message") required String message,
    @JsonKey(name: "data") required WorkOrderDataModel data,
    @JsonKey(name: "error_code") required int errorCode,
  }) = _WorkOrderResponseModel;

  factory WorkOrderResponseModel.fromJson(Map<String, dynamic> json) =>
      _$WorkOrderResponseModelFromJson(json);

  // Static getter for prototype data
  static List<WorkOrderModel> get getPrototypeDataWorkOrders {
    final now = DateTime.now();

    return [
      // Work Order 1 - Queued
      WorkOrderModel(
        id: 'wo-001',
        workOrderCode:
            'WO-${now.year}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}-001',
        customerId: 'cust-001',
        vehicleDataId: 'veh-001',
        queueNumber: '1',
        estimatedTime: '30 menit',
        status: 'queued',
        paymentStatus: 'pending',
        paymentMethod: null,
        paidAmount: 0,
        totalPrice: 45000,
        serviceModels: [
          const WorkOrderServiceModel(
            id: 'wos-001',
            workOrderId: 'wo-001',
            serviceId: 'svc-002',
            quantity: 1,
            priceAtOrder: 25000,
            subtotal: 25000,
          ),
          const WorkOrderServiceModel(
            id: 'wos-002',
            workOrderId: 'wo-001',
            serviceId: 'svc-003',
            quantity: 1,
            priceAtOrder: 30000,
            subtotal: 30000,
          ),
        ],
        productModels: [
          const WorkOrderProductModel(
            id: 'wop-001',
            workOrderId: 'wo-001',
            productId: 'prod-001',
            quantity: 2,
            priceAtOrder: 5000,
            subtotal: 10000,
          ),
        ],
        createdAt: now.subtract(const Duration(minutes: 10)),
        updatedAt: now.subtract(const Duration(minutes: 10)),
        completedAt: null,
      ),

      // Work Order 2 - Washing
      WorkOrderModel(
        id: 'wo-002',
        workOrderCode:
            'WO-${now.year}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}-002',
        customerId: 'cust-002',
        vehicleDataId: 'veh-002',
        queueNumber: '2',
        estimatedTime: '20 menit',
        status: 'washing',
        paymentStatus: 'pending',
        paymentMethod: null,
        paidAmount: 0,
        totalPrice: 20000,
        serviceModels: [
          const WorkOrderServiceModel(
            id: 'wos-003',
            workOrderId: 'wo-002',
            serviceId: 'svc-001',
            quantity: 1,
            priceAtOrder: 15000,
            subtotal: 15000,
          ),
        ],
        productModels: [
          const WorkOrderProductModel(
            id: 'wop-002',
            workOrderId: 'wo-002',
            productId: 'prod-003',
            quantity: 1,
            priceAtOrder: 3000,
            subtotal: 3000,
          ),
        ],
        createdAt: now.subtract(const Duration(minutes: 25)),
        updatedAt: now.subtract(const Duration(minutes: 5)),
        completedAt: null,
      ),

      // Work Order 3 - Drying
      WorkOrderModel(
        id: 'wo-003',
        workOrderCode:
            'WO-${now.year}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}-003',
        customerId: 'cust-003',
        vehicleDataId: 'veh-003',
        queueNumber: '3',
        estimatedTime: '45 menit',
        status: 'drying',
        paymentStatus: 'pending',
        paymentMethod: null,
        paidAmount: 0,
        totalPrice: 70000,
        serviceModels: [
          const WorkOrderServiceModel(
            id: 'wos-004',
            workOrderId: 'wo-003',
            serviceId: 'svc-004',
            quantity: 1,
            priceAtOrder: 40000,
            subtotal: 40000,
          ),
        ],
        productModels: [
          const WorkOrderProductModel(
            id: 'wop-003',
            workOrderId: 'wo-003',
            productId: 'prod-002',
            quantity: 1,
            priceAtOrder: 8000,
            subtotal: 8000,
          ),
          const WorkOrderProductModel(
            id: 'wop-004',
            workOrderId: 'wo-003',
            productId: 'prod-004',
            quantity: 3,
            priceAtOrder: 2000,
            subtotal: 6000,
          ),
        ],
        createdAt: now.subtract(const Duration(minutes: 40)),
        updatedAt: now.subtract(const Duration(minutes: 3)),
        completedAt: null,
      ),

      // Work Order 4 - Inspection
      WorkOrderModel(
        id: 'wo-004',
        workOrderCode:
            'WO-${now.year}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}-004',
        customerId: 'cust-004',
        vehicleDataId: 'veh-004',
        queueNumber: '4',
        estimatedTime: '90 menit',
        status: 'inspection',
        paymentStatus: 'pending',
        paymentMethod: null,
        paidAmount: 0,
        totalPrice: 98000,
        serviceModels: [
          const WorkOrderServiceModel(
            id: 'wos-005',
            workOrderId: 'wo-004',
            serviceId: 'svc-005',
            quantity: 1,
            priceAtOrder: 75000,
            subtotal: 75000,
          ),
        ],
        productModels: [
          const WorkOrderProductModel(
            id: 'wop-005',
            workOrderId: 'wo-004',
            productId: 'prod-001',
            quantity: 1,
            priceAtOrder: 5000,
            subtotal: 5000,
          ),
          const WorkOrderProductModel(
            id: 'wop-006',
            workOrderId: 'wo-004',
            productId: 'prod-005',
            quantity: 1,
            priceAtOrder: 15000,
            subtotal: 15000,
          ),
        ],
        createdAt: now.subtract(const Duration(hours: 1)),
        updatedAt: now.subtract(const Duration(minutes: 2)),
        completedAt: null,
      ),

      // Work Order 5 - Completed
      WorkOrderModel(
        id: 'wo-005',
        workOrderCode:
            'WO-${now.year}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}-005',
        customerId: 'cust-005',
        vehicleDataId: 'veh-005',
        queueNumber: '5',
        estimatedTime: '30 menit',
        status: 'completed',
        paymentStatus: 'pending',
        paymentMethod: null,
        paidAmount: 0,
        totalPrice: 55000,
        serviceModels: [
          const WorkOrderServiceModel(
            id: 'wos-006',
            workOrderId: 'wo-005',
            serviceId: 'svc-002',
            quantity: 1,
            priceAtOrder: 25000,
            subtotal: 25000,
          ),
          const WorkOrderServiceModel(
            id: 'wos-007',
            workOrderId: 'wo-005',
            serviceId: 'svc-003',
            quantity: 1,
            priceAtOrder: 30000,
            subtotal: 30000,
          ),
        ],
        productModels: const [],
        createdAt: now.subtract(const Duration(hours: 1, minutes: 30)),
        updatedAt: now.subtract(const Duration(minutes: 1)),
        completedAt: now.subtract(const Duration(minutes: 1)),
      ),

      // Work Order 6 - Paid
      WorkOrderModel(
        id: 'wo-006',
        workOrderCode:
            'WO-${now.year}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}-006',
        customerId: 'cust-006',
        vehicleDataId: 'veh-006',
        queueNumber: '6',
        estimatedTime: '20 menit',
        status: 'paid',
        paymentStatus: 'paid',
        paymentMethod: 'cash',
        paidAmount: 18000,
        totalPrice: 18000,
        serviceModels: [
          const WorkOrderServiceModel(
            id: 'wos-008',
            workOrderId: 'wo-006',
            serviceId: 'svc-001',
            quantity: 1,
            priceAtOrder: 15000,
            subtotal: 15000,
          ),
        ],
        productModels: [
          const WorkOrderProductModel(
            id: 'wop-007',
            workOrderId: 'wo-006',
            productId: 'prod-003',
            quantity: 1,
            priceAtOrder: 3000,
            subtotal: 3000,
          ),
        ],
        createdAt: now.subtract(const Duration(hours: 2)),
        updatedAt: now.subtract(const Duration(hours: 1, minutes: 30)),
        completedAt: now.subtract(const Duration(hours: 1, minutes: 30)),
      ),

      // Work Order 7 - Queued
      WorkOrderModel(
        id: 'wo-007',
        workOrderCode:
            'WO-${now.year}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}-007',
        customerId: 'cust-007',
        vehicleDataId: 'veh-007',
        queueNumber: '7',
        estimatedTime: '45 menit',
        status: 'queued',
        paymentStatus: 'pending',
        paymentMethod: null,
        paidAmount: 0,
        totalPrice: 80000,
        serviceModels: [
          const WorkOrderServiceModel(
            id: 'wos-009',
            workOrderId: 'wo-007',
            serviceId: 'svc-004',
            quantity: 1,
            priceAtOrder: 40000,
            subtotal: 40000,
          ),
          const WorkOrderServiceModel(
            id: 'wos-010',
            workOrderId: 'wo-007',
            serviceId: 'svc-002',
            quantity: 1,
            priceAtOrder: 25000,
            subtotal: 25000,
          ),
        ],
        productModels: [
          const WorkOrderProductModel(
            id: 'wop-008',
            workOrderId: 'wo-007',
            productId: 'prod-001',
            quantity: 2,
            priceAtOrder: 5000,
            subtotal: 10000,
          ),
          const WorkOrderProductModel(
            id: 'wop-009',
            workOrderId: 'wo-007',
            productId: 'prod-002',
            quantity: 1,
            priceAtOrder: 8000,
            subtotal: 8000,
          ),
        ],
        createdAt: now.subtract(const Duration(minutes: 5)),
        updatedAt: now.subtract(const Duration(minutes: 5)),
        completedAt: null,
      ),

      // Work Order 8 - Queued
      WorkOrderModel(
        id: 'wo-008',
        workOrderCode:
            'WO-${now.year}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}-008',
        customerId: 'cust-008',
        vehicleDataId: 'veh-008',
        queueNumber: '8',
        estimatedTime: '20 menit',
        status: 'queued',
        paymentStatus: 'pending',
        paymentMethod: null,
        paidAmount: 0,
        totalPrice: 15000,
        serviceModels: [
          const WorkOrderServiceModel(
            id: 'wos-011',
            workOrderId: 'wo-008',
            serviceId: 'svc-001',
            quantity: 1,
            priceAtOrder: 15000,
            subtotal: 15000,
          ),
        ],
        productModels: const [],
        createdAt: now.subtract(const Duration(minutes: 2)),
        updatedAt: now.subtract(const Duration(minutes: 2)),
        completedAt: null,
      ),
    ];
  }
}

@freezed
abstract class WorkOrderDataModel with _$WorkOrderDataModel {
  const factory WorkOrderDataModel({
    @JsonKey(name: "workOrders") required List<WorkOrderModel> workOrders,
    @JsonKey(name: "total") required int total,
  }) = _WorkOrderDataModel;

  factory WorkOrderDataModel.fromJson(Map<String, dynamic> json) =>
      _$WorkOrderDataModelFromJson(json);
}
