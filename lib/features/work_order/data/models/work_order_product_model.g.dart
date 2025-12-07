// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'work_order_product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WorkOrderProductModel _$WorkOrderProductModelFromJson(
        Map<String, dynamic> json) =>
    _WorkOrderProductModel(
      id: json['id'] as String,
      workOrderId: json['workOrderId'] as String,
      productId: json['productId'] as String,
      quantity: (json['quantity'] as num).toInt(),
      priceAtOrder: (json['priceAtOrder'] as num).toInt(),
      subtotal: (json['subtotal'] as num).toInt(),
      productModel: json['product'] == null
          ? null
          : ProductModel.fromJson(json['product'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WorkOrderProductModelToJson(
        _WorkOrderProductModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'workOrderId': instance.workOrderId,
      'productId': instance.productId,
      'quantity': instance.quantity,
      'priceAtOrder': instance.priceAtOrder,
      'subtotal': instance.subtotal,
      'product': instance.productModel,
    };
