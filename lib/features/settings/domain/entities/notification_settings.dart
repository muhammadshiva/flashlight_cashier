/// Domain Entity for Notification Settings
class NotificationSettings {
  final bool enableNotifications;
  final bool enableSoundAlerts;
  final bool notifyOnLowStock;
  final bool notifyOnNewOrder;
  final bool notifyOnPaymentReceived;

  const NotificationSettings({
    required this.enableNotifications,
    required this.enableSoundAlerts,
    required this.notifyOnLowStock,
    required this.notifyOnNewOrder,
    required this.notifyOnPaymentReceived,
  });

  factory NotificationSettings.initial() {
    return const NotificationSettings(
      enableNotifications: true,
      enableSoundAlerts: true,
      notifyOnLowStock: true,
      notifyOnNewOrder: true,
      notifyOnPaymentReceived: true,
    );
  }

  NotificationSettings copyWith({
    bool? enableNotifications,
    bool? enableSoundAlerts,
    bool? notifyOnLowStock,
    bool? notifyOnNewOrder,
    bool? notifyOnPaymentReceived,
  }) {
    return NotificationSettings(
      enableNotifications: enableNotifications ?? this.enableNotifications,
      enableSoundAlerts: enableSoundAlerts ?? this.enableSoundAlerts,
      notifyOnLowStock: notifyOnLowStock ?? this.notifyOnLowStock,
      notifyOnNewOrder: notifyOnNewOrder ?? this.notifyOnNewOrder,
      notifyOnPaymentReceived: notifyOnPaymentReceived ?? this.notifyOnPaymentReceived,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NotificationSettings &&
        other.enableNotifications == enableNotifications &&
        other.enableSoundAlerts == enableSoundAlerts &&
        other.notifyOnLowStock == notifyOnLowStock &&
        other.notifyOnNewOrder == notifyOnNewOrder &&
        other.notifyOnPaymentReceived == notifyOnPaymentReceived;
  }

  @override
  int get hashCode {
    return Object.hash(
      enableNotifications,
      enableSoundAlerts,
      notifyOnLowStock,
      notifyOnNewOrder,
      notifyOnPaymentReceived,
    );
  }
}
