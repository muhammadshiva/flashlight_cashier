/// Domain Entity for Backup Settings
class BackupSettings {
  final bool autoBackupEnabled;
  final int autoBackupIntervalDays;
  final String? lastBackupDate;
  final String? backupLocation;
  final bool includeTransactionData;
  final bool includeCustomerData;
  final bool includeProductData;
  final bool includeSettingsData;

  const BackupSettings({
    required this.autoBackupEnabled,
    required this.autoBackupIntervalDays,
    this.lastBackupDate,
    this.backupLocation,
    required this.includeTransactionData,
    required this.includeCustomerData,
    required this.includeProductData,
    required this.includeSettingsData,
  });

  factory BackupSettings.initial() {
    return const BackupSettings(
      autoBackupEnabled: false,
      autoBackupIntervalDays: 7,
      lastBackupDate: null,
      backupLocation: null,
      includeTransactionData: true,
      includeCustomerData: true,
      includeProductData: true,
      includeSettingsData: true,
    );
  }

  BackupSettings copyWith({
    bool? autoBackupEnabled,
    int? autoBackupIntervalDays,
    String? lastBackupDate,
    String? backupLocation,
    bool? includeTransactionData,
    bool? includeCustomerData,
    bool? includeProductData,
    bool? includeSettingsData,
  }) {
    return BackupSettings(
      autoBackupEnabled: autoBackupEnabled ?? this.autoBackupEnabled,
      autoBackupIntervalDays: autoBackupIntervalDays ?? this.autoBackupIntervalDays,
      lastBackupDate: lastBackupDate ?? this.lastBackupDate,
      backupLocation: backupLocation ?? this.backupLocation,
      includeTransactionData: includeTransactionData ?? this.includeTransactionData,
      includeCustomerData: includeCustomerData ?? this.includeCustomerData,
      includeProductData: includeProductData ?? this.includeProductData,
      includeSettingsData: includeSettingsData ?? this.includeSettingsData,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BackupSettings &&
        other.autoBackupEnabled == autoBackupEnabled &&
        other.autoBackupIntervalDays == autoBackupIntervalDays &&
        other.lastBackupDate == lastBackupDate &&
        other.backupLocation == backupLocation &&
        other.includeTransactionData == includeTransactionData &&
        other.includeCustomerData == includeCustomerData &&
        other.includeProductData == includeProductData &&
        other.includeSettingsData == includeSettingsData;
  }

  @override
  int get hashCode {
    return Object.hash(
      autoBackupEnabled,
      autoBackupIntervalDays,
      lastBackupDate,
      backupLocation,
      includeTransactionData,
      includeCustomerData,
      includeProductData,
      includeSettingsData,
    );
  }
}
