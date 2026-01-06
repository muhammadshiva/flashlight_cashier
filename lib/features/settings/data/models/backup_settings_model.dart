import 'package:equatable/equatable.dart';

import '../../domain/entities/backup_settings.dart';

/// Backup Settings Model
///
/// Data layer model for backup settings with JSON serialization
/// Uses manual implementation without Freezed code generation
class BackupSettingsModel extends Equatable {
  final bool autoBackupEnabled;
  final int autoBackupIntervalDays;
  final String? lastBackupDate;
  final String? backupLocation;
  final bool includeTransactionData;
  final bool includeCustomerData;
  final bool includeProductData;
  final bool includeSettingsData;

  const BackupSettingsModel({
    required this.autoBackupEnabled,
    required this.autoBackupIntervalDays,
    this.lastBackupDate,
    this.backupLocation,
    required this.includeTransactionData,
    required this.includeCustomerData,
    required this.includeProductData,
    required this.includeSettingsData,
  });

  /// Create model from JSON
  factory BackupSettingsModel.fromJson(Map<String, dynamic> json) {
    return BackupSettingsModel(
      autoBackupEnabled: json['autoBackupEnabled'] as bool,
      autoBackupIntervalDays: json['autoBackupIntervalDays'] as int,
      lastBackupDate: json['lastBackupDate'] as String?,
      backupLocation: json['backupLocation'] as String?,
      includeTransactionData: json['includeTransactionData'] as bool,
      includeCustomerData: json['includeCustomerData'] as bool,
      includeProductData: json['includeProductData'] as bool,
      includeSettingsData: json['includeSettingsData'] as bool,
    );
  }

  /// Convert model to JSON
  Map<String, dynamic> toJson() {
    return {
      'autoBackupEnabled': autoBackupEnabled,
      'autoBackupIntervalDays': autoBackupIntervalDays,
      'lastBackupDate': lastBackupDate,
      'backupLocation': backupLocation,
      'includeTransactionData': includeTransactionData,
      'includeCustomerData': includeCustomerData,
      'includeProductData': includeProductData,
      'includeSettingsData': includeSettingsData,
    };
  }

  /// Create model from domain entity
  factory BackupSettingsModel.fromEntity(BackupSettings entity) {
    return BackupSettingsModel(
      autoBackupEnabled: entity.autoBackupEnabled,
      autoBackupIntervalDays: entity.autoBackupIntervalDays,
      lastBackupDate: entity.lastBackupDate,
      backupLocation: entity.backupLocation,
      includeTransactionData: entity.includeTransactionData,
      includeCustomerData: entity.includeCustomerData,
      includeProductData: entity.includeProductData,
      includeSettingsData: entity.includeSettingsData,
    );
  }

  /// Convert model to domain entity
  BackupSettings toEntity() {
    return BackupSettings(
      autoBackupEnabled: autoBackupEnabled,
      autoBackupIntervalDays: autoBackupIntervalDays,
      lastBackupDate: lastBackupDate,
      backupLocation: backupLocation,
      includeTransactionData: includeTransactionData,
      includeCustomerData: includeCustomerData,
      includeProductData: includeProductData,
      includeSettingsData: includeSettingsData,
    );
  }

  /// Create a copy with updated fields
  BackupSettingsModel copyWith({
    bool? autoBackupEnabled,
    int? autoBackupIntervalDays,
    String? lastBackupDate,
    String? backupLocation,
    bool? includeTransactionData,
    bool? includeCustomerData,
    bool? includeProductData,
    bool? includeSettingsData,
  }) {
    return BackupSettingsModel(
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
  List<Object?> get props => [
        autoBackupEnabled,
        autoBackupIntervalDays,
        lastBackupDate,
        backupLocation,
        includeTransactionData,
        includeCustomerData,
        includeProductData,
        includeSettingsData,
      ];
}
