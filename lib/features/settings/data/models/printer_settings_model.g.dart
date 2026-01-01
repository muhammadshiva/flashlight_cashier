// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'printer_settings_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PrinterSettingsModel _$PrinterSettingsModelFromJson(
        Map<String, dynamic> json) =>
    _PrinterSettingsModel(
      bluetoothEnabled: json['bluetoothEnabled'] as bool,
      connectedPrinterName: json['connectedPrinterName'] as String?,
      connectedPrinterMac: json['connectedPrinterMac'] as String?,
      paperSize: json['paperSize'] as String,
      autoPrintReceipt: json['autoPrintReceipt'] as bool,
      printLogo: json['printLogo'] as bool,
    );

Map<String, dynamic> _$PrinterSettingsModelToJson(
        _PrinterSettingsModel instance) =>
    <String, dynamic>{
      'bluetoothEnabled': instance.bluetoothEnabled,
      'connectedPrinterName': instance.connectedPrinterName,
      'connectedPrinterMac': instance.connectedPrinterMac,
      'paperSize': instance.paperSize,
      'autoPrintReceipt': instance.autoPrintReceipt,
      'printLogo': instance.printLogo,
    };
