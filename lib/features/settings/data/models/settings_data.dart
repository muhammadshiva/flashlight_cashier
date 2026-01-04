import 'package:equatable/equatable.dart';
import 'package:flashlight_pos/features/settings/data/models/app_settings_model.dart';
import 'package:flashlight_pos/features/settings/data/models/notification_settings_model.dart';
import 'package:flashlight_pos/features/settings/data/models/printer_settings_model.dart';
import 'package:flashlight_pos/features/settings/data/models/receipt_settings_model.dart';
import 'package:flashlight_pos/features/settings/data/models/security_settings_model.dart';
import 'package:flashlight_pos/features/settings/domain/entities/app_settings.dart';
import 'package:flashlight_pos/features/settings/domain/entities/notification_settings.dart';
import 'package:flashlight_pos/features/settings/domain/entities/printer_settings.dart';
import 'package:flashlight_pos/features/settings/domain/entities/receipt_settings.dart';
import 'package:flashlight_pos/features/settings/domain/entities/security_settings.dart';

/// Persistent settings data that will be saved to storage
/// This wraps all settings entities for hydrated bloc persistence
/// Uses Models internally for JSON serialization
class SettingsData extends Equatable {
  final AppSettings appSettings;
  final PrinterSettings printerSettings;
  final ReceiptSettings receiptSettings;
  final NotificationSettings notificationSettings;
  final SecuritySettings securitySettings;

  const SettingsData({
    required this.appSettings,
    required this.printerSettings,
    required this.receiptSettings,
    required this.notificationSettings,
    required this.securitySettings,
  });

  factory SettingsData.initial() => SettingsData(
        appSettings: AppSettings.initial(),
        printerSettings: PrinterSettings.initial(),
        receiptSettings: ReceiptSettings.initial(),
        notificationSettings: NotificationSettings.initial(),
        securitySettings: SecuritySettings.initial(),
      );

  @override
  List<Object?> get props => [
        appSettings,
        printerSettings,
        receiptSettings,
        notificationSettings,
        securitySettings,
      ];

  SettingsData copyWith({
    AppSettings? appSettings,
    PrinterSettings? printerSettings,
    ReceiptSettings? receiptSettings,
    NotificationSettings? notificationSettings,
    SecuritySettings? securitySettings,
  }) {
    return SettingsData(
      appSettings: appSettings ?? this.appSettings,
      printerSettings: printerSettings ?? this.printerSettings,
      receiptSettings: receiptSettings ?? this.receiptSettings,
      notificationSettings: notificationSettings ?? this.notificationSettings,
      securitySettings: securitySettings ?? this.securitySettings,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'appSettings': AppSettingsModel.fromEntity(appSettings).toJson(),
      'printerSettings': PrinterSettingsModel.fromEntity(printerSettings).toJson(),
      'receiptSettings': ReceiptSettingsModel.fromEntity(receiptSettings).toJson(),
      'notificationSettings': NotificationSettingsModel.fromEntity(notificationSettings).toJson(),
      'securitySettings': SecuritySettingsModel.fromEntity(securitySettings).toJson(),
    };
  }

  factory SettingsData.fromJson(Map<String, dynamic> json) {
    try {
      return SettingsData(
        appSettings: AppSettingsModel.fromJson(json['appSettings'] as Map<String, dynamic>).toEntity(),
        printerSettings: PrinterSettingsModel.fromJson(json['printerSettings'] as Map<String, dynamic>).toEntity(),
        receiptSettings: ReceiptSettingsModel.fromJson(json['receiptSettings'] as Map<String, dynamic>).toEntity(),
        notificationSettings: NotificationSettingsModel.fromJson(json['notificationSettings'] as Map<String, dynamic>).toEntity(),
        securitySettings: SecuritySettingsModel.fromJson(json['securitySettings'] as Map<String, dynamic>).toEntity(),
      );
    } catch (e) {
      // If any error occurs during deserialization, return initial state
      return SettingsData.initial();
    }
  }
}
