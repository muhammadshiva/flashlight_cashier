// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_VehicleModel _$VehicleModelFromJson(Map<String, dynamic> json) =>
    _VehicleModel(
      id: json['id'] as String,
      licensePlate: json['licensePlate'] as String,
      vehicleBrand: json['vehicleBrand'] as String,
      vehicleColor: json['vehicleColor'] as String,
      vehicleCategory: json['vehicleCategory'] as String,
      vehicleSpecs: json['vehicleSpecs'] as String,
    );

Map<String, dynamic> _$VehicleModelToJson(_VehicleModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'licensePlate': instance.licensePlate,
      'vehicleBrand': instance.vehicleBrand,
      'vehicleColor': instance.vehicleColor,
      'vehicleCategory': instance.vehicleCategory,
      'vehicleSpecs': instance.vehicleSpecs,
    };
