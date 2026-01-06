import 'package:equatable/equatable.dart';
import 'package:flashlight_pos/core/usecase/usecase.dart';
import 'package:flashlight_pos/features/settings/domain/entities/security_settings.dart';
import 'package:flashlight_pos/features/settings/domain/usecases/get_security_settings.dart';
import 'package:flashlight_pos/features/settings/domain/usecases/update_security_settings.dart';
import 'package:flashlight_pos/shared/models/ui_state_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'security_settings_state.dart';

/// Security Settings Cubit
///
/// Manages security configuration state separately from main SettingsBloc
/// Uses UIStateModel for data state and separate booleans for UI loading states
class SecuritySettingsCubit extends Cubit<SecuritySettingsState> {
  final GetSecuritySettings getSecuritySettings;
  final UpdateSecuritySettings updateSecuritySettings;

  SecuritySettingsCubit({
    required this.getSecuritySettings,
    required this.updateSecuritySettings,
  }) : super(SecuritySettingsState.initial()) {
    // Load initial settings
    loadSecuritySettings();
  }

  /// Load security settings from repository
  Future<void> loadSecuritySettings() async {
    emit(state.copyWith(data: const UIStateModel.loading()));

    final result = await getSecuritySettings(NoParams());

    result.fold(
      (failure) => emit(state.copyWith(
        data: UIStateModel.error(message: failure.message),
      )),
      (securitySettings) => emit(state.copyWith(
        data: UIStateModel.success(data: securitySettings),
      )),
    );
  }

  /// Toggle PIN requirement for refund
  Future<void> togglePinForRefund(bool require) async {
    final currentState = state.data;
    if (currentState is UIStateModelSuccess<SecuritySettings>) {
      emit(state.copyWith(isUpdatingPinForRefund: true));

      final updatedSettings = currentState.data.copyWith(
        requirePinForRefund: require,
      );

      final result = await updateSecuritySettings(
        UpdateSecuritySettingsParams(settings: updatedSettings),
      );

      result.fold(
        (failure) => emit(state.copyWith(
          isUpdatingPinForRefund: false,
          data: UIStateModel.error(message: failure.message),
        )),
        (_) => emit(state.copyWith(
          isUpdatingPinForRefund: false,
          data: UIStateModel.success(data: updatedSettings),
        )),
      );
    }
  }

  /// Toggle PIN requirement for discount
  Future<void> togglePinForDiscount(bool require) async {
    final currentState = state.data;
    if (currentState is UIStateModelSuccess<SecuritySettings>) {
      emit(state.copyWith(isUpdatingPinForDiscount: true));

      final updatedSettings = currentState.data.copyWith(
        requirePinForDiscount: require,
      );

      final result = await updateSecuritySettings(
        UpdateSecuritySettingsParams(settings: updatedSettings),
      );

      result.fold(
        (failure) => emit(state.copyWith(
          isUpdatingPinForDiscount: false,
          data: UIStateModel.error(message: failure.message),
        )),
        (_) => emit(state.copyWith(
          isUpdatingPinForDiscount: false,
          data: UIStateModel.success(data: updatedSettings),
        )),
      );
    }
  }

  /// Toggle PIN requirement for void
  Future<void> togglePinForVoid(bool require) async {
    final currentState = state.data;
    if (currentState is UIStateModelSuccess<SecuritySettings>) {
      emit(state.copyWith(isUpdatingPinForVoid: true));

      final updatedSettings = currentState.data.copyWith(
        requirePinForVoid: require,
      );

      final result = await updateSecuritySettings(
        UpdateSecuritySettingsParams(settings: updatedSettings),
      );

      result.fold(
        (failure) => emit(state.copyWith(
          isUpdatingPinForVoid: false,
          data: UIStateModel.error(message: failure.message),
        )),
        (_) => emit(state.copyWith(
          isUpdatingPinForVoid: false,
          data: UIStateModel.success(data: updatedSettings),
        )),
      );
    }
  }

  /// Toggle auto lock after inactivity
  Future<void> toggleAutoLock(bool enable) async {
    final currentState = state.data;
    if (currentState is UIStateModelSuccess<SecuritySettings>) {
      emit(state.copyWith(isUpdatingAutoLock: true));

      final updatedSettings = currentState.data.copyWith(
        autoLockAfterInactivity: enable,
      );

      final result = await updateSecuritySettings(
        UpdateSecuritySettingsParams(settings: updatedSettings),
      );

      result.fold(
        (failure) => emit(state.copyWith(
          isUpdatingAutoLock: false,
          data: UIStateModel.error(message: failure.message),
        )),
        (_) => emit(state.copyWith(
          isUpdatingAutoLock: false,
          data: UIStateModel.success(data: updatedSettings),
        )),
      );
    }
  }

  /// Update auto lock duration
  Future<void> updateAutoLockDuration(int duration) async {
    final currentState = state.data;
    if (currentState is UIStateModelSuccess<SecuritySettings>) {
      emit(state.copyWith(isUpdatingAutoLockDuration: true));

      final updatedSettings = currentState.data.copyWith(
        autoLockDurationMinutes: duration,
      );

      final result = await updateSecuritySettings(
        UpdateSecuritySettingsParams(settings: updatedSettings),
      );

      result.fold(
        (failure) => emit(state.copyWith(
          isUpdatingAutoLockDuration: false,
          data: UIStateModel.error(message: failure.message),
        )),
        (_) => emit(state.copyWith(
          isUpdatingAutoLockDuration: false,
          data: UIStateModel.success(data: updatedSettings),
        )),
      );
    }
  }
}
