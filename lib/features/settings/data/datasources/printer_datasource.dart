import 'dart:io';

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
      print("PrinterDataSourceImpl: Attempting to connect to $macAddress");
      // Force disconnect first to clear any stale connection states
      try {
        await PrintBluetoothThermal.disconnect;
        print("PrinterDataSourceImpl: Disconnect command sent before connecting.");
      } catch (e) {
        print("PrinterDataSourceImpl: Warning - failed to disconnect before connecting: $e");
      }

      final bool connected = await PrintBluetoothThermal.connect(macPrinterAddress: macAddress);
      print("PrinterDataSourceImpl: Connection result for $macAddress: $connected");
      return connected;
    } catch (e) {
      print("PrinterDataSourceImpl: Error connecting to $macAddress: $e");
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
