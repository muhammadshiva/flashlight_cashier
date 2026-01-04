import 'package:equatable/equatable.dart';

import '../../domain/entities/printer_settings.dart';

/// Printer Settings Model
///
/// Data layer model for printer settings with JSON serialization
/// Uses manual implementation without Freezed code generation
class PrinterSettingsModel extends Equatable {
  final bool bluetoothEnabled;
  final String? connectedPrinterName;
  final String? connectedPrinterMac;
  final String paperSize;
  final bool autoPrintReceipt;

  const PrinterSettingsModel({
    required this.bluetoothEnabled,
    this.connectedPrinterName,
    this.connectedPrinterMac,
    required this.paperSize,
    required this.autoPrintReceipt,
  });

  /// Create model from JSON
  factory PrinterSettingsModel.fromJson(Map<String, dynamic> json) {
    return PrinterSettingsModel(
      bluetoothEnabled: json['bluetoothEnabled'] as bool,
      connectedPrinterName: json['connectedPrinterName'] as String?,
      connectedPrinterMac: json['connectedPrinterMac'] as String?,
      paperSize: json['paperSize'] as String,
      autoPrintReceipt: json['autoPrintReceipt'] as bool,
    );
  }

  /// Convert model to JSON
  Map<String, dynamic> toJson() {
    return {
      'bluetoothEnabled': bluetoothEnabled,
      'connectedPrinterName': connectedPrinterName,
      'connectedPrinterMac': connectedPrinterMac,
      'paperSize': paperSize,
      'autoPrintReceipt': autoPrintReceipt,
    };
  }

  /// Create model from domain entity
  factory PrinterSettingsModel.fromEntity(PrinterSettings entity) {
    return PrinterSettingsModel(
      bluetoothEnabled: entity.bluetoothEnabled,
      connectedPrinterName: entity.connectedPrinterName,
      connectedPrinterMac: entity.connectedPrinterMac,
      paperSize: entity.paperSize,
      autoPrintReceipt: entity.autoPrintReceipt,
    );
  }

  /// Convert model to domain entity
  PrinterSettings toEntity() {
    return PrinterSettings(
      bluetoothEnabled: bluetoothEnabled,
      connectedPrinterName: connectedPrinterName,
      connectedPrinterMac: connectedPrinterMac,
      paperSize: paperSize,
      autoPrintReceipt: autoPrintReceipt,
    );
  }

  /// Create a copy with updated fields
  PrinterSettingsModel copyWith({
    bool? bluetoothEnabled,
    String? connectedPrinterName,
    String? connectedPrinterMac,
    String? paperSize,
    bool? autoPrintReceipt,
  }) {
    return PrinterSettingsModel(
      bluetoothEnabled: bluetoothEnabled ?? this.bluetoothEnabled,
      connectedPrinterName: connectedPrinterName ?? this.connectedPrinterName,
      connectedPrinterMac: connectedPrinterMac ?? this.connectedPrinterMac,
      paperSize: paperSize ?? this.paperSize,
      autoPrintReceipt: autoPrintReceipt ?? this.autoPrintReceipt,
    );
  }

  @override
  List<Object?> get props => [
        bluetoothEnabled,
        connectedPrinterName,
        connectedPrinterMac,
        paperSize,
        autoPrintReceipt,
      ];
}
