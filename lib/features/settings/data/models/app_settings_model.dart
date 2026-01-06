import 'package:equatable/equatable.dart';

import '../../domain/entities/app_settings.dart';

/// App Settings Model
///
/// Data layer model for app settings with JSON serialization
/// Uses manual implementation without Freezed code generation
class AppSettingsModel extends Equatable {
  final String storeName;
  final String storeAddress;
  final String storePhone;
  final String storeEmail;
  final double taxRate;
  final bool autoCalculateTax;
  final bool autoPrintReceipt;
  final String language;
  final String region;
  final String currencySymbol;
  final String currencyCode;
  final int decimalPlaces;
  final String theme;
  final double fontSize;

  const AppSettingsModel({
    required this.storeName,
    required this.storeAddress,
    required this.storePhone,
    required this.storeEmail,
    required this.taxRate,
    required this.autoCalculateTax,
    required this.autoPrintReceipt,
    required this.language,
    required this.region,
    required this.currencySymbol,
    required this.currencyCode,
    required this.decimalPlaces,
    required this.theme,
    required this.fontSize,
  });

  /// Create model from JSON
  factory AppSettingsModel.fromJson(Map<String, dynamic> json) {
    return AppSettingsModel(
      storeName: json['storeName'] as String,
      storeAddress: json['storeAddress'] as String,
      storePhone: json['storePhone'] as String,
      storeEmail: json['storeEmail'] as String,
      taxRate: (json['taxRate'] as num).toDouble(),
      autoCalculateTax: json['autoCalculateTax'] as bool,
      autoPrintReceipt: json['autoPrintReceipt'] as bool? ?? true,
      language: json['language'] as String,
      region: json['region'] as String,
      currencySymbol: json['currencySymbol'] as String,
      currencyCode: json['currencyCode'] as String? ?? 'IDR',
      decimalPlaces: json['decimalPlaces'] as int? ?? 2,
      theme: json['theme'] as String,
      fontSize: (json['fontSize'] as num).toDouble(),
    );
  }

  /// Convert model to JSON
  Map<String, dynamic> toJson() {
    return {
      'storeName': storeName,
      'storeAddress': storeAddress,
      'storePhone': storePhone,
      'storeEmail': storeEmail,
      'taxRate': taxRate,
      'autoCalculateTax': autoCalculateTax,
      'autoPrintReceipt': autoPrintReceipt,
      'language': language,
      'region': region,
      'currencySymbol': currencySymbol,
      'currencyCode': currencyCode,
      'decimalPlaces': decimalPlaces,
      'theme': theme,
      'fontSize': fontSize,
    };
  }

  /// Create model from domain entity
  factory AppSettingsModel.fromEntity(AppSettings entity) {
    return AppSettingsModel(
      storeName: entity.storeName,
      storeAddress: entity.storeAddress,
      storePhone: entity.storePhone,
      storeEmail: entity.storeEmail,
      taxRate: entity.taxRate,
      autoCalculateTax: entity.autoCalculateTax,
      autoPrintReceipt: entity.autoPrintReceipt,
      language: entity.language,
      region: entity.region,
      currencySymbol: entity.currencySymbol,
      currencyCode: entity.currencyCode,
      decimalPlaces: entity.decimalPlaces,
      theme: entity.theme,
      fontSize: entity.fontSize,
    );
  }

  /// Convert model to domain entity
  AppSettings toEntity() {
    return AppSettings(
      storeName: storeName,
      storeAddress: storeAddress,
      storePhone: storePhone,
      storeEmail: storeEmail,
      taxRate: taxRate,
      autoCalculateTax: autoCalculateTax,
      autoPrintReceipt: autoPrintReceipt,
      language: language,
      region: region,
      currencySymbol: currencySymbol,
      currencyCode: currencyCode,
      decimalPlaces: decimalPlaces,
      theme: theme,
      fontSize: fontSize,
    );
  }

  /// Create a copy with updated fields
  AppSettingsModel copyWith({
    String? storeName,
    String? storeAddress,
    String? storePhone,
    String? storeEmail,
    double? taxRate,
    bool? autoCalculateTax,
    bool? autoPrintReceipt,
    String? language,
    String? region,
    String? currencySymbol,
    String? currencyCode,
    int? decimalPlaces,
    String? theme,
    double? fontSize,
  }) {
    return AppSettingsModel(
      storeName: storeName ?? this.storeName,
      storeAddress: storeAddress ?? this.storeAddress,
      storePhone: storePhone ?? this.storePhone,
      storeEmail: storeEmail ?? this.storeEmail,
      taxRate: taxRate ?? this.taxRate,
      autoCalculateTax: autoCalculateTax ?? this.autoCalculateTax,
      autoPrintReceipt: autoPrintReceipt ?? this.autoPrintReceipt,
      language: language ?? this.language,
      region: region ?? this.region,
      currencySymbol: currencySymbol ?? this.currencySymbol,
      currencyCode: currencyCode ?? this.currencyCode,
      decimalPlaces: decimalPlaces ?? this.decimalPlaces,
      theme: theme ?? this.theme,
      fontSize: fontSize ?? this.fontSize,
    );
  }

  @override
  List<Object?> get props => [
        storeName,
        storeAddress,
        storePhone,
        storeEmail,
        taxRate,
        autoCalculateTax,
        autoPrintReceipt,
        language,
        region,
        currencySymbol,
        currencyCode,
        decimalPlaces,
        theme,
        fontSize,
      ];
}
