// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/printer_settings.dart';

part 'printer_settings_model.freezed.dart';
part 'printer_settings_model.g.dart';

@freezed
class PrinterSettingsModel with _$PrinterSettingsModel {
  const PrinterSettingsModel._();

  const factory PrinterSettingsModel({
    @JsonKey(name: "bluetoothEnabled") required bool bluetoothEnabled,
    @JsonKey(name: "connectedPrinterName") String? connectedPrinterName,
    @JsonKey(name: "connectedPrinterMac") String? connectedPrinterMac,
    @JsonKey(name: "paperSize") required String paperSize,
    @JsonKey(name: "autoPrintReceipt") required bool autoPrintReceipt,
    @JsonKey(name: "printLogo") required bool printLogo,
  }) = _PrinterSettingsModel;

  factory PrinterSettingsModel.fromJson(Map<String, dynamic> json) =>
      _$PrinterSettingsModelFromJson(json);

  factory PrinterSettingsModel.fromEntity(PrinterSettings entity) {
    return PrinterSettingsModel(
      bluetoothEnabled: entity.bluetoothEnabled,
      connectedPrinterName: entity.connectedPrinterName,
      connectedPrinterMac: entity.connectedPrinterMac,
      paperSize: entity.paperSize,
      autoPrintReceipt: entity.autoPrintReceipt,
      printLogo: entity.printLogo,
    );
  }

  PrinterSettings toEntity() => PrinterSettings(
        bluetoothEnabled: bluetoothEnabled,
        connectedPrinterName: connectedPrinterName,
        connectedPrinterMac: connectedPrinterMac,
        paperSize: paperSize,
        autoPrintReceipt: autoPrintReceipt,
        printLogo: printLogo,
      );

  @override
  // TODO: implement autoPrintReceipt
  bool get autoPrintReceipt => throw UnimplementedError();

  @override
  // TODO: implement bluetoothEnabled
  bool get bluetoothEnabled => throw UnimplementedError();

  @override
  // TODO: implement connectedPrinterMac
  String? get connectedPrinterMac => throw UnimplementedError();

  @override
  // TODO: implement connectedPrinterName
  String? get connectedPrinterName => throw UnimplementedError();

  @override
  // TODO: implement paperSize
  String get paperSize => throw UnimplementedError();

  @override
  // TODO: implement printLogo
  bool get printLogo => throw UnimplementedError();

  @override
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }
}
