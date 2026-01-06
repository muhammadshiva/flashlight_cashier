import 'package:equatable/equatable.dart';
import 'package:flashlight_pos/core/usecase/usecase.dart';
import 'package:flashlight_pos/features/settings/domain/entities/backup_settings.dart';
import 'package:flashlight_pos/features/settings/domain/usecases/create_backup.dart';
import 'package:flashlight_pos/features/settings/domain/usecases/get_backup_settings.dart';
import 'package:flashlight_pos/features/settings/domain/usecases/restore_backup.dart';
import 'package:flashlight_pos/features/settings/domain/usecases/update_backup_settings.dart';
import 'package:flashlight_pos/shared/models/ui_state_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'backup_settings_state.dart';

/// Backup Settings Cubit
///
/// Manages backup configuration state separately from main SettingsBloc
/// Uses UIStateModel for data state and separate booleans for UI loading states
class BackupSettingsCubit extends Cubit<BackupSettingsState> {
  final GetBackupSettings getBackupSettings;
  final UpdateBackupSettings updateBackupSettings;
  final CreateBackup createBackup;
  final RestoreBackup restoreBackup;

  BackupSettingsCubit({
    required this.getBackupSettings,
    required this.updateBackupSettings,
    required this.createBackup,
    required this.restoreBackup,
  }) : super(BackupSettingsState.initial()) {
    // Load initial settings
    loadBackupSettings();
  }

  /// Load backup settings from repository
  Future<void> loadBackupSettings() async {
    emit(state.copyWith(data: const UIStateModel.loading()));

    final result = await getBackupSettings(NoParams());

    result.fold(
      (failure) => emit(state.copyWith(
        data: UIStateModel.error(message: failure.message),
      )),
      (backupSettings) => emit(state.copyWith(
        data: UIStateModel.success(data: backupSettings),
      )),
    );
  }

  /// Toggle auto backup
  Future<void> toggleAutoBackup(bool enable) async {
    final currentState = state.data;
    if (currentState is UIStateModelSuccess<BackupSettings>) {
      emit(state.copyWith(isUpdatingAutoBackup: true));

      final updatedSettings = currentState.data.copyWith(
        autoBackupEnabled: enable,
      );

      final result = await updateBackupSettings(
        UpdateBackupSettingsParams(settings: updatedSettings),
      );

      result.fold(
        (failure) => emit(state.copyWith(
          isUpdatingAutoBackup: false,
          data: UIStateModel.error(message: failure.message),
        )),
        (_) => emit(state.copyWith(
          isUpdatingAutoBackup: false,
          data: UIStateModel.success(data: updatedSettings),
        )),
      );
    }
  }

  /// Update auto backup interval
  Future<void> updateAutoBackupInterval(int days) async {
    final currentState = state.data;
    if (currentState is UIStateModelSuccess<BackupSettings>) {
      emit(state.copyWith(isUpdatingAutoBackupInterval: true));

      final updatedSettings = currentState.data.copyWith(
        autoBackupIntervalDays: days,
      );

      final result = await updateBackupSettings(
        UpdateBackupSettingsParams(settings: updatedSettings),
      );

      result.fold(
        (failure) => emit(state.copyWith(
          isUpdatingAutoBackupInterval: false,
          data: UIStateModel.error(message: failure.message),
        )),
        (_) => emit(state.copyWith(
          isUpdatingAutoBackupInterval: false,
          data: UIStateModel.success(data: updatedSettings),
        )),
      );
    }
  }

  /// Toggle include transaction data
  Future<void> toggleIncludeTransactionData(bool include) async {
    final currentState = state.data;
    if (currentState is UIStateModelSuccess<BackupSettings>) {
      emit(state.copyWith(isUpdatingBackupOptions: true));

      final updatedSettings = currentState.data.copyWith(
        includeTransactionData: include,
      );

      final result = await updateBackupSettings(
        UpdateBackupSettingsParams(settings: updatedSettings),
      );

      result.fold(
        (failure) => emit(state.copyWith(
          isUpdatingBackupOptions: false,
          data: UIStateModel.error(message: failure.message),
        )),
        (_) => emit(state.copyWith(
          isUpdatingBackupOptions: false,
          data: UIStateModel.success(data: updatedSettings),
        )),
      );
    }
  }

