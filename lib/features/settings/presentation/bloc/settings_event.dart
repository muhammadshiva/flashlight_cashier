part of 'settings_bloc.dart';

@freezed
class SettingsEvent with _$SettingsEvent {
  // Initial Load
  const factory SettingsEvent.loadSettings() = LoadSettings;

  // App Settings (Store Info + POS Settings)
  const factory SettingsEvent.updateStoreInfo({
    String? storeName,
    String? storeAddress,
    String? storePhone,
    String? storeEmail,
  }) = UpdateStoreInfo;

  const factory SettingsEvent.updatePOSSettings({
    double? taxRate,
    bool? autoCalculateTax,
  }) = UpdatePOSSettings;

  // Printer Events
  const factory SettingsEvent.toggleBluetooth({
    required bool enable,
  }) = ToggleBluetooth;

  const factory SettingsEvent.scanPrinters() = ScanPrintersEvent;

  const factory SettingsEvent.connectPrinter({
    required PrinterDevice device,
  }) = ConnectPrinterEvent;

  const factory SettingsEvent.disconnectPrinter() = DisconnectPrinterEvent;

  const factory SettingsEvent.updatePrinterSettings({
    required PrinterSettings settings,
  }) = UpdatePrinterSettingsEvent;

  // Receipt Events
  const factory SettingsEvent.updateReceiptSettings({
    required ReceiptSettings settings,
  }) = UpdateReceiptSettingsEvent;

  // Notification Events
  const factory SettingsEvent.updateNotificationSettings({
    required NotificationSettings settings,
  }) = UpdateNotificationSettingsEvent;

  // Security Events
  const factory SettingsEvent.updateSecuritySettings({
    required SecuritySettings settings,
  }) = UpdateSecuritySettingsEvent;
}
