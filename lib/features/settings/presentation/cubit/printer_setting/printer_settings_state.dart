part of 'printer_settings_cubit.dart';

/// Printer Settings State
///
/// Combines UIStateModel for data state with separate UI loading flags
class PrinterSettingsState extends Equatable {
  /// Main printer settings data wrapped in UIStateModel
  final UIStateModel<PrinterSettings> data;

  /// Available printers from scan
  final List<PrinterDevice> availablePrinters;

  /// UI loading states
  final bool isScanningPrinters;
  final bool isConnectingPrinter;
  final bool isTogglingBluetooth;

  const PrinterSettingsState({
    required this.data,
    this.availablePrinters = const [],
    this.isScanningPrinters = false,
    this.isConnectingPrinter = false,
    this.isTogglingBluetooth = false,
  });

  factory PrinterSettingsState.initial() => PrinterSettingsState(
        data: UIStateModel.success(data: PrinterSettings.initial()),
      );

  @override
  List<Object?> get props => [
        data,
        availablePrinters,
        isScanningPrinters,
        isConnectingPrinter,
        isTogglingBluetooth,
      ];

  PrinterSettingsState copyWith({
    UIStateModel<PrinterSettings>? data,
    List<PrinterDevice>? availablePrinters,
    bool? isScanningPrinters,
    bool? isConnectingPrinter,
    bool? isTogglingBluetooth,
  }) {
    return PrinterSettingsState(
      data: data ?? this.data,
      availablePrinters: availablePrinters ?? this.availablePrinters,
      isScanningPrinters: isScanningPrinters ?? this.isScanningPrinters,
      isConnectingPrinter: isConnectingPrinter ?? this.isConnectingPrinter,
      isTogglingBluetooth: isTogglingBluetooth ?? this.isTogglingBluetooth,
    );
  }
}
