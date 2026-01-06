part of 'settings_bloc.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object?> get props => [];
}

// Initial Load
class LoadSettings extends SettingsEvent {
  const LoadSettings();
}

// App Settings (Store Info + POS Settings)
class UpdateStoreInfo extends SettingsEvent {
  final String? storeName;
  final String? storeAddress;
  final String? storePhone;
  final String? storeEmail;

  const UpdateStoreInfo({
    this.storeName,
    this.storeAddress,
    this.storePhone,
    this.storeEmail,
  });

  @override
  List<Object?> get props => [storeName, storeAddress, storePhone, storeEmail];
}

class UpdatePOSSettings extends SettingsEvent {
  final double? taxRate;
  final bool? autoCalculateTax;
  final bool? autoPrintReceipt;
  final String? currencyCode;
  final int? decimalPlaces;

  const UpdatePOSSettings({
    this.taxRate,
    this.autoCalculateTax,
    this.autoPrintReceipt,
    this.currencyCode,
    this.decimalPlaces,
  });

  @override
  List<Object?> get props =>
      [taxRate, autoCalculateTax, autoPrintReceipt, currencyCode, decimalPlaces];
}

// Language Settings Events
class UpdateLanguageSettings extends SettingsEvent {
  final String? language;

  const UpdateLanguageSettings({
    this.language,
  });

  @override
  List<Object?> get props => [language];
}

// Printer Events
class ToggleBluetooth extends SettingsEvent {
  final bool enable;

  const ToggleBluetooth({required this.enable});

  @override
  List<Object?> get props => [enable];
}

class ScanPrintersEvent extends SettingsEvent {
  const ScanPrintersEvent();
}

class ConnectPrinterEvent extends SettingsEvent {
  final PrinterDevice device;

  const ConnectPrinterEvent({required this.device});

  @override
  List<Object?> get props => [device];
}

class DisconnectPrinterEvent extends SettingsEvent {
  const DisconnectPrinterEvent();
}

class UpdatePrinterSettingsEvent extends SettingsEvent {
  final PrinterSettings settings;

  const UpdatePrinterSettingsEvent({required this.settings});

  @override
  List<Object?> get props => [settings];
}

// Receipt Events
class UpdateReceiptSettingsEvent extends SettingsEvent {
  final ReceiptSettings settings;

  const UpdateReceiptSettingsEvent({required this.settings});

  @override
  List<Object?> get props => [settings];
}

// Notification Events
class UpdateNotificationSettingsEvent extends SettingsEvent {
  final NotificationSettings settings;

  const UpdateNotificationSettingsEvent({required this.settings});

  @override
  List<Object?> get props => [settings];
}

// Security Events
class UpdateSecuritySettingsEvent extends SettingsEvent {
  final SecuritySettings settings;

  const UpdateSecuritySettingsEvent({required this.settings});

  @override
  List<Object?> get props => [settings];
}
