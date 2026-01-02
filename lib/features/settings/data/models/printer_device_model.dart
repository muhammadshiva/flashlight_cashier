// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';

import '../../domain/entities/printer_device.dart';

part 'printer_device_model.freezed.dart';
part 'printer_device_model.g.dart';

@freezed
class PrinterDeviceModel with _$PrinterDeviceModel {
  const PrinterDeviceModel._();

  const factory PrinterDeviceModel({
    @JsonKey(name: "name") required String name,
    @JsonKey(name: "macAddress") required String macAddress,
  }) = _PrinterDeviceModel;

  factory PrinterDeviceModel.fromJson(Map<String, dynamic> json) =>
      _$PrinterDeviceModelFromJson(json);

  factory PrinterDeviceModel.fromBluetoothInfo(BluetoothInfo bluetoothInfo) {
    return PrinterDeviceModel(
      name: bluetoothInfo.name,
      macAddress: bluetoothInfo.macAdress,
    );
  }

  factory PrinterDeviceModel.fromEntity(PrinterDevice entity) {
    return PrinterDeviceModel(
      name: entity.name,
      macAddress: entity.macAddress,
    );
  }

  PrinterDevice toEntity() => PrinterDevice(
        name: name,
        macAddress: macAddress,
      );

  @override
  // TODO: implement macAddress
  String get macAddress => throw UnimplementedError();

  @override
  // TODO: implement name
  String get name => throw UnimplementedError();

  @override
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }
}
