import 'package:dartz/dartz.dart';
import 'package:flashlight_pos/core/error/failures.dart';
import 'package:flashlight_pos/features/settings/domain/entities/app_settings.dart';
import 'package:flashlight_pos/features/settings/domain/entities/backup_settings.dart';
import 'package:flashlight_pos/features/settings/domain/entities/notification_settings.dart';
import 'package:flashlight_pos/features/settings/domain/entities/printer_device.dart';
import 'package:flashlight_pos/features/settings/domain/entities/printer_settings.dart';
import 'package:flashlight_pos/features/settings/domain/entities/receipt_settings.dart';
import 'package:flashlight_pos/features/settings/domain/entities/security_settings.dart';

/// Repository interface for Settings
/// Follows clean architecture pattern - implementations in data layer
abstract class SettingsRepository {
  // App Settings
  Future<Either<Failure, AppSettings>> getAppSettings();
  Future<Either<Failure, Unit>> updateAppSettings(AppSettings settings);

  // Printer Settings
  Future<Either<Failure, PrinterSettings>> getPrinterSettings();
  Future<Either<Failure, Unit>> updatePrinterSettings(PrinterSettings settings);
  Future<Either<Failure, List<PrinterDevice>>> scanPrinters();
  Future<Either<Failure, bool>> connectPrinter(PrinterDevice device);
  Future<Either<Failure, Unit>> disconnectPrinter();
  Future<Either<Failure, bool>> isBluetoothEnabled();

  // Receipt Settings
  Future<Either<Failure, ReceiptSettings>> getReceiptSettings();
  Future<Either<Failure, Unit>> updateReceiptSettings(ReceiptSettings settings);

  // Notification Settings
  Future<Either<Failure, NotificationSettings>> getNotificationSettings();
  Future<Either<Failure, Unit>> updateNotificationSettings(NotificationSettings settings);

  // Security Settings
  Future<Either<Failure, SecuritySettings>> getSecuritySettings();
  Future<Either<Failure, Unit>> updateSecuritySettings(SecuritySettings settings);

  // Backup Settings
  Future<Either<Failure, BackupSettings>> getBackupSettings();
  Future<Either<Failure, Unit>> updateBackupSettings(BackupSettings settings);
  Future<Either<Failure, String>> createBackup(String backupPath);
  Future<Either<Failure, Unit>> restoreBackup(String backupPath);
}
