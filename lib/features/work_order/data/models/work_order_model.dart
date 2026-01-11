import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../../domain/entities/work_order.dart';
import 'work_order_product_model.dart';
import 'work_order_service_model.dart';

WorkOrderModel workOrderModelFromJson(String str) =>
    WorkOrderModel.fromJson(json.decode(str));

String workOrderModelToJson(WorkOrderModel data) => json.encode(data.toJson());

class WorkOrderModel extends Equatable {
  final String id;
  final String workOrderCode;
  final String customerId;
  final String vehicleDataId;
  final String queueNumber;
  final String estimatedTime;
  final String status;
  final String? paymentStatus;
  final String? paymentMethod;
  final int paidAmount;
  final int totalPrice;
  final List<WorkOrderServiceModel> serviceModels;
  final List<WorkOrderProductModel> productModels;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? completedAt;

  const WorkOrderModel({
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
    this.serviceModels = const [],
    this.productModels = const [],
    this.createdAt,
    this.updatedAt,
    this.completedAt,
  });

  factory WorkOrderModel.fromJson(Map<String, dynamic> json) =>
      WorkOrderModel(
        id: json["id"] as String,
        workOrderCode: json["workOrderCode"] as String,
        customerId: json["customerId"] as String,
        vehicleDataId: json["vehicleDataId"] as String,
        queueNumber: json["queueNumber"] as String,
        estimatedTime: json["estimatedTime"] as String,
        status: json["status"] as String,
        paymentStatus: json["paymentStatus"] as String?,
        paymentMethod: json["paymentMethod"] as String?,
        paidAmount: json["paidAmount"] as int? ?? 0,
        totalPrice: json["totalPrice"] as int,
        serviceModels: json["services"] != null
            ? (json["services"] as List)
                .map((e) => WorkOrderServiceModel.fromJson(e as Map<String, dynamic>))
                .toList()
            : const [],
        productModels: json["products"] != null
            ? (json["products"] as List)
                .map((e) => WorkOrderProductModel.fromJson(e as Map<String, dynamic>))
                .toList()
            : const [],
        createdAt: json["createdAt"] != null
            ? DateTime.parse(json["createdAt"] as String)
            : null,
        updatedAt: json["updatedAt"] != null
            ? DateTime.parse(json["updatedAt"] as String)
            : null,
        completedAt: json["completedAt"] != null
            ? DateTime.parse(json["completedAt"] as String)
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "workOrderCode": workOrderCode,
        "customerId": customerId,
        "vehicleDataId": vehicleDataId,
        "queueNumber": queueNumber,
        "estimatedTime": estimatedTime,
        "status": status,
        if (paymentStatus != null) "paymentStatus": paymentStatus,
        if (paymentMethod != null) "paymentMethod": paymentMethod,
        "paidAmount": paidAmount,
        "totalPrice": totalPrice,
        "services": serviceModels.map((e) => e.toJson()).toList(),
        "products": productModels.map((e) => e.toJson()).toList(),
        if (createdAt != null) "createdAt": createdAt!.toIso8601String(),
        if (updatedAt != null) "updatedAt": updatedAt!.toIso8601String(),
        if (completedAt != null) "completedAt": completedAt!.toIso8601String(),
      };

  WorkOrderModel copyWith({
    String? id,
    String? workOrderCode,
    String? customerId,
    String? vehicleDataId,
    String? queueNumber,
    String? estimatedTime,
    String? status,
    String? paymentStatus,
    String? paymentMethod,
    int? paidAmount,
    int? totalPrice,
    List<WorkOrderServiceModel>? serviceModels,
    List<WorkOrderProductModel>? productModels,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? completedAt,
  }) {
    return WorkOrderModel(
      id: id ?? this.id,
      workOrderCode: workOrderCode ?? this.workOrderCode,
      customerId: customerId ?? this.customerId,
      vehicleDataId: vehicleDataId ?? this.vehicleDataId,
      queueNumber: queueNumber ?? this.queueNumber,
      estimatedTime: estimatedTime ?? this.estimatedTime,
      status: status ?? this.status,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      paidAmount: paidAmount ?? this.paidAmount,
      totalPrice: totalPrice ?? this.totalPrice,
      serviceModels: serviceModels ?? this.serviceModels,
      productModels: productModels ?? this.productModels,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      completedAt: completedAt ?? this.completedAt,
    );
  }

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
        serviceModels,
        productModels,
        createdAt,
        updatedAt,
        completedAt,
      ];
}

class WorkOrderResponseModel extends Equatable {
  final bool success;
  final String message;
  final WorkOrderDataModel data;
  final int errorCode;

  const WorkOrderResponseModel({
    required this.success,
    required this.message,
    required this.data,
    required this.errorCode,
  });

  factory WorkOrderResponseModel.fromJson(Map<String, dynamic> json) =>
      WorkOrderResponseModel(
        success: json["success"] as bool,
        message: json["message"] as String,
        data: WorkOrderDataModel.fromJson(json["data"] as Map<String, dynamic>),
        errorCode: json["error_code"] as int,
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data.toJson(),
        "error_code": errorCode,
      };

