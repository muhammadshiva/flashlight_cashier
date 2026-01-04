// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'work_order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WorkOrderModel _$WorkOrderModelFromJson(Map<String, dynamic> json) =>
    _WorkOrderModel(
      id: json['id'] as String,
      workOrderCode: json['workOrderCode'] as String,
      customerId: json['customerId'] as String,
      vehicleDataId: json['vehicleDataId'] as String,
      queueNumber: json['queueNumber'] as String,
      estimatedTime: json['estimatedTime'] as String,
      status: json['status'] as String,
      paymentStatus: json['paymentStatus'] as String?,
      paymentMethod: json['paymentMethod'] as String?,
      paidAmount: (json['paidAmount'] as num?)?.toInt() ?? 0,
      totalPrice: (json['totalPrice'] as num).toInt(),
      serviceModels: (json['services'] as List<dynamic>?)
              ?.map((e) =>
                  WorkOrderServiceModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      productModels: (json['products'] as List<dynamic>?)
              ?.map((e) =>
                  WorkOrderProductModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      completedAt: json['completedAt'] == null
          ? null
          : DateTime.parse(json['completedAt'] as String),
    );

Map<String, dynamic> _$WorkOrderModelToJson(_WorkOrderModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'workOrderCode': instance.workOrderCode,
      'customerId': instance.customerId,
      'vehicleDataId': instance.vehicleDataId,
      'queueNumber': instance.queueNumber,
      'estimatedTime': instance.estimatedTime,
      'status': instance.status,
      'paymentStatus': instance.paymentStatus,
      'paymentMethod': instance.paymentMethod,
      'paidAmount': instance.paidAmount,
      'totalPrice': instance.totalPrice,
      'services': instance.serviceModels.map((e) => e.toJson()).toList(),
      'products': instance.productModels.map((e) => e.toJson()).toList(),
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'completedAt': instance.completedAt?.toIso8601String(),
    };

_WorkOrderResponseModel _$WorkOrderResponseModelFromJson(
        Map<String, dynamic> json) =>
    _WorkOrderResponseModel(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: WorkOrderDataModel.fromJson(json['data'] as Map<String, dynamic>),
      errorCode: (json['error_code'] as num).toInt(),
    );

Map<String, dynamic> _$WorkOrderResponseModelToJson(
        _WorkOrderResponseModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
      'error_code': instance.errorCode,
    };

_WorkOrderDataModel _$WorkOrderDataModelFromJson(Map<String, dynamic> json) =>
    _WorkOrderDataModel(
      workOrders: (json['data'] as List<dynamic>)
          .map((e) => WorkOrderModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      total: (json['total'] as num).toInt(),
    );

Map<String, dynamic> _$WorkOrderDataModelToJson(_WorkOrderDataModel instance) =>
    <String, dynamic>{
      'data': instance.workOrders,
      'total': instance.total,
    };
