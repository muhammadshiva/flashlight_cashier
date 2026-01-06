import 'dart:convert';
import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/receipt_settings.dart';
import '../models/app_settings_model.dart';
import '../models/notification_settings_model.dart';
import '../models/printer_settings_model.dart';
import '../models/receipt_settings_model.dart';
import '../models/security_settings_model.dart';
import '../models/backup_settings_model.dart';

abstract class SettingsLocalDataSource {
  Future<AppSettingsModel> getAppSettings();
  Future<void> saveAppSettings(AppSettingsModel settings);

  Future<PrinterSettingsModel> getPrinterSettings();
  Future<void> savePrinterSettings(PrinterSettingsModel settings);

  Future<ReceiptSettingsModel> getReceiptSettings();
  Future<void> saveReceiptSettings(ReceiptSettingsModel settings);

  Future<NotificationSettingsModel> getNotificationSettings();
  Future<void> saveNotificationSettings(NotificationSettingsModel settings);

  Future<SecuritySettingsModel> getSecuritySettings();
  Future<void> saveSecuritySettings(SecuritySettingsModel settings);

  Future<BackupSettingsModel> getBackupSettings();
  Future<void> saveBackupSettings(BackupSettingsModel settings);
}

class SettingsLocalDataSourceImpl implements SettingsLocalDataSource {
  final SharedPreferences sharedPreferences;

  static const String _keyAppSettings = 'APP_SETTINGS';
  static const String _keyPrinterSettings = 'PRINTER_SETTINGS';
  static const String _keyReceiptSettings = 'RECEIPT_SETTINGS';
  static const String _keyNotificationSettings = 'NOTIFICATION_SETTINGS';
  static const String _keySecuritySettings = 'SECURITY_SETTINGS';
  static const String _keyBackupSettings = 'BACKUP_SETTINGS';

  SettingsLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<AppSettingsModel> getAppSettings() async {
    try {
      final jsonString = sharedPreferences.getString(_keyAppSettings);
      if (jsonString != null) {
        return AppSettingsModel.fromJson(json.decode(jsonString));
      } else {
        // Return default settings if not found
        return AppSettingsModel.fromEntity(
          const AppSettingsModel(
            storeName: 'Mocca POS',
            storeAddress: 'Jl. Merdeka No. 123, Jakarta',
            storePhone: '+62 21 1234 5678',
            storeEmail: 'info@moccapos.com',
            taxRate: 11.0,
            autoCalculateTax: true,
            autoPrintReceipt: true,
            language: 'id_ID',
            region: 'Indonesia',
            currencySymbol: 'Rp',
            currencyCode: 'IDR',
            decimalPlaces: 2,
            theme: 'light',
            fontSize: 14.0,
          ).toEntity(),
        );
      }
    } on Exception catch (e, stackTrace) {
      log("Error: $e", error: e, stackTrace: stackTrace);
      return AppSettingsModel.fromEntity(
        const AppSettingsModel(
          storeName: 'Mocca POS',
          storeAddress: 'Jl. Merdeka No. 123, Jakarta',
          storePhone: '+62 21 1234 5678',
          storeEmail: 'info@moccapos.com',
          taxRate: 11.0,
          autoCalculateTax: true,
          autoPrintReceipt: true,
          language: 'id_ID',
          region: 'Indonesia',
          currencySymbol: 'Rp',
          currencyCode: 'IDR',
          decimalPlaces: 2,
          theme: 'light',
          fontSize: 14.0,
        ).toEntity(),
      );
    }
  }

  @override
  Future<void> saveAppSettings(AppSettingsModel settings) async {
    await sharedPreferences.setString(
      _keyAppSettings,
      json.encode(settings.toJson()),
    );
  }