  /// Toggle include customer data
  Future<void> toggleIncludeCustomerData(bool include) async {
    final currentState = state.data;
    if (currentState is UIStateModelSuccess<BackupSettings>) {
      emit(state.copyWith(isUpdatingBackupOptions: true));

      final updatedSettings = currentState.data.copyWith(
        includeCustomerData: include,
      );

      final result = await updateBackupSettings(
        UpdateBackupSettingsParams(settings: updatedSettings),
      );

      result.fold(
        (failure) => emit(state.copyWith(
          isUpdatingBackupOptions: false,
          data: UIStateModel.error(message: failure.message),
        )),
        (_) => emit(state.copyWith(
          isUpdatingBackupOptions: false,
          data: UIStateModel.success(data: updatedSettings),
        )),
      );
    }
  }

  /// Toggle include product data
  Future<void> toggleIncludeProductData(bool include) async {
    final currentState = state.data;
    if (currentState is UIStateModelSuccess<BackupSettings>) {
      emit(state.copyWith(isUpdatingBackupOptions: true));

      final updatedSettings = currentState.data.copyWith(
        includeProductData: include,
      );

      final result = await updateBackupSettings(
        UpdateBackupSettingsParams(settings: updatedSettings),
      );

      result.fold(
        (failure) => emit(state.copyWith(
          isUpdatingBackupOptions: false,
          data: UIStateModel.error(message: failure.message),
        )),
        (_) => emit(state.copyWith(
          isUpdatingBackupOptions: false,
          data: UIStateModel.success(data: updatedSettings),
        )),
      );
    }
  }

  /// Toggle include settings data
  Future<void> toggleIncludeSettingsData(bool include) async {
    final currentState = state.data;
    if (currentState is UIStateModelSuccess<BackupSettings>) {
      emit(state.copyWith(isUpdatingBackupOptions: true));

      final updatedSettings = currentState.data.copyWith(
        includeSettingsData: include,
      );

      final result = await updateBackupSettings(
        UpdateBackupSettingsParams(settings: updatedSettings),
      );

      result.fold(
        (failure) => emit(state.copyWith(
          isUpdatingBackupOptions: false,
          data: UIStateModel.error(message: failure.message),
        )),
        (_) => emit(state.copyWith(
          isUpdatingBackupOptions: false,
          data: UIStateModel.success(data: updatedSettings),
        )),
      );
    }
  }

  /// Create backup
  Future<void> createManualBackup(String backupPath) async {
    emit(state.copyWith(isCreatingBackup: true));

    final result = await createBackup(
      CreateBackupParams(backupPath: backupPath),
    );

    result.fold(
      (failure) => emit(state.copyWith(
        isCreatingBackup: false,
        backupError: failure.message,
      )),
      (backupFilePath) => emit(state.copyWith(
        isCreatingBackup: false,
        backupSuccess: true,
        lastBackupPath: backupFilePath,
      )),
    );

    // Clear success/error messages after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      emit(state.copyWith(
        backupSuccess: false,
        backupError: null,
      ));
    });
  }

  /// Restore backup
  Future<void> restoreFromBackup(String backupPath) async {
    emit(state.copyWith(isRestoringBackup: true));

    final result = await restoreBackup(
      RestoreBackupParams(backupPath: backupPath),
    );

    result.fold(
      (failure) => emit(state.copyWith(
        isRestoringBackup: false,
        restoreError: failure.message,
      )),
      (_) => emit(state.copyWith(
        isRestoringBackup: false,
        restoreSuccess: true,
      )),
    );

    // Clear success/error messages after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      emit(state.copyWith(
        restoreSuccess: false,
        restoreError: null,
      ));
    });

    // Reload settings after successful restore
    if (state.restoreSuccess) {
      loadBackupSettings();
    }
  }
}
