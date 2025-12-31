// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member_vehicle_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MemberVehicleModel _$MemberVehicleModelFromJson(Map<String, dynamic> json) =>
    _MemberVehicleModel(
      id: json['id'] as String,
      membershipId: json['membershipId'] as String?,
      name: json['name'] as String,
      plateNumber: json['plateNumber'] as String,
      specs: json['specs'] as String?,
      icon: json['icon'] as String?,
    );

Map<String, dynamic> _$MemberVehicleModelToJson(_MemberVehicleModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'membershipId': instance.membershipId,
      'name': instance.name,
      'plateNumber': instance.plateNumber,
      'specs': instance.specs,
      'icon': instance.icon,
    };
