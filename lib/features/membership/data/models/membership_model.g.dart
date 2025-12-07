// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'membership_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MembershipModel _$MembershipModelFromJson(Map<String, dynamic> json) =>
    _MembershipModel(
      id: json['id'] as String,
      customerId: json['customerId'] as String,
      membershipType: json['membershipType'] as String,
      membershipLevel: json['membershipLevel'] as String,
      isActive: json['isActive'] as bool,
    );

Map<String, dynamic> _$MembershipModelToJson(_MembershipModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'customerId': instance.customerId,
      'membershipType': instance.membershipType,
      'membershipLevel': instance.membershipLevel,
      'isActive': instance.isActive,
    };
