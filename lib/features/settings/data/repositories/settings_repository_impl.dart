import 'package:dartz/dartz.dart';
import 'package:flashlight_pos/core/error/failures.dart';
import 'package:flashlight_pos/features/settings/data/datasources/printer_datasource.dart';
import 'package:flashlight_pos/features/settings/data/datasources/settings_local_datasource.dart';
import 'package:flashlight_pos/features/settings/data/models/app_settings_model.dart';
import 'package:flashlight_pos/features/settings/data/models/notification_settings_model.dart';
import 'package:flashlight_pos/features/settings/data/models/printer_settings_model.dart';
import 'package:flashlight_pos/features/settings/data/models/receipt_settings_model.dart';
import 'package:flashlight_pos/features/settings/data/models/security_settings_model.dart';
import 'package:flashlight_pos/features/settings/domain/entities/app_settings.dart';
import 'package:flashlight_pos/features/settings/domain/entities/notification_settings.dart';
import 'package:flashlight_pos/features/settings/domain/entities/printer_device.dart';
import 'package:flashlight_pos/features/settings/domain/entities/printer_settings.dart';
import 'package:flashlight_pos/features/settings/domain/entities/receipt_settings.dart';
import 'package:flashlight_pos/features/settings/domain/entities/security_settings.dart';
import 'package:flashlight_pos/features/settings/domain/repositories/settings_repository.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsLocalDataSource localDataSource;
  final PrinterDataSource printerDataSource;

  SettingsRepositoryImpl({
    required this.localDataSource,
    required this.printerDataSource,
  });

  @override
  Future<Either<Failure, AppSettings>> getAppSettings() async {
    try {
      final model = await localDataSource.getAppSettings();
      return Right(model.toEntity());
    } catch (e) {
      return Left(CacheFailure('Failed to get app settings: $e'));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateAppSettings(AppSettings settings) async {
    try {
      final model = AppSettingsModel.fromEntity(settings);
      await localDataSource.saveAppSettings(model);
      return const Right(unit);
    } catch (e) {
      return Left(CacheFailure('Failed to update app settings: $e'));
    }
  }

  @override
  Future<Either<Failure, PrinterSettings>> getPrinterSettings() async {
    try {
      final model = await localDataSource.getPrinterSettings();
      return Right(model.toEntity());
    } catch (e) {
      return Left(CacheFailure('Failed to get printer settings: $e'));
    }
  }

  @override
  Future<Either<Failure, Unit>> updatePrinterSettings(PrinterSettings settings) async {
    try {
      final model = PrinterSettingsModel.fromEntity(settings);
      await localDataSource.savePrinterSettings(model);
      return const Right(unit);
    } catch (e) {
      return Left(CacheFailure('Failed to update printer settings: $e'));
    }
  }

  @override
  Future<Either<Failure, List<PrinterDevice>>> scanPrinters() async {
    try {
      final devices = await printerDataSource.scanPairedDevices();
      return Right(devices.map((model) => model.toEntity()).toList());
    } catch (e) {
      return Left(ServerFailure('Failed to scan printers: $e'));
    }
  }

  @override
  Future<Either<Failure, bool>> connectPrinter(PrinterDevice device) async {
    try {
      final connected = await printerDataSource.connectToDevice(device.macAddress);
      return Right(connected);
    } catch (e) {
      return Left(ServerFailure('Failed to connect printer: $e'));
    }
  }

  @override
  Future<Either<Failure, Unit>> disconnectPrinter() async {
    try {
      await printerDataSource.disconnectDevice();
      return const Right(unit);
    } catch (e) {
      return Left(ServerFailure('Failed to disconnect printer: $e'));
    }
  }

  @override
  Future<Either<Failure, bool>> isBluetoothEnabled() async {
    try {
      final isEnabled = await printerDataSource.isBluetoothEnabled();
      return Right(isEnabled);
    } catch (e) {
      return Left(ServerFailure('Failed to check Bluetooth status: $e'));
    }
  }

  @override
  Future<Either<Failure, ReceiptSettings>> getReceiptSettings() async {
    try {
      final model = await localDataSource.getReceiptSettings();
      return Right(model.toEntity());
    } catch (e) {
      return Left(CacheFailure('Failed to get receipt settings: $e'));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateReceiptSettings(ReceiptSettings settings) async {
    try {
      final model = ReceiptSettingsModel.fromEntity(settings);
      await localDataSource.saveReceiptSettings(model);
      return const Right(unit);
    } catch (e) {
      return Left(CacheFailure('Failed to update receipt settings: $e'));
    }
  }

  @override
  Future<Either<Failure, NotificationSettings>> getNotificationSettings() async {
    try {
      final model = await localDataSource.getNotificationSettings();
      return Right(model.toEntity());
    } catch (e) {
      return Left(CacheFailure('Failed to get notification settings: $e'));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateNotificationSettings(NotificationSettings settings) async {
    try {
      final model = NotificationSettingsModel.fromEntity(settings);
      await localDataSource.saveNotificationSettings(model);
      return const Right(unit);
    } catch (e) {
      return Left(CacheFailure('Failed to update notification settings: $e'));
    }
  }

  @override
  Future<Either<Failure, SecuritySettings>> getSecuritySettings() async {
    try {
      final model = await localDataSource.getSecuritySettings();
      return Right(model.toEntity());
    } catch (e) {
      return Left(CacheFailure('Failed to get security settings: $e'));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateSecuritySettings(SecuritySettings settings) async {
    try {
      final model = SecuritySettingsModel.fromEntity(settings);
      await localDataSource.saveSecuritySettings(model);
      return const Right(unit);
    } catch (e) {
      return Left(CacheFailure('Failed to update security settings: $e'));
    }
  }
}
