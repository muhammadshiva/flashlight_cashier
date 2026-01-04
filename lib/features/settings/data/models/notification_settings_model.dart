import 'package:equatable/equatable.dart';

import '../../domain/entities/notification_settings.dart';

/// Notification Settings Model
///
/// Data layer model for notification settings with JSON serialization
/// Uses manual implementation without Freezed code generation
class NotificationSettingsModel extends Equatable {
  final bool enableNotifications;
  final bool enableSoundAlerts;
  final bool notifyOnLowStock;
  final bool notifyOnNewOrder;
  final bool notifyOnPaymentReceived;

  const NotificationSettingsModel({
    required this.enableNotifications,
    required this.enableSoundAlerts,
    required this.notifyOnLowStock,
    required this.notifyOnNewOrder,
    required this.notifyOnPaymentReceived,
  });

  /// Create model from JSON
  factory NotificationSettingsModel.fromJson(Map<String, dynamic> json) {
    return NotificationSettingsModel(
      enableNotifications: json['enableNotifications'] as bool,
      enableSoundAlerts: json['enableSoundAlerts'] as bool,
      notifyOnLowStock: json['notifyOnLowStock'] as bool,
      notifyOnNewOrder: json['notifyOnNewOrder'] as bool,
      notifyOnPaymentReceived: json['notifyOnPaymentReceived'] as bool,
    );
  }

  /// Convert model to JSON
  Map<String, dynamic> toJson() {
    return {
      'enableNotifications': enableNotifications,
      'enableSoundAlerts': enableSoundAlerts,
      'notifyOnLowStock': notifyOnLowStock,
      'notifyOnNewOrder': notifyOnNewOrder,
      'notifyOnPaymentReceived': notifyOnPaymentReceived,
    };
  }

  /// Create model from domain entity
  factory NotificationSettingsModel.fromEntity(NotificationSettings entity) {
    return NotificationSettingsModel(
      enableNotifications: entity.enableNotifications,
      enableSoundAlerts: entity.enableSoundAlerts,
      notifyOnLowStock: entity.notifyOnLowStock,
      notifyOnNewOrder: entity.notifyOnNewOrder,
      notifyOnPaymentReceived: entity.notifyOnPaymentReceived,
    );
  }

  /// Convert model to domain entity
  NotificationSettings toEntity() {
    return NotificationSettings(
      enableNotifications: enableNotifications,
      enableSoundAlerts: enableSoundAlerts,
      notifyOnLowStock: notifyOnLowStock,
      notifyOnNewOrder: notifyOnNewOrder,
      notifyOnPaymentReceived: notifyOnPaymentReceived,
    );
  }

  /// Create a copy with updated fields
  NotificationSettingsModel copyWith({
    bool? enableNotifications,
    bool? enableSoundAlerts,
    bool? notifyOnLowStock,
    bool? notifyOnNewOrder,
    bool? notifyOnPaymentReceived,
  }) {
    return NotificationSettingsModel(
      enableNotifications: enableNotifications ?? this.enableNotifications,
      enableSoundAlerts: enableSoundAlerts ?? this.enableSoundAlerts,
      notifyOnLowStock: notifyOnLowStock ?? this.notifyOnLowStock,
      notifyOnNewOrder: notifyOnNewOrder ?? this.notifyOnNewOrder,
      notifyOnPaymentReceived: notifyOnPaymentReceived ?? this.notifyOnPaymentReceived,
    );
  }

  @override
  List<Object?> get props => [
        enableNotifications,
        enableSoundAlerts,
        notifyOnLowStock,
        notifyOnNewOrder,
        notifyOnPaymentReceived,
      ];
}
