part of 'notification_settings_cubit.dart';

/// Notification Settings State
///
/// Combines UIStateModel for data state with separate UI loading flags
class NotificationSettingsState extends Equatable {
  /// Main notification settings data wrapped in UIStateModel
  final UIStateModel<NotificationSettings> data;

  /// UI loading states for individual toggles
  final bool isUpdatingNotifications;
  final bool isUpdatingSoundAlerts;
  final bool isUpdatingLowStock;
  final bool isUpdatingNewOrder;
  final bool isUpdatingPaymentReceived;

  const NotificationSettingsState({
    required this.data,
    this.isUpdatingNotifications = false,
    this.isUpdatingSoundAlerts = false,
    this.isUpdatingLowStock = false,
    this.isUpdatingNewOrder = false,
    this.isUpdatingPaymentReceived = false,
  });

  factory NotificationSettingsState.initial() => NotificationSettingsState(
        data: UIStateModel.success(data: NotificationSettings.initial()),
      );

  @override
  List<Object?> get props => [
        data,
        isUpdatingNotifications,
        isUpdatingSoundAlerts,
        isUpdatingLowStock,
        isUpdatingNewOrder,
        isUpdatingPaymentReceived,
      ];

  NotificationSettingsState copyWith({
    UIStateModel<NotificationSettings>? data,
    bool? isUpdatingNotifications,
    bool? isUpdatingSoundAlerts,
    bool? isUpdatingLowStock,
    bool? isUpdatingNewOrder,
    bool? isUpdatingPaymentReceived,
  }) {
    return NotificationSettingsState(
      data: data ?? this.data,
      isUpdatingNotifications: isUpdatingNotifications ?? this.isUpdatingNotifications,
      isUpdatingSoundAlerts: isUpdatingSoundAlerts ?? this.isUpdatingSoundAlerts,
      isUpdatingLowStock: isUpdatingLowStock ?? this.isUpdatingLowStock,
      isUpdatingNewOrder: isUpdatingNewOrder ?? this.isUpdatingNewOrder,
      isUpdatingPaymentReceived: isUpdatingPaymentReceived ?? this.isUpdatingPaymentReceived,
    );
  }
}
