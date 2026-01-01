/// Domain Entity for Receipt Settings
class ReceiptSettings {
  final bool showLogo;
  final bool showTaxDetails;
  final bool showFooterMessage;
  final String footerMessage;
  final String receiptHeader;

  const ReceiptSettings({
    required this.showLogo,
    required this.showTaxDetails,
    required this.showFooterMessage,
    required this.footerMessage,
    required this.receiptHeader,
  });

  factory ReceiptSettings.initial() {
    return const ReceiptSettings(
      showLogo: true,
      showTaxDetails: true,
      showFooterMessage: true,
      footerMessage: 'Thank you for your purchase!',
      receiptHeader: 'RECEIPT',
    );
  }

  ReceiptSettings copyWith({
    bool? showLogo,
    bool? showTaxDetails,
    bool? showFooterMessage,
    String? footerMessage,
    String? receiptHeader,
  }) {
    return ReceiptSettings(
      showLogo: showLogo ?? this.showLogo,
      showTaxDetails: showTaxDetails ?? this.showTaxDetails,
      showFooterMessage: showFooterMessage ?? this.showFooterMessage,
      footerMessage: footerMessage ?? this.footerMessage,
      receiptHeader: receiptHeader ?? this.receiptHeader,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ReceiptSettings &&
        other.showLogo == showLogo &&
        other.showTaxDetails == showTaxDetails &&
        other.showFooterMessage == showFooterMessage &&
        other.footerMessage == footerMessage &&
        other.receiptHeader == receiptHeader;
  }

  @override
  int get hashCode {
    return Object.hash(
      showLogo,
      showTaxDetails,
      showFooterMessage,
      footerMessage,
      receiptHeader,
    );
  }
}
