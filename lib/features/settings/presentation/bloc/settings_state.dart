part of 'settings_bloc.dart';

class SettingsState extends Equatable {
  // Main data wrapped in UIStateModel (persistent)
  final UIStateModel<SettingsData> data;

  // Transient UI states (not persisted, reset on app restart)
  final List<PrinterDevice> availablePrinters;
  final bool isScanningPrinters;
  final bool isConnectingPrinter;
  final bool isTogglingBluetooth;

  const SettingsState({
    required this.data,
    this.availablePrinters = const [],
    this.isScanningPrinters = false,
    this.isConnectingPrinter = false,
    this.isTogglingBluetooth = false,
  });

  factory SettingsState.initial() => SettingsState(
        data: UIStateModel.success(data: SettingsData.initial()),
      );

  @override
  List<Object?> get props => [
        data,
        availablePrinters,
        isScanningPrinters,
        isConnectingPrinter,
        isTogglingBluetooth,
      ];

  SettingsState copyWith({
    UIStateModel<SettingsData>? data,
    List<PrinterDevice>? availablePrinters,
    bool? isScanningPrinters,
    bool? isConnectingPrinter,
    bool? isTogglingBluetooth,
  }) {
    return SettingsState(
      data: data ?? this.data,
      availablePrinters: availablePrinters ?? this.availablePrinters,
      isScanningPrinters: isScanningPrinters ?? this.isScanningPrinters,
      isConnectingPrinter: isConnectingPrinter ?? this.isConnectingPrinter,
      isTogglingBluetooth: isTogglingBluetooth ?? this.isTogglingBluetooth,
    );
  }

  // Helper getters for easier access to nested data
  AppSettings? get appSettings => data.maybeWhen(
        success: (settingsData) => settingsData.appSettings,
        orElse: () => null,
      );

  PrinterSettings? get printerSettings => data.maybeWhen(
        success: (settingsData) => settingsData.printerSettings,
        orElse: () => null,
      );

  ReceiptSettings? get receiptSettings => data.maybeWhen(
        success: (settingsData) => settingsData.receiptSettings,
        orElse: () => null,
      );

  NotificationSettings? get notificationSettings => data.maybeWhen(
        success: (settingsData) => settingsData.notificationSettings,
        orElse: () => null,
      );

  SecuritySettings? get securitySettings => data.maybeWhen(
        success: (settingsData) => settingsData.securitySettings,
        orElse: () => null,
      );

  // Serialization for HydratedBloc
  Map<String, dynamic> toJson() {
    // Only persist success state data
    return data.maybeWhen(
      success: (settingsData) => settingsData.toJson(),
      orElse: () => SettingsData.initial().toJson(),
    );
  }

  factory SettingsState.fromJson(Map<String, dynamic> json) {
    try {
      final settingsData = SettingsData.fromJson(json);
      return SettingsState(
        data: UIStateModel.success(data: settingsData),
        // Transient states are not persisted
        availablePrinters: const [],
        isScanningPrinters: false,
        isConnectingPrinter: false,
        isTogglingBluetooth: false,
      );
    } catch (e) {
      return SettingsState.initial();
    }
  }
}
