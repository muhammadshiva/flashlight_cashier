import 'dart:async';
import 'dart:developer';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flashlight_pos/core/usecase/usecase.dart';
import 'package:flashlight_pos/features/settings/domain/entities/printer_device.dart';
import 'package:flashlight_pos/features/settings/domain/entities/printer_settings.dart';
import 'package:flashlight_pos/features/settings/domain/usecases/connect_printer.dart';
import 'package:flashlight_pos/features/settings/domain/usecases/disconnect_printer.dart';
import 'package:flashlight_pos/features/settings/domain/usecases/get_printer_settings.dart';
import 'package:flashlight_pos/features/settings/domain/usecases/scan_printers.dart';
import 'package:flashlight_pos/features/settings/domain/usecases/update_printer_settings.dart';
import 'package:flashlight_pos/shared/models/ui_state_model.dart';

part 'printer_settings_state.dart';

/// Printer Settings Cubit
///
/// Manages printer configuration state separately from main SettingsBloc
/// Uses UIStateModel for data state and separate booleans for UI loading states
class PrinterSettingsCubit extends Cubit<PrinterSettingsState> {
  final GetPrinterSettings getPrinterSettings;
  final UpdatePrinterSettings updatePrinterSettings;
  final ScanPrinters scanPrinters;
  final ConnectPrinter connectPrinter;
  final DisconnectPrinter disconnectPrinter;

  StreamSubscription<BluetoothAdapterState>? _bluetoothStateSubscription;

  PrinterSettingsCubit({
    required this.getPrinterSettings,
    required this.updatePrinterSettings,
    required this.scanPrinters,
    required this.connectPrinter,
    required this.disconnectPrinter,
  }) : super(PrinterSettingsState.initial()) {
    // Listen to Bluetooth state changes
    _initBluetoothListener();

    // Load initial settings
    loadPrinterSettings();
  }

  void _initBluetoothListener() {
    _bluetoothStateSubscription = FlutterBluePlus.adapterState.listen(
      (BluetoothAdapterState adapterState) {
        final bluetoothEnabled = adapterState == BluetoothAdapterState.on;

        state.data.whenOrNull(
          success: (printerSettings) {
            // Update Bluetooth enabled state
            updateSettings(printerSettings.copyWith(
              bluetoothEnabled: bluetoothEnabled,
            ));

            // Clear printer connection if Bluetooth is turned off
            if (!bluetoothEnabled && printerSettings.isConnected) {
              disconnectFromPrinter();
            }
          },
        );
      },
    );
  }

  /// Load printer settings from repository
  Future<void> loadPrinterSettings() async {
    emit(state.copyWith(data: const UIStateModel.loading()));

    final result = await getPrinterSettings(NoParams());

    result.fold(
      (failure) => emit(state.copyWith(
        data: UIStateModel.error(message: failure.message),
      )),
      (printerSettings) => emit(state.copyWith(
        data: UIStateModel.success(data: printerSettings),
      )),
    );
  }

  /// Update printer settings
  Future<void> updateSettings(PrinterSettings settings) async {
    final result = await updatePrinterSettings(
      UpdatePrinterSettingsParams(settings: settings),
    );

    result.fold(
      (failure) => emit(state.copyWith(
        data: UIStateModel.error(message: failure.message),
      )),
      (_) => emit(state.copyWith(
        data: UIStateModel.success(data: settings),
      )),
    );
  }

  /// Toggle Bluetooth on/off
  Future<void> toggleBluetooth(bool enable) async {
    emit(state.copyWith(isTogglingBluetooth: true));

    try {
      if (enable) {
        await FlutterBluePlus.turnOn();
      }
      // Wait for Bluetooth to turn on/off
      await Future.delayed(const Duration(milliseconds: 1500));
      emit(state.copyWith(isTogglingBluetooth: false));
    } catch (e) {
      log('Error toggling Bluetooth: $e', name: 'PrinterSettingsCubit');
      emit(state.copyWith(
        isTogglingBluetooth: false,
        data: UIStateModel.error(message: 'Failed to toggle Bluetooth: $e'),
      ));
    }
  }

  /// Scan for available Bluetooth printers
  Future<void> scanForPrinters() async {
    emit(state.copyWith(
      isScanningPrinters: true,
      availablePrinters: [],
    ));

    final result = await scanPrinters(NoParams());

    result.fold(
      (failure) => emit(state.copyWith(
        isScanningPrinters: false,
        data: UIStateModel.error(message: failure.message),
      )),
      (devices) => emit(state.copyWith(
        isScanningPrinters: false,
        availablePrinters: devices,
      )),
    );
  }

  /// Connect to a printer
  Future<void> connectToPrinter(PrinterDevice device) async {
    emit(state.copyWith(isConnectingPrinter: true));

    final result = await connectPrinter(
      ConnectPrinterParams(device: device),
    );

    result.fold(
      (failure) => emit(state.copyWith(
        isConnectingPrinter: false,
        data: UIStateModel.error(message: failure.message),
      )),
      (success) {
        if (success) {
          state.data.whenOrNull(
            success: (printerSettings) {
              final updatedSettings = printerSettings.copyWith(
                connectedPrinterName: device.name,
                connectedPrinterMac: device.macAddress,
              );

              emit(state.copyWith(
                isConnectingPrinter: false,
                data: UIStateModel.success(data: updatedSettings),
              ));

              // Save updated settings
              updateSettings(updatedSettings);
            },
          );
        } else {
          emit(state.copyWith(
            isConnectingPrinter: false,
            data: const UIStateModel.error(message: 'Failed to connect to printer'),
          ));
        }
      },
    );
  }

  /// Disconnect from printer
  Future<void> disconnectFromPrinter() async {
    final result = await disconnectPrinter(NoParams());

    result.fold(
      (failure) => emit(state.copyWith(
        data: UIStateModel.error(message: failure.message),
      )),
      (_) {
        state.data.whenOrNull(
          success: (printerSettings) {
            final updatedSettings = printerSettings.clearConnection();

            emit(state.copyWith(
              data: UIStateModel.success(data: updatedSettings),
            ));

            // Save updated settings
            updateSettings(updatedSettings);
          },
        );
      },
    );
  }

  @override
  Future<void> close() {
    _bluetoothStateSubscription?.cancel();
    return super.close();
  }
}
