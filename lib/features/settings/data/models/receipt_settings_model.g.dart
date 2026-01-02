// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'receipt_settings_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ReceiptSettingsModel _$ReceiptSettingsModelFromJson(
        Map<String, dynamic> json) =>
    _ReceiptSettingsModel(
      showLogo: json['showLogo'] as bool,
      showTaxDetails: json['showTaxDetails'] as bool,
      showDiscount: json['showDiscount'] as bool,
      showPaymentMethod: json['showPaymentMethod'] as bool,
      showFooterMessage: json['showFooterMessage'] as bool,
      footerMessage: json['footerMessage'] as String,
      receiptHeader: json['receiptHeader'] as String,
    );

Map<String, dynamic> _$ReceiptSettingsModelToJson(
        _ReceiptSettingsModel instance) =>
    <String, dynamic>{
      'showLogo': instance.showLogo,
      'showTaxDetails': instance.showTaxDetails,
      'showDiscount': instance.showDiscount,
      'showPaymentMethod': instance.showPaymentMethod,
      'showFooterMessage': instance.showFooterMessage,
      'footerMessage': instance.footerMessage,
      'receiptHeader': instance.receiptHeader,
    };
