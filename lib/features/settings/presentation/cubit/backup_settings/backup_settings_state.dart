part of 'backup_settings_cubit.dart';

/// Backup Settings State
///
/// Combines UIStateModel for data state with separate UI loading flags
class BackupSettingsState extends Equatable {
  /// Main backup settings data wrapped in UIStateModel
  final UIStateModel<BackupSettings> data;

  /// UI loading states for individual operations
  final bool isUpdatingAutoBackup;
  final bool isUpdatingAutoBackupInterval;
  final bool isUpdatingBackupOptions;
  final bool isCreatingBackup;
  final bool isRestoringBackup;

  /// Success/error states for backup/restore operations
  final bool backupSuccess;
  final String? backupError;
  final bool restoreSuccess;
  final String? restoreError;
  final String? lastBackupPath;

  const BackupSettingsState({
    required this.data,
    this.isUpdatingAutoBackup = false,
    this.isUpdatingAutoBackupInterval = false,
    this.isUpdatingBackupOptions = false,
    this.isCreatingBackup = false,
    this.isRestoringBackup = false,
    this.backupSuccess = false,
    this.backupError,
    this.restoreSuccess = false,
    this.restoreError,
    this.lastBackupPath,
  });

  factory BackupSettingsState.initial() => BackupSettingsState(
        data: UIStateModel.success(data: BackupSettings.initial()),
      );

  @override
  List<Object?> get props => [
        data,
        isUpdatingAutoBackup,
        isUpdatingAutoBackupInterval,
        isUpdatingBackupOptions,
        isCreatingBackup,
        isRestoringBackup,
        backupSuccess,
        backupError,
        restoreSuccess,
        restoreError,
        lastBackupPath,
      ];

  BackupSettingsState copyWith({
    UIStateModel<BackupSettings>? data,
    bool? isUpdatingAutoBackup,
    bool? isUpdatingAutoBackupInterval,
    bool? isUpdatingBackupOptions,
    bool? isCreatingBackup,
    bool? isRestoringBackup,
    bool? backupSuccess,
    String? backupError,
    bool? restoreSuccess,
    String? restoreError,
    String? lastBackupPath,
  }) {
    return BackupSettingsState(
      data: data ?? this.data,
      isUpdatingAutoBackup: isUpdatingAutoBackup ?? this.isUpdatingAutoBackup,
      isUpdatingAutoBackupInterval:
          isUpdatingAutoBackupInterval ?? this.isUpdatingAutoBackupInterval,
      isUpdatingBackupOptions: isUpdatingBackupOptions ?? this.isUpdatingBackupOptions,
      isCreatingBackup: isCreatingBackup ?? this.isCreatingBackup,
      isRestoringBackup: isRestoringBackup ?? this.isRestoringBackup,
      backupSuccess: backupSuccess ?? this.backupSuccess,
      backupError: backupError ?? this.backupError,
      restoreSuccess: restoreSuccess ?? this.restoreSuccess,
      restoreError: restoreError ?? this.restoreError,
      lastBackupPath: lastBackupPath ?? this.lastBackupPath,
    );
  }
}
