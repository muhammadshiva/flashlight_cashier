// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_settings_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NotificationSettingsModel _$NotificationSettingsModelFromJson(
        Map<String, dynamic> json) =>
    _NotificationSettingsModel(
      enableNotifications: json['enableNotifications'] as bool,
      enableSoundAlerts: json['enableSoundAlerts'] as bool,
      notifyOnLowStock: json['notifyOnLowStock'] as bool,
      notifyOnNewOrder: json['notifyOnNewOrder'] as bool,
      notifyOnPaymentReceived: json['notifyOnPaymentReceived'] as bool,
    );

Map<String, dynamic> _$NotificationSettingsModelToJson(
        _NotificationSettingsModel instance) =>
    <String, dynamic>{
      'enableNotifications': instance.enableNotifications,
      'enableSoundAlerts': instance.enableSoundAlerts,
      'notifyOnLowStock': instance.notifyOnLowStock,
      'notifyOnNewOrder': instance.notifyOnNewOrder,
      'notifyOnPaymentReceived': instance.notifyOnPaymentReceived,
    };
