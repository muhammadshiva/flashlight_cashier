import 'dart:io';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';
import '../models/printer_device_model.dart';

abstract class PrinterDataSource {
  Future<List<PrinterDeviceModel>> scanPairedDevices();
  Future<bool> connectToDevice(String macAddress);
  Future<void> disconnectDevice();
  Future<bool> isBluetoothEnabled();
}

class PrinterDataSourceImpl implements PrinterDataSource {
  @override
  Future<List<PrinterDeviceModel>> scanPairedDevices() async {
    try {
      // Check if platform is mobile
      if (!Platform.isAndroid && !Platform.isIOS) {
        throw UnsupportedError('Bluetooth printer is only supported on Android and iOS');
      }

      // Get paired Bluetooth devices
      final List<BluetoothInfo> devices = await PrintBluetoothThermal.pairedBluetooths;

      // Convert to model
      return devices.map((device) => PrinterDeviceModel.fromBluetoothInfo(device)).toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> connectToDevice(String macAddress) async {
    try {
      final bool connected = await PrintBluetoothThermal.connect(macPrinterAddress: macAddress);
      return connected;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> disconnectDevice() async {
    try {
      await PrintBluetoothThermal.disconnect;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> isBluetoothEnabled() async {
    try {
      // Check if platform is mobile
      if (!Platform.isAndroid && !Platform.isIOS) {
        return false;
      }

      final bool isOn = await PrintBluetoothThermal.bluetoothEnabled;
      return isOn;
    } catch (e) {
      return false;
    }
  }
}
