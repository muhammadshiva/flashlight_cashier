import 'package:equatable/equatable.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';

import '../../domain/entities/printer_device.dart';

/// Printer Device Model
///
/// Data layer model for printer device with JSON serialization
/// Uses manual implementation without Freezed code generation
class PrinterDeviceModel extends Equatable {
  final String name;
  final String macAddress;

  const PrinterDeviceModel({
    required this.name,
    required this.macAddress,
  });

  /// Create model from JSON
  factory PrinterDeviceModel.fromJson(Map<String, dynamic> json) {
    return PrinterDeviceModel(
      name: json['name'] as String,
      macAddress: json['macAddress'] as String,
    );
  }

  /// Convert model to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'macAddress': macAddress,
    };
  }

  /// Create model from BluetoothInfo (from print_bluetooth_thermal package)
  factory PrinterDeviceModel.fromBluetoothInfo(BluetoothInfo bluetoothInfo) {
    return PrinterDeviceModel(
      name: bluetoothInfo.name,
      macAddress: bluetoothInfo.macAdress,
    );
  }

  /// Create model from domain entity
  factory PrinterDeviceModel.fromEntity(PrinterDevice entity) {
    return PrinterDeviceModel(
      name: entity.name,
      macAddress: entity.macAddress,
    );
  }

  /// Convert model to domain entity
  PrinterDevice toEntity() {
    return PrinterDevice(
      name: name,
      macAddress: macAddress,
    );
  }

  /// Create a copy with updated fields
  PrinterDeviceModel copyWith({
    String? name,
    String? macAddress,
  }) {
    return PrinterDeviceModel(
      name: name ?? this.name,
      macAddress: macAddress ?? this.macAddress,
    );
  }

  @override
  List<Object?> get props => [name, macAddress];
}
