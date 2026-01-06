import 'dart:async';
import 'dart:developer';
import 'package:equatable/equatable.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:flashlight_pos/core/usecase/usecase.dart';
import 'package:flashlight_pos/features/settings/data/models/settings_data.dart';
import 'package:flashlight_pos/features/settings/domain/entities/app_settings.dart';
import 'package:flashlight_pos/features/settings/domain/entities/notification_settings.dart';
import 'package:flashlight_pos/features/settings/domain/entities/printer_device.dart';
import 'package:flashlight_pos/features/settings/domain/entities/printer_settings.dart';
import 'package:flashlight_pos/features/settings/domain/entities/receipt_settings.dart';
import 'package:flashlight_pos/features/settings/domain/entities/security_settings.dart';
import 'package:flashlight_pos/features/settings/domain/usecases/connect_printer.dart';
import 'package:flashlight_pos/features/settings/domain/usecases/disconnect_printer.dart';
import 'package:flashlight_pos/features/settings/domain/usecases/get_app_settings.dart';
import 'package:flashlight_pos/features/settings/domain/usecases/scan_printers.dart';
import 'package:flashlight_pos/features/settings/domain/usecases/update_app_settings.dart';
import 'package:flashlight_pos/features/settings/domain/usecases/update_printer_settings.dart';
import 'package:flashlight_pos/shared/models/ui_state_model.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends HydratedBloc<SettingsEvent, SettingsState> {
  final GetAppSettings getAppSettings;
  final UpdateAppSettings updateAppSettings;
  final ScanPrinters scanPrinters;
  final ConnectPrinter connectPrinter;
  final DisconnectPrinter disconnectPrinter;
  final UpdatePrinterSettings updatePrinterSettings;

  StreamSubscription<BluetoothAdapterState>? _bluetoothStateSubscription;

  SettingsBloc({
    required this.getAppSettings,
    required this.updateAppSettings,
    required this.scanPrinters,
    required this.connectPrinter,
    required this.disconnectPrinter,
    required this.updatePrinterSettings,
  }) : super(SettingsState.initial()) {
    on<LoadSettings>(_onLoadSettings);
    on<UpdateStoreInfo>(_onUpdateStoreInfo);
    on<UpdatePOSSettings>(_onUpdatePOSSettings);
    on<ToggleBluetooth>(_onToggleBluetooth);
    on<ScanPrintersEvent>(_onScanPrinters);
    on<ConnectPrinterEvent>(_onConnectPrinter);
    on<DisconnectPrinterEvent>(_onDisconnectPrinter);
    on<UpdatePrinterSettingsEvent>(_onUpdatePrinterSettings);
    on<UpdateReceiptSettingsEvent>(_onUpdateReceiptSettings);
    on<UpdateNotificationSettingsEvent>(_onUpdateNotificationSettings);
    on<UpdateSecuritySettingsEvent>(_onUpdateSecuritySettings);

    // Listen to Bluetooth state changes
    _initBluetoothListener();
  }

  void _initBluetoothListener() {
    _bluetoothStateSubscription = FlutterBluePlus.adapterState.listen(
      (BluetoothAdapterState adapterState) {
        final bluetoothEnabled = adapterState == BluetoothAdapterState.on;
        final currentPrinterSettings = state.printerSettings;

        if (currentPrinterSettings != null) {
          // Update printer settings with current Bluetooth state
          add(UpdatePrinterSettingsEvent(
            settings: currentPrinterSettings.copyWith(
              bluetoothEnabled: bluetoothEnabled,
            ),
          ));

          // Clear printer connection if Bluetooth is turned off
          if (!bluetoothEnabled && currentPrinterSettings.isConnected) {
            add(const DisconnectPrinterEvent());
          }
        }
      },
    );
  }

  // Helper method to update SettingsData within UIStateModel
  void _updateSettingsData(
    Emitter<SettingsState> emit,
    SettingsData Function(SettingsData) update,
  ) {
    final currentData = state.data.maybeWhen(
      success: (data) => data,
      orElse: () => SettingsData.initial(),
    );

    final updatedData = update(currentData);

    emit(state.copyWith(
      data: UIStateModel.success(data: updatedData),
    ));
  }

  Future<void> _onLoadSettings(
    LoadSettings event,
    Emitter<SettingsState> emit,
  ) async {
    emit(state.copyWith(data: const UIStateModel.loading()));

    final result = await getAppSettings(NoParams());

    result.fold(
      (failure) => emit(state.copyWith(
        data: UIStateModel.error(message: failure.message),
      )),
      (appSettings) {
        // Update only appSettings in SettingsData
        final currentData = state.data.maybeWhen(
          success: (data) => data,
          orElse: () => SettingsData.initial(),
        );

        final updatedData = currentData.copyWith(appSettings: appSettings);

        emit(state.copyWith(
          data: UIStateModel.success(data: updatedData),
        ));
      },
    );
  }

  Future<void> _onUpdateStoreInfo(
    UpdateStoreInfo event,
    Emitter<SettingsState> emit,
  ) async {
    final currentAppSettings = state.appSettings;
    if (currentAppSettings == null) return;

    final updatedAppSettings = currentAppSettings.copyWith(
      storeName: event.storeName ?? currentAppSettings.storeName,
      storeAddress: event.storeAddress ?? currentAppSettings.storeAddress,
      storePhone: event.storePhone ?? currentAppSettings.storePhone,
      storeEmail: event.storeEmail ?? currentAppSettings.storeEmail,
    );

    final result = await updateAppSettings(
      UpdateAppSettingsParams(settings: updatedAppSettings),
    );

    result.fold(
      (failure) => emit(state.copyWith(
        data: UIStateModel.error(message: failure.message),
      )),
      (_) => _updateSettingsData(
        emit,
        (data) => data.copyWith(appSettings: updatedAppSettings),
      ),
    );
  }

  Future<void> _onUpdatePOSSettings(
    UpdatePOSSettings event,
    Emitter<SettingsState> emit,
  ) async {
    final currentAppSettings = state.appSettings;
    if (currentAppSettings == null) return;

    final updatedAppSettings = currentAppSettings.copyWith(
      taxRate: event.taxRate ?? currentAppSettings.taxRate,
      autoCalculateTax: event.autoCalculateTax ?? currentAppSettings.autoCalculateTax,
      autoPrintReceipt: event.autoPrintReceipt ?? currentAppSettings.autoPrintReceipt,
      currencyCode: event.currencyCode ?? currentAppSettings.currencyCode,
      decimalPlaces: event.decimalPlaces ?? currentAppSettings.decimalPlaces,
    );

    final result = await updateAppSettings(
      UpdateAppSettingsParams(settings: updatedAppSettings),
    );

    result.fold(
      (failure) => emit(state.copyWith(
        data: UIStateModel.error(message: failure.message),
      )),
      (_) => _updateSettingsData(
        emit,
        (data) => data.copyWith(appSettings: updatedAppSettings),
      ),
    );
  }

  Future<void> _onToggleBluetooth(
    ToggleBluetooth event,
    Emitter<SettingsState> emit,
  ) async {
    emit(state.copyWith(isTogglingBluetooth: true));

    try {
      if (event.enable) {
        await FlutterBluePlus.turnOn();
      }
      await Future.delayed(const Duration(milliseconds: 1500));
      emit(state.copyWith(isTogglingBluetooth: false));
    } catch (e) {
      log('Error toggling Bluetooth: $e', name: 'SettingsBloc');
      emit(state.copyWith(
        isTogglingBluetooth: false,
        data: UIStateModel.error(message: 'Failed to toggle Bluetooth: $e'),
      ));
    }
  }

  Future<void> _onScanPrinters(
    ScanPrintersEvent event,
    Emitter<SettingsState> emit,
  ) async {
    emit(state.copyWith(isScanningPrinters: true, availablePrinters: []));

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

  Future<void> _onConnectPrinter(
    ConnectPrinterEvent event,
    Emitter<SettingsState> emit,
  ) async {
    emit(state.copyWith(isConnectingPrinter: true));

    final result = await connectPrinter(
      ConnectPrinterParams(device: event.device),
    );

    result.fold(
      (failure) => emit(state.copyWith(
        isConnectingPrinter: false,
        data: UIStateModel.error(message: failure.message),
      )),
      (success) {
        if (success) {
          final currentPrinterSettings = state.printerSettings;
          if (currentPrinterSettings != null) {
            final updatedSettings = currentPrinterSettings.copyWith(
              connectedPrinterName: event.device.name,
              connectedPrinterMac: event.device.macAddress,
            );

            emit(state.copyWith(isConnectingPrinter: false));
            _updateSettingsData(
              emit,
              (data) => data.copyWith(printerSettings: updatedSettings),
            );
          }
        } else {
          emit(state.copyWith(
            isConnectingPrinter: false,
            data: const UIStateModel.error(message: 'Failed to connect to printer'),
          ));
        }
      },
    );
  }

  Future<void> _onDisconnectPrinter(
    DisconnectPrinterEvent event,
    Emitter<SettingsState> emit,
  ) async {
    final result = await disconnectPrinter(NoParams());

    result.fold(
      (failure) => emit(state.copyWith(
        data: UIStateModel.error(message: failure.message),
      )),
      (_) {
        final currentPrinterSettings = state.printerSettings;
        if (currentPrinterSettings != null) {
          final updatedSettings = currentPrinterSettings.clearConnection();
          _updateSettingsData(
            emit,
            (data) => data.copyWith(printerSettings: updatedSettings),
          );
        }
      },
    );
  }

  Future<void> _onUpdatePrinterSettings(
    UpdatePrinterSettingsEvent event,
    Emitter<SettingsState> emit,
  ) async {
    final result = await updatePrinterSettings(
      UpdatePrinterSettingsParams(settings: event.settings),
    );

    result.fold(
      (failure) => emit(state.copyWith(
        data: UIStateModel.error(message: failure.message),
      )),
      (_) => _updateSettingsData(
        emit,
        (data) => data.copyWith(printerSettings: event.settings),
      ),
    );
  }

  Future<void> _onUpdateReceiptSettings(
    UpdateReceiptSettingsEvent event,
    Emitter<SettingsState> emit,
  ) async {
    _updateSettingsData(
      emit,
      (data) => data.copyWith(receiptSettings: event.settings),
    );
  }

  Future<void> _onUpdateNotificationSettings(
    UpdateNotificationSettingsEvent event,
    Emitter<SettingsState> emit,
  ) async {
    _updateSettingsData(
      emit,
      (data) => data.copyWith(notificationSettings: event.settings),
    );
  }

  Future<void> _onUpdateSecuritySettings(
    UpdateSecuritySettingsEvent event,
    Emitter<SettingsState> emit,
  ) async {
    _updateSettingsData(
      emit,
      (data) => data.copyWith(securitySettings: event.settings),
    );
  }

  @override
  Future<void> close() {
    _bluetoothStateSubscription?.cancel();
    return super.close();
  }

  @override
  SettingsState? fromJson(Map<String, dynamic> json) {
    try {
      return SettingsState.fromJson(json);
    } catch (e) {
      log('Error loading settings from storage: $e', name: 'SettingsBloc');
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(SettingsState state) {
    try {
      return state.toJson();
    } catch (e) {
      log('Error saving settings to storage: $e', name: 'SettingsBloc');
      return null;
    }
  }
}
