import 'dart:async';
import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:flashlight_pos/core/usecase/usecase.dart';
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
import 'package:flashlight_pos/features/settings/presentation/bloc/settings_converters.dart';

part 'settings_event.dart';
part 'settings_state.dart';
part 'settings_bloc.freezed.dart';
part 'settings_bloc.g.dart';

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

        // Update printer settings with current Bluetooth state
        add(UpdatePrinterSettingsEvent(
          settings: state.printerSettings.copyWith(
            bluetoothEnabled: bluetoothEnabled,
          ),
        ));

        // Clear printer connection if Bluetooth is turned off
        if (!bluetoothEnabled && state.printerSettings.isConnected) {
          add(const DisconnectPrinterEvent());
        }
      },
    );
  }

  Future<void> _onLoadSettings(
    LoadSettings event,
    Emitter<SettingsState> emit,
  ) async {
    emit(state.copyWith(status: SettingsStatus.loading));

    final result = await getAppSettings(NoParams());

    result.fold(
      (failure) => emit(state.copyWith(
        status: SettingsStatus.failure,
        errorMessage: failure.message,
      )),
      (appSettings) => emit(state.copyWith(
        appSettings: appSettings,
        status: SettingsStatus.success,
      )),
    );
  }

  Future<void> _onUpdateStoreInfo(
    UpdateStoreInfo event,
    Emitter<SettingsState> emit,
  ) async {
    final updatedAppSettings = state.appSettings.copyWith(
      storeName: event.storeName ?? state.appSettings.storeName,
      storeAddress: event.storeAddress ?? state.appSettings.storeAddress,
      storePhone: event.storePhone ?? state.appSettings.storePhone,
      storeEmail: event.storeEmail ?? state.appSettings.storeEmail,
    );

    final result = await updateAppSettings(
      UpdateAppSettingsParams(settings: updatedAppSettings),
    );

    result.fold(
      (failure) => emit(state.copyWith(
        status: SettingsStatus.failure,
        errorMessage: failure.message,
      )),
      (_) => emit(state.copyWith(
        appSettings: updatedAppSettings,
        status: SettingsStatus.success,
      )),
    );
  }

  Future<void> _onUpdatePOSSettings(
    UpdatePOSSettings event,
    Emitter<SettingsState> emit,
  ) async {
    final updatedAppSettings = state.appSettings.copyWith(
      taxRate: event.taxRate ?? state.appSettings.taxRate,
      autoCalculateTax: event.autoCalculateTax ?? state.appSettings.autoCalculateTax,
    );

    final result = await updateAppSettings(
      UpdateAppSettingsParams(settings: updatedAppSettings),
    );

    result.fold(
      (failure) => emit(state.copyWith(
        status: SettingsStatus.failure,
        errorMessage: failure.message,
      )),
      (_) => emit(state.copyWith(
        appSettings: updatedAppSettings,
        status: SettingsStatus.success,
      )),
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
        status: SettingsStatus.failure,
        errorMessage: 'Failed to toggle Bluetooth: $e',
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
        status: SettingsStatus.failure,
        errorMessage: failure.message,
      )),
      (devices) => emit(state.copyWith(
        isScanningPrinters: false,
        availablePrinters: devices,
        status: SettingsStatus.success,
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
        status: SettingsStatus.failure,
        errorMessage: failure.message,
      )),
      (success) {
        if (success) {
          final updatedSettings = state.printerSettings.copyWith(
            connectedPrinterName: event.device.name,
            connectedPrinterMac: event.device.macAddress,
          );

          emit(state.copyWith(
            isConnectingPrinter: false,
            printerSettings: updatedSettings,
            status: SettingsStatus.success,
          ));
        } else {
          emit(state.copyWith(
            isConnectingPrinter: false,
            status: SettingsStatus.failure,
            errorMessage: 'Failed to connect to printer',
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
        status: SettingsStatus.failure,
        errorMessage: failure.message,
      )),
      (_) {
        final updatedSettings = state.printerSettings.clearConnection();
        emit(state.copyWith(
          printerSettings: updatedSettings,
          status: SettingsStatus.success,
        ));
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
        status: SettingsStatus.failure,
        errorMessage: failure.message,
      )),
      (_) => emit(state.copyWith(
        printerSettings: event.settings,
        status: SettingsStatus.success,
      )),
    );
  }

  Future<void> _onUpdateReceiptSettings(
    UpdateReceiptSettingsEvent event,
    Emitter<SettingsState> emit,
  ) async {
    emit(state.copyWith(
      receiptSettings: event.settings,
      status: SettingsStatus.success,
    ));
  }

  Future<void> _onUpdateNotificationSettings(
    UpdateNotificationSettingsEvent event,
    Emitter<SettingsState> emit,
  ) async {
    emit(state.copyWith(
      notificationSettings: event.settings,
      status: SettingsStatus.success,
    ));
  }

  Future<void> _onUpdateSecuritySettings(
    UpdateSecuritySettingsEvent event,
    Emitter<SettingsState> emit,
  ) async {
    emit(state.copyWith(
      securitySettings: event.settings,
      status: SettingsStatus.success,
    ));
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
