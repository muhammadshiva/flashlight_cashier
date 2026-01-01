/// Domain Entity for Bluetooth Printer Device
class PrinterDevice {
  final String name;
  final String macAddress;

  const PrinterDevice({
    required this.name,
    required this.macAddress,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PrinterDevice &&
        other.name == name &&
        other.macAddress == macAddress;
  }

  @override
  int get hashCode => Object.hash(name, macAddress);

  @override
  String toString() => 'PrinterDevice(name: $name, mac: $macAddress)';
}
