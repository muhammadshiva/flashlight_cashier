import 'package:equatable/equatable.dart';
import 'package:flashlight_pos/core/usecase/usecase.dart';
import 'package:flashlight_pos/features/settings/domain/entities/notification_settings.dart';
import 'package:flashlight_pos/features/settings/domain/usecases/get_notification_settings.dart';
import 'package:flashlight_pos/features/settings/domain/usecases/update_notification_settings.dart';
import 'package:flashlight_pos/shared/models/ui_state_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'notification_settings_state.dart';

/// Notification Settings Cubit
///
/// Manages notification configuration state separately from main SettingsBloc
/// Uses UIStateModel for data state and separate booleans for UI loading states
class NotificationSettingsCubit extends Cubit<NotificationSettingsState> {
  final GetNotificationSettings getNotificationSettings;
  final UpdateNotificationSettings updateNotificationSettings;

  NotificationSettingsCubit({
    required this.getNotificationSettings,
    required this.updateNotificationSettings,
  }) : super(NotificationSettingsState.initial()) {
    // Load initial settings
    loadNotificationSettings();
  }

  /// Load notification settings from repository
  Future<void> loadNotificationSettings() async {
    emit(state.copyWith(data: const UIStateModel.loading()));

    final result = await getNotificationSettings(NoParams());

    result.fold(
      (failure) => emit(state.copyWith(
        data: UIStateModel.error(message: failure.message),
      )),
      (notificationSettings) => emit(state.copyWith(
        data: UIStateModel.success(data: notificationSettings),
      )),
    );
  }

  /// Toggle notifications on/off
  Future<void> toggleNotifications(bool enable) async {
    final currentState = state.data;
    if (currentState is UIStateModelSuccess<NotificationSettings>) {
      emit(state.copyWith(isUpdatingNotifications: true));

      final updatedSettings = currentState.data.copyWith(
        enableNotifications: enable,
      );

      final result = await updateNotificationSettings(
        UpdateNotificationSettingsParams(settings: updatedSettings),
      );

      result.fold(
        (failure) => emit(state.copyWith(
          isUpdatingNotifications: false,
          data: UIStateModel.error(message: failure.message),
        )),
        (_) => emit(state.copyWith(
          isUpdatingNotifications: false,
          data: UIStateModel.success(data: updatedSettings),
        )),
      );
    }
  }

  /// Toggle sound alerts on/off
  Future<void> toggleSoundAlerts(bool enable) async {
    final currentState = state.data;
    if (currentState is UIStateModelSuccess<NotificationSettings>) {
      emit(state.copyWith(isUpdatingSoundAlerts: true));

      final updatedSettings = currentState.data.copyWith(
        enableSoundAlerts: enable,
      );

      final result = await updateNotificationSettings(
        UpdateNotificationSettingsParams(settings: updatedSettings),
      );

      result.fold(
        (failure) => emit(state.copyWith(
          isUpdatingSoundAlerts: false,
          data: UIStateModel.error(message: failure.message),
        )),
        (_) => emit(state.copyWith(
          isUpdatingSoundAlerts: false,
          data: UIStateModel.success(data: updatedSettings),
        )),
      );
    }
  }

  /// Toggle low stock notifications on/off
  Future<void> toggleLowStockNotifications(bool enable) async {
    final currentState = state.data;
    if (currentState is UIStateModelSuccess<NotificationSettings>) {
      emit(state.copyWith(isUpdatingLowStock: true));

      final updatedSettings = currentState.data.copyWith(
        notifyOnLowStock: enable,
      );

      final result = await updateNotificationSettings(
        UpdateNotificationSettingsParams(settings: updatedSettings),
      );

      result.fold(
        (failure) => emit(state.copyWith(
          isUpdatingLowStock: false,
          data: UIStateModel.error(message: failure.message),
        )),
        (_) => emit(state.copyWith(
          isUpdatingLowStock: false,
          data: UIStateModel.success(data: updatedSettings),
        )),
      );
    }
  }

  /// Toggle new order notifications on/off
  Future<void> toggleNewOrderNotifications(bool enable) async {
    final currentState = state.data;
    if (currentState is UIStateModelSuccess<NotificationSettings>) {
      emit(state.copyWith(isUpdatingNewOrder: true));

      final updatedSettings = currentState.data.copyWith(
        notifyOnNewOrder: enable,
      );

      final result = await updateNotificationSettings(
        UpdateNotificationSettingsParams(settings: updatedSettings),
      );

      result.fold(
        (failure) => emit(state.copyWith(
          isUpdatingNewOrder: false,
          data: UIStateModel.error(message: failure.message),
        )),
        (_) => emit(state.copyWith(
          isUpdatingNewOrder: false,
          data: UIStateModel.success(data: updatedSettings),
        )),
      );
    }
  }

  /// Toggle payment received notifications on/off
  Future<void> togglePaymentReceivedNotifications(bool enable) async {
    final currentState = state.data;
    if (currentState is UIStateModelSuccess<NotificationSettings>) {
      emit(state.copyWith(isUpdatingPaymentReceived: true));

      final updatedSettings = currentState.data.copyWith(
        notifyOnPaymentReceived: enable,
      );

      final result = await updateNotificationSettings(
        UpdateNotificationSettingsParams(settings: updatedSettings),
      );

      result.fold(
        (failure) => emit(state.copyWith(
          isUpdatingPaymentReceived: false,
          data: UIStateModel.error(message: failure.message),
        )),
        (_) => emit(state.copyWith(
          isUpdatingPaymentReceived: false,
          data: UIStateModel.success(data: updatedSettings),
        )),
      );
    }
  }
}
