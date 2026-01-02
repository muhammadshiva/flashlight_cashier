// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/receipt_settings.dart';

part 'receipt_settings_model.freezed.dart';
part 'receipt_settings_model.g.dart';

@freezed
class ReceiptSettingsModel with _$ReceiptSettingsModel {
  const factory ReceiptSettingsModel({
    @JsonKey(name: "showLogo") required bool showLogo,
    @JsonKey(name: "showTaxDetails") required bool showTaxDetails,
    @JsonKey(name: "showDiscount") required bool showDiscount,
    @JsonKey(name: "showPaymentMethod") required bool showPaymentMethod,
    @JsonKey(name: "showFooterMessage") required bool showFooterMessage,
    @JsonKey(name: "footerMessage") required String footerMessage,
    @JsonKey(name: "receiptHeader") required String receiptHeader,
  }) = _ReceiptSettingsModel;

  factory ReceiptSettingsModel.fromJson(Map<String, dynamic> json) =>
      _$ReceiptSettingsModelFromJson(json);

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

  ReceiptSettings toEntity() => ReceiptSettings(
        showLogo: showLogo,
        showTaxDetails: showTaxDetails,
        showDiscount: showDiscount,
        showPaymentMethod: showPaymentMethod,
        showFooterMessage: showFooterMessage,
        footerMessage: footerMessage,
        receiptHeader: receiptHeader,
      );

  @override
  // TODO: implement footerMessage
  String get footerMessage => throw UnimplementedError();

  @override
  // TODO: implement receiptHeader
  String get receiptHeader => throw UnimplementedError();

  @override
  // TODO: implement showDiscount
  bool get showDiscount => throw UnimplementedError();

  @override
  // TODO: implement showFooterMessage
  bool get showFooterMessage => throw UnimplementedError();

  @override
  // TODO: implement showLogo
  bool get showLogo => throw UnimplementedError();

  @override
  // TODO: implement showPaymentMethod
  bool get showPaymentMethod => throw UnimplementedError();

  @override
  // TODO: implement showTaxDetails
  bool get showTaxDetails => throw UnimplementedError();

  @override
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }
}
