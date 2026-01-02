import 'package:flashlight_pos/features/settings/data/models/app_settings_model.dart';
import 'package:flashlight_pos/features/settings/data/models/notification_settings_model.dart';
import 'package:flashlight_pos/features/settings/data/models/printer_device_model.dart';
import 'package:flashlight_pos/features/settings/data/models/printer_settings_model.dart';
import 'package:flashlight_pos/features/settings/data/models/receipt_settings_model.dart';
import 'package:flashlight_pos/features/settings/data/models/security_settings_model.dart';
import 'package:flashlight_pos/features/settings/domain/entities/app_settings.dart';
import 'package:flashlight_pos/features/settings/domain/entities/notification_settings.dart';
import 'package:flashlight_pos/features/settings/domain/entities/printer_device.dart';
import 'package:flashlight_pos/features/settings/domain/entities/printer_settings.dart';
import 'package:flashlight_pos/features/settings/domain/entities/receipt_settings.dart';
import 'package:flashlight_pos/features/settings/domain/entities/security_settings.dart';
import 'package:json_annotation/json_annotation.dart';

/// JSON Converter for AppSettings
class AppSettingsConverter implements JsonConverter<AppSettings, Map<String, dynamic>> {
  const AppSettingsConverter();

  @override
  AppSettings fromJson(Map<String, dynamic> json) {
    return AppSettingsModel.fromJson(json).toEntity();
  }

  @override
  Map<String, dynamic> toJson(AppSettings object) {
    return AppSettingsModel.fromEntity(object).toJson();
  }
}

/// JSON Converter for PrinterSettings
class PrinterSettingsConverter implements JsonConverter<PrinterSettings, Map<String, dynamic>> {
  const PrinterSettingsConverter();

  @override
  PrinterSettings fromJson(Map<String, dynamic> json) {
    return PrinterSettingsModel.fromJson(json).toEntity();
  }

  @override
  Map<String, dynamic> toJson(PrinterSettings object) {
    return PrinterSettingsModel.fromEntity(object).toJson();
  }
}

/// JSON Converter for ReceiptSettings
class ReceiptSettingsConverter implements JsonConverter<ReceiptSettings, Map<String, dynamic>> {
  const ReceiptSettingsConverter();

  @override
  ReceiptSettings fromJson(Map<String, dynamic> json) {
    return ReceiptSettingsModel.fromJson(json).toEntity();
  }

  @override
  Map<String, dynamic> toJson(ReceiptSettings object) {
    return ReceiptSettingsModel.fromEntity(object).toJson();
  }
}

/// JSON Converter for NotificationSettings
class NotificationSettingsConverter implements JsonConverter<NotificationSettings, Map<String, dynamic>> {
  const NotificationSettingsConverter();

  @override
  NotificationSettings fromJson(Map<String, dynamic> json) {
    return NotificationSettingsModel.fromJson(json).toEntity();
  }

  @override
  Map<String, dynamic> toJson(NotificationSettings object) {
    return NotificationSettingsModel.fromEntity(object).toJson();
  }
}

/// JSON Converter for SecuritySettings
class SecuritySettingsConverter implements JsonConverter<SecuritySettings, Map<String, dynamic>> {
  const SecuritySettingsConverter();

  @override
  SecuritySettings fromJson(Map<String, dynamic> json) {
    return SecuritySettingsModel.fromJson(json).toEntity();
  }

  @override
  Map<String, dynamic> toJson(SecuritySettings object) {
    return SecuritySettingsModel.fromEntity(object).toJson();
  }
}

/// JSON Converter for PrinterDevice
class PrinterDeviceConverter implements JsonConverter<PrinterDevice, Map<String, dynamic>> {
  const PrinterDeviceConverter();

  @override
  PrinterDevice fromJson(Map<String, dynamic> json) {
    return PrinterDeviceModel.fromJson(json).toEntity();
  }

  @override
  Map<String, dynamic> toJson(PrinterDevice object) {
    return PrinterDeviceModel.fromEntity(object).toJson();
  }
}

/// JSON Converter for List<PrinterDevice>
class PrinterDeviceListConverter implements JsonConverter<List<PrinterDevice>, List<dynamic>> {
  const PrinterDeviceListConverter();

  @override
  List<PrinterDevice> fromJson(List<dynamic> json) {
    return json.map((e) => PrinterDeviceModel.fromJson(e as Map<String, dynamic>).toEntity()).toList();
  }

  @override
  List<dynamic> toJson(List<PrinterDevice> object) {
    return object.map((e) => PrinterDeviceModel.fromEntity(e).toJson()).toList();
  }
}
