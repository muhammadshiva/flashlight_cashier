/// Domain Entity for Printer Settings
class PrinterSettings {
  final bool bluetoothEnabled;
  final String? connectedPrinterName;
  final String? connectedPrinterMac;
  final String paperSize; // '58mm' or '80mm'
  final bool autoPrintReceipt;
  final bool printLogo;

  const PrinterSettings({
    required this.bluetoothEnabled,
    this.connectedPrinterName,
    this.connectedPrinterMac,
    required this.paperSize,
    required this.autoPrintReceipt,
    required this.printLogo,
  });

  factory PrinterSettings.initial() {
    return const PrinterSettings(
      bluetoothEnabled: false,
      connectedPrinterName: null,
      connectedPrinterMac: null,
      paperSize: '58mm',
      autoPrintReceipt: true,
      printLogo: true,
    );
  }

  bool get isConnected => connectedPrinterName != null && connectedPrinterMac != null;

  PrinterSettings copyWith({
    bool? bluetoothEnabled,
    String? connectedPrinterName,
    String? connectedPrinterMac,
    String? paperSize,
    bool? autoPrintReceipt,
    bool? printLogo,
  }) {
    return PrinterSettings(
      bluetoothEnabled: bluetoothEnabled ?? this.bluetoothEnabled,
      connectedPrinterName: connectedPrinterName ?? this.connectedPrinterName,
      connectedPrinterMac: connectedPrinterMac ?? this.connectedPrinterMac,
      paperSize: paperSize ?? this.paperSize,
      autoPrintReceipt: autoPrintReceipt ?? this.autoPrintReceipt,
      printLogo: printLogo ?? this.printLogo,
    );
  }

  // Clear connected printer
  PrinterSettings clearConnection() {
    return PrinterSettings(
      bluetoothEnabled: bluetoothEnabled,
      connectedPrinterName: null,
      connectedPrinterMac: null,
      paperSize: paperSize,
      autoPrintReceipt: autoPrintReceipt,
      printLogo: printLogo,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PrinterSettings &&
        other.bluetoothEnabled == bluetoothEnabled &&
        other.connectedPrinterName == connectedPrinterName &&
        other.connectedPrinterMac == connectedPrinterMac &&
        other.paperSize == paperSize &&
        other.autoPrintReceipt == autoPrintReceipt &&
        other.printLogo == printLogo;
  }

  @override
  int get hashCode {
    return Object.hash(
      bluetoothEnabled,
      connectedPrinterName,
      connectedPrinterMac,
      paperSize,
      autoPrintReceipt,
      printLogo,
    );
  }
}