  WorkOrderResponseModel copyWith({
    bool? success,
    String? message,
    WorkOrderDataModel? data,
    int? errorCode,
  }) {
    return WorkOrderResponseModel(
      success: success ?? this.success,
      message: message ?? this.message,
      data: data ?? this.data,
      errorCode: errorCode ?? this.errorCode,
    );
  }

  @override
  List<Object?> get props => [success, message, data, errorCode];

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
        serviceModels: const [
          WorkOrderServiceModel(
            id: 'wos-001',
            workOrderId: 'wo-001',
            serviceId: 'svc-002',
            quantity: 1,
            priceAtOrder: 25000,
            subtotal: 25000,
          ),
          WorkOrderServiceModel(
            id: 'wos-002',
            workOrderId: 'wo-001',
            serviceId: 'svc-003',
            quantity: 1,
            priceAtOrder: 30000,
            subtotal: 30000,
          ),
        ],
        productModels: const [
          WorkOrderProductModel(
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
        serviceModels: const [
          WorkOrderServiceModel(
            id: 'wos-003',
            workOrderId: 'wo-002',
            serviceId: 'svc-001',
            quantity: 1,
            priceAtOrder: 15000,
            subtotal: 15000,
          ),
        ],
        productModels: const [
          WorkOrderProductModel(
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
        serviceModels: const [
          WorkOrderServiceModel(
            id: 'wos-004',
            workOrderId: 'wo-003',
            serviceId: 'svc-004',
            quantity: 1,
            priceAtOrder: 40000,
            subtotal: 40000,
          ),
        ],
        productModels: const [
          WorkOrderProductModel(
            id: 'wop-003',
            workOrderId: 'wo-003',
            productId: 'prod-002',
            quantity: 1,
            priceAtOrder: 8000,
            subtotal: 8000,
          ),
          WorkOrderProductModel(
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
        serviceModels: const [
          WorkOrderServiceModel(
            id: 'wos-005',
            workOrderId: 'wo-004',
            serviceId: 'svc-005',
            quantity: 1,
            priceAtOrder: 75000,
            subtotal: 75000,
          ),
        ],
        productModels: const [
          WorkOrderProductModel(
            id: 'wop-005',
            workOrderId: 'wo-004',
            productId: 'prod-001',
            quantity: 1,
            priceAtOrder: 5000,
            subtotal: 5000,
          ),
          WorkOrderProductModel(
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
        serviceModels: const [
          WorkOrderServiceModel(
            id: 'wos-006',
            workOrderId: 'wo-005',
            serviceId: 'svc-002',
            quantity: 1,
            priceAtOrder: 25000,
            subtotal: 25000,
          ),
          WorkOrderServiceModel(
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
        serviceModels: const [
          WorkOrderServiceModel(
            id: 'wos-008',
            workOrderId: 'wo-006',
            serviceId: 'svc-001',
            quantity: 1,
            priceAtOrder: 15000,
            subtotal: 15000,
          ),
        ],
        productModels: const [
          WorkOrderProductModel(
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
        serviceModels: const [
          WorkOrderServiceModel(
            id: 'wos-009',
            workOrderId: 'wo-007',
            serviceId: 'svc-004',
            quantity: 1,
            priceAtOrder: 40000,
            subtotal: 40000,
          ),
          WorkOrderServiceModel(
            id: 'wos-010',
            workOrderId: 'wo-007',
            serviceId: 'svc-002',
            quantity: 1,
            priceAtOrder: 25000,
            subtotal: 25000,
          ),
        ],
        productModels: const [
          WorkOrderProductModel(
            id: 'wop-008',
            workOrderId: 'wo-007',
            productId: 'prod-001',
            quantity: 2,
            priceAtOrder: 5000,
            subtotal: 10000,
          ),
          WorkOrderProductModel(
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
        serviceModels: const [
          WorkOrderServiceModel(
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

class WorkOrderDataModel extends Equatable {
  final List<WorkOrderModel> workOrders;
  final int total;

  const WorkOrderDataModel({
    required this.workOrders,
    required this.total,
  });

  factory WorkOrderDataModel.fromJson(Map<String, dynamic> json) =>
      WorkOrderDataModel(
        workOrders: (json["data"] as List)
            .map((e) => WorkOrderModel.fromJson(e as Map<String, dynamic>))
            .toList(),
        total: json["total"] as int,
      );

  Map<String, dynamic> toJson() => {
        "data": workOrders.map((e) => e.toJson()).toList(),
        "total": total,
      };

  WorkOrderDataModel copyWith({
    List<WorkOrderModel>? workOrders,
    int? total,
  }) {
    return WorkOrderDataModel(
      workOrders: workOrders ?? this.workOrders,
      total: total ?? this.total,
    );
  }

  @override
  List<Object?> get props => [workOrders, total];
}
