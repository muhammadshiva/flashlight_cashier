// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'work_order_service_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WorkOrderServiceModel _$WorkOrderServiceModelFromJson(
        Map<String, dynamic> json) =>
    _WorkOrderServiceModel(
      id: json['id'] as String,
      workOrderId: json['workOrderId'] as String,
      serviceId: json['serviceId'] as String,
      quantity: (json['quantity'] as num).toInt(),
      priceAtOrder: (json['priceAtOrder'] as num).toInt(),
      subtotal: (json['subtotal'] as num).toInt(),
      serviceModel: json['service'] == null
          ? null
          : ServiceModel.fromJson(json['service'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WorkOrderServiceModelToJson(
        _WorkOrderServiceModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'workOrderId': instance.workOrderId,
      'serviceId': instance.serviceId,
      'quantity': instance.quantity,
      'priceAtOrder': instance.priceAtOrder,
      'subtotal': instance.subtotal,
      'service': instance.serviceModel,
    };
