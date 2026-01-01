// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/notification_settings.dart';

part 'notification_settings_model.freezed.dart';
part 'notification_settings_model.g.dart';

@freezed
abstract class NotificationSettingsModel with _$NotificationSettingsModel {
  const NotificationSettingsModel._();

  const factory NotificationSettingsModel({
    @JsonKey(name: "enableNotifications") required bool enableNotifications,
    @JsonKey(name: "enableSoundAlerts") required bool enableSoundAlerts,
    @JsonKey(name: "notifyOnLowStock") required bool notifyOnLowStock,
    @JsonKey(name: "notifyOnNewOrder") required bool notifyOnNewOrder,
    @JsonKey(name: "notifyOnPaymentReceived") required bool notifyOnPaymentReceived,
  }) = _NotificationSettingsModel;

  factory NotificationSettingsModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationSettingsModelFromJson(json);

  factory NotificationSettingsModel.fromEntity(NotificationSettings entity) {
    return NotificationSettingsModel(
      enableNotifications: entity.enableNotifications,
      enableSoundAlerts: entity.enableSoundAlerts,
      notifyOnLowStock: entity.notifyOnLowStock,
      notifyOnNewOrder: entity.notifyOnNewOrder,
      notifyOnPaymentReceived: entity.notifyOnPaymentReceived,
    );
  }

  NotificationSettings toEntity() => NotificationSettings(
        enableNotifications: enableNotifications,
        enableSoundAlerts: enableSoundAlerts,
        notifyOnLowStock: notifyOnLowStock,
        notifyOnNewOrder: notifyOnNewOrder,
        notifyOnPaymentReceived: notifyOnPaymentReceived,
      );
}
