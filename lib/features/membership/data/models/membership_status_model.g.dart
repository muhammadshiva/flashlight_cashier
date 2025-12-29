// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'membership_status_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MembershipStatusModel _$MembershipStatusModelFromJson(
        Map<String, dynamic> json) =>
    _MembershipStatusModel(
      type: json['type'] as String,
      message: json['message'] as String,
      membershipLevel: json['membershipLevel'] as String?,
      isLoading: json['isLoading'] as bool,
    );

Map<String, dynamic> _$MembershipStatusModelToJson(
        _MembershipStatusModel instance) =>
    <String, dynamic>{
      'type': instance.type,
      'message': instance.message,
      'membershipLevel': instance.membershipLevel,
      'isLoading': instance.isLoading,
    };
