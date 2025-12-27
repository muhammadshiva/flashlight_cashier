// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_adjustment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_StockAdjustmentModel _$StockAdjustmentModelFromJson(
        Map<String, dynamic> json) =>
    _StockAdjustmentModel(
      productId: json['product_id'] as String,
      quantity: (json['quantity'] as num).toInt(),
      type: json['type'] as String,
      reason: json['reason'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$StockAdjustmentModelToJson(
        _StockAdjustmentModel instance) =>
    <String, dynamic>{
      'product_id': instance.productId,
      'quantity': instance.quantity,
      'type': instance.type,
      'reason': instance.reason,
      'timestamp': instance.timestamp.toIso8601String(),
    };
