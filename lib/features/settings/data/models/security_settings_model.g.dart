// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'security_settings_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SecuritySettingsModel _$SecuritySettingsModelFromJson(
        Map<String, dynamic> json) =>
    _SecuritySettingsModel(
      requirePinForRefund: json['requirePinForRefund'] as bool,
      requirePinForDiscount: json['requirePinForDiscount'] as bool,
      requirePinForVoid: json['requirePinForVoid'] as bool,
      autoLockAfterInactivity: json['autoLockAfterInactivity'] as bool,
      autoLockDurationMinutes: (json['autoLockDurationMinutes'] as num).toInt(),
    );

Map<String, dynamic> _$SecuritySettingsModelToJson(
        _SecuritySettingsModel instance) =>
    <String, dynamic>{
      'requirePinForRefund': instance.requirePinForRefund,
      'requirePinForDiscount': instance.requirePinForDiscount,
      'requirePinForVoid': instance.requirePinForVoid,
      'autoLockAfterInactivity': instance.autoLockAfterInactivity,
      'autoLockDurationMinutes': instance.autoLockDurationMinutes,
    };
