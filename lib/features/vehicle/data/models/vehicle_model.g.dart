// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_VehicleModel _$VehicleModelFromJson(Map<String, dynamic> json) =>
    _VehicleModel(
      id: json['id'] as String,
      customerId: json['customerId'] as String?,
      licensePlate: json['licensePlate'] as String,
      model: json['model'] as String?,
      vehicleBrand: json['vehicleBrand'] as String?,
      vehicleColor: json['vehicleColor'] as String?,
      category: json['category'] as String?,
      vehicleCategory: json['vehicleCategory'] as String?,
      vehicleSpecs: json['vehicleSpecs'] as String?,
    );

Map<String, dynamic> _$VehicleModelToJson(_VehicleModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'customerId': instance.customerId,
      'licensePlate': instance.licensePlate,
      'model': instance.model,
      'vehicleBrand': instance.vehicleBrand,
      'vehicleColor': instance.vehicleColor,
      'category': instance.category,
      'vehicleCategory': instance.vehicleCategory,
      'vehicleSpecs': instance.vehicleSpecs,
    };
