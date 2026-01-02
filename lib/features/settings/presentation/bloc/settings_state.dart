part of 'settings_bloc.dart';

enum SettingsStatus {
  initial,
  loading,
  success,
  failure,
}

@freezed
class SettingsState with _$SettingsState {
  const factory SettingsState({
    // App Settings (Store Info, POS, Language, Display)
    @AppSettingsConverter() required AppSettings appSettings,

    // Printer Settings
    @PrinterSettingsConverter() required PrinterSettings printerSettings,
    @PrinterDeviceListConverter() @Default([]) List<PrinterDevice> availablePrinters,
    @Default(false) bool isScanningPrinters,
    @Default(false) bool isConnectingPrinter,
    @Default(false) bool isTogglingBluetooth,

    // Receipt Settings
    @ReceiptSettingsConverter() required ReceiptSettings receiptSettings,

    // Notification Settings
    @NotificationSettingsConverter() required NotificationSettings notificationSettings,

    // Security Settings
    @SecuritySettingsConverter() required SecuritySettings securitySettings,

    // General Status
    @Default(SettingsStatus.initial) SettingsStatus status,
    String? errorMessage,
  }) = _SettingsState;

  factory SettingsState.initial() => SettingsState(
        appSettings: AppSettings.initial(),
        printerSettings: PrinterSettings.initial(),
        receiptSettings: ReceiptSettings.initial(),
        notificationSettings: NotificationSettings.initial(),
        securitySettings: SecuritySettings.initial(),
      );

  factory SettingsState.fromJson(Map<String, dynamic> json) => _$SettingsStateFromJson(json);

  @override
  // TODO: implement appSettings
  AppSettings get appSettings => throw UnimplementedError();

  @override
  // TODO: implement availablePrinters
  List<PrinterDevice> get availablePrinters => throw UnimplementedError();

  @override
  // TODO: implement errorMessage
  String? get errorMessage => throw UnimplementedError();

  @override
  // TODO: implement isConnectingPrinter
  bool get isConnectingPrinter => throw UnimplementedError();

  @override
  // TODO: implement isScanningPrinters
  bool get isScanningPrinters => throw UnimplementedError();

  @override
  // TODO: implement isTogglingBluetooth
  bool get isTogglingBluetooth => throw UnimplementedError();

  @override
  // TODO: implement notificationSettings
  NotificationSettings get notificationSettings => throw UnimplementedError();

  @override
  // TODO: implement printerSettings
  PrinterSettings get printerSettings => throw UnimplementedError();

  @override
  // TODO: implement receiptSettings
  ReceiptSettings get receiptSettings => throw UnimplementedError();

  @override
  // TODO: implement securitySettings
  SecuritySettings get securitySettings => throw UnimplementedError();

  @override
  // TODO: implement status
  SettingsStatus get status => throw UnimplementedError();

  @override
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }
}
