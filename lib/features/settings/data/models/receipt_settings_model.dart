import 'package:equatable/equatable.dart';

import '../../domain/entities/receipt_settings.dart';

/// Receipt Settings Model
///
/// Data layer model for receipt settings with JSON serialization
/// Uses manual implementation without Freezed code generation
class ReceiptSettingsModel extends Equatable {
  final bool showLogo;
  final bool showTaxDetails;
  final bool showDiscount;
  final bool showPaymentMethod;
  final bool showFooterMessage;
  final String footerMessage;
  final String receiptHeader;

  const ReceiptSettingsModel({
    required this.showLogo,
    required this.showTaxDetails,
    required this.showDiscount,
    required this.showPaymentMethod,
    required this.showFooterMessage,
    required this.footerMessage,
    required this.receiptHeader,
  });

  /// Create model from JSON
  factory ReceiptSettingsModel.fromJson(Map<String, dynamic> json) {
    return ReceiptSettingsModel(
      showLogo: json['showLogo'] as bool,
      showTaxDetails: json['showTaxDetails'] as bool,
      showDiscount: json['showDiscount'] as bool,
      showPaymentMethod: json['showPaymentMethod'] as bool,
      showFooterMessage: json['showFooterMessage'] as bool,
      footerMessage: json['footerMessage'] as String,
      receiptHeader: json['receiptHeader'] as String,
    );
  }

  /// Convert model to JSON
  Map<String, dynamic> toJson() {
    return {
      'showLogo': showLogo,
      'showTaxDetails': showTaxDetails,
      'showDiscount': showDiscount,
      'showPaymentMethod': showPaymentMethod,
      'showFooterMessage': showFooterMessage,
      'footerMessage': footerMessage,
      'receiptHeader': receiptHeader,
    };
  }

  /// Create model from domain entity
  factory ReceiptSettingsModel.fromEntity(ReceiptSettings entity) {
    return ReceiptSettingsModel(
      showLogo: entity.showLogo,
      showTaxDetails: entity.showTaxDetails,
      showDiscount: entity.showDiscount,
      showPaymentMethod: entity.showPaymentMethod,
      showFooterMessage: entity.showFooterMessage,
      footerMessage: entity.footerMessage,
      receiptHeader: entity.receiptHeader,
    );
  }

  /// Convert model to domain entity
  ReceiptSettings toEntity() {
    return ReceiptSettings(
      showLogo: showLogo,
      showTaxDetails: showTaxDetails,
      showDiscount: showDiscount,
      showPaymentMethod: showPaymentMethod,
      showFooterMessage: showFooterMessage,
      footerMessage: footerMessage,
      receiptHeader: receiptHeader,
    );
  }

  /// Create a copy with updated fields
  ReceiptSettingsModel copyWith({
    bool? showLogo,
    bool? showTaxDetails,
    bool? showDiscount,
    bool? showPaymentMethod,
    bool? showFooterMessage,
    String? footerMessage,
    String? receiptHeader,
  }) {
    return ReceiptSettingsModel(
      showLogo: showLogo ?? this.showLogo,
      showTaxDetails: showTaxDetails ?? this.showTaxDetails,
      showDiscount: showDiscount ?? this.showDiscount,
      showPaymentMethod: showPaymentMethod ?? this.showPaymentMethod,
      showFooterMessage: showFooterMessage ?? this.showFooterMessage,
      footerMessage: footerMessage ?? this.footerMessage,
      receiptHeader: receiptHeader ?? this.receiptHeader,
    );
  }

  @override
  List<Object?> get props => [
        showLogo,
        showTaxDetails,
        showDiscount,
        showPaymentMethod,
        showFooterMessage,
        footerMessage,
        receiptHeader,
      ];
}
