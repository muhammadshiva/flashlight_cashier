import 'package:equatable/equatable.dart';
import 'package:flashlight_pos/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'pos_settings_state.dart';

/// Cubit for managing POS Settings Form
/// Handles form state, validation, and syncing with SettingsBloc
class POSSettingsCubit extends Cubit<POSSettingsState> {
  final SettingsBloc settingsBloc;

  POSSettingsCubit({required this.settingsBloc}) : super(POSSettingsState.initial()) {
    _initializeFromSettingsBloc();
  }

  /// Initialize form from current app settings in SettingsBloc
  void _initializeFromSettingsBloc() {
    final appSettings = settingsBloc.state.appSettings;
    if (appSettings != null) {
      emit(POSSettingsState(
        taxRate: appSettings.taxRate,
        autoCalculateTax: appSettings.autoCalculateTax,
        autoPrintReceipt: appSettings.autoPrintReceipt,
        currencyCode: appSettings.currencyCode,
        decimalPlaces: appSettings.decimalPlaces,
        isDirty: false,
        isSaving: false,
      ));
    }
  }

  /// Update tax rate
  void updateTaxRate(double taxRate) {
    emit(state.copyWith(
      taxRate: taxRate,
      isDirty: true,
    ));
  }

  /// Toggle auto calculate tax
  void toggleAutoCalculateTax(bool value) {
    emit(state.copyWith(
      autoCalculateTax: value,
      isDirty: true,
    ));
  }

  /// Toggle auto print receipt
  void toggleAutoPrintReceipt(bool value) {
    emit(state.copyWith(
      autoPrintReceipt: value,
      isDirty: true,
    ));
  }

  /// Update currency code
  void updateCurrencyCode(String currencyCode) {
    emit(state.copyWith(
      currencyCode: currencyCode,
      isDirty: true,
    ));
  }

  /// Update decimal places
  void updateDecimalPlaces(int decimalPlaces) {
    emit(state.copyWith(
      decimalPlaces: decimalPlaces,
      isDirty: true,
    ));
  }

  /// Save POS settings to SettingsBloc
  Future<void> saveSettings() async {
    emit(state.copyWith(isSaving: true));

    // Dispatch event to SettingsBloc
    settingsBloc.add(UpdatePOSSettings(
      taxRate: state.taxRate,
      autoCalculateTax: state.autoCalculateTax,
      autoPrintReceipt: state.autoPrintReceipt,
      currencyCode: state.currencyCode,
      decimalPlaces: state.decimalPlaces,
    ));

    // Wait a bit for SettingsBloc to process
    await Future.delayed(const Duration(milliseconds: 300));

    emit(state.copyWith(
      isSaving: false,
      isDirty: false,
    ));
  }

  /// Reset form to current app settings
  void reset() {
    _initializeFromSettingsBloc();
  }

  /// Discard changes
  void discardChanges() {
    _initializeFromSettingsBloc();
  }
}