  @override
  Future<PrinterSettingsModel> getPrinterSettings() async {
    final jsonString = sharedPreferences.getString(_keyPrinterSettings);
    if (jsonString != null) {
      return PrinterSettingsModel.fromJson(json.decode(jsonString));
    } else {
      return PrinterSettingsModel.fromEntity(
        const PrinterSettingsModel(
          bluetoothEnabled: false,
          connectedPrinterName: null,
          connectedPrinterMac: null,
          paperSize: '58mm',
          autoPrintReceipt: true,
        ).toEntity(),
      );
    }
  }

  @override
  Future<void> savePrinterSettings(PrinterSettingsModel settings) async {
    await sharedPreferences.setString(
      _keyPrinterSettings,
      json.encode(settings.toJson()),
    );
  }

  @override
  Future<ReceiptSettingsModel> getReceiptSettings() async {
    final jsonString = sharedPreferences.getString(_keyReceiptSettings);
    if (jsonString != null) {
      return ReceiptSettingsModel.fromJson(json.decode(jsonString));
    } else {
      return ReceiptSettingsModel.fromEntity(
        const ReceiptSettings(
          showLogo: true,
          showTaxDetails: true,
          showDiscount: true,
          showPaymentMethod: true,
          showFooterMessage: true,
          footerMessage: 'Thank you for your purchase!',
          receiptHeader: 'RECEIPT',
        ),
      );
    }
  }

  @override
  Future<void> saveReceiptSettings(ReceiptSettingsModel settings) async {
    await sharedPreferences.setString(
      _keyReceiptSettings,
      json.encode(settings.toJson()),
    );
  }

  @override
  Future<NotificationSettingsModel> getNotificationSettings() async {
    final jsonString = sharedPreferences.getString(_keyNotificationSettings);
    if (jsonString != null) {
      return NotificationSettingsModel.fromJson(json.decode(jsonString));
    } else {
      return NotificationSettingsModel.fromEntity(
        const NotificationSettingsModel(
          enableNotifications: true,
          enableSoundAlerts: true,
          notifyOnLowStock: true,
          notifyOnNewOrder: true,
          notifyOnPaymentReceived: true,
        ).toEntity(),
      );
    }
  }

  @override
  Future<void> saveNotificationSettings(NotificationSettingsModel settings) async {
    await sharedPreferences.setString(
      _keyNotificationSettings,
      json.encode(settings.toJson()),
    );
  }

  @override
  Future<SecuritySettingsModel> getSecuritySettings() async {
    final jsonString = sharedPreferences.getString(_keySecuritySettings);
    if (jsonString != null) {
      return SecuritySettingsModel.fromJson(json.decode(jsonString));
    } else {
      return SecuritySettingsModel.fromEntity(
        const SecuritySettingsModel(
          requirePinForRefund: true,
          requirePinForDiscount: true,
          requirePinForVoid: true,
          autoLockAfterInactivity: false,
          autoLockDurationMinutes: 15,
        ).toEntity(),
      );
    }
  }

  @override
  Future<void> saveSecuritySettings(SecuritySettingsModel settings) async {
    await sharedPreferences.setString(
      _keySecuritySettings,
      json.encode(settings.toJson()),
    );
  }

  @override
  Future<BackupSettingsModel> getBackupSettings() async {
    final jsonString = sharedPreferences.getString(_keyBackupSettings);
    if (jsonString != null) {
      return BackupSettingsModel.fromJson(json.decode(jsonString));
    } else {
      return BackupSettingsModel.fromEntity(
        const BackupSettingsModel(
          autoBackupEnabled: false,
          autoBackupIntervalDays: 7,
          lastBackupDate: null,
          backupLocation: null,
          includeTransactionData: true,
          includeCustomerData: true,
          includeProductData: true,
          includeSettingsData: true,
        ).toEntity(),
      );
    }
  }

  @override
  Future<void> saveBackupSettings(BackupSettingsModel settings) async {
    await sharedPreferences.setString(
      _keyBackupSettings,
      json.encode(settings.toJson()),
    );
  }
}
