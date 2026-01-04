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
  final String language;
  final String region;
  final String currencySymbol;
  final String theme;
  final double fontSize;

  const AppSettingsModel({
    required this.storeName,
    required this.storeAddress,
    required this.storePhone,
    required this.storeEmail,
    required this.taxRate,
    required this.autoCalculateTax,
    required this.language,
    required this.region,
    required this.currencySymbol,
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
      language: json['language'] as String,
      region: json['region'] as String,
      currencySymbol: json['currencySymbol'] as String,
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
      'language': language,
      'region': region,
      'currencySymbol': currencySymbol,
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
      language: entity.language,
      region: entity.region,
      currencySymbol: entity.currencySymbol,
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
      language: language,
      region: region,
      currencySymbol: currencySymbol,
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
    String? language,
    String? region,
    String? currencySymbol,
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
      language: language ?? this.language,
      region: region ?? this.region,
      currencySymbol: currencySymbol ?? this.currencySymbol,
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
        language,
        region,
        currencySymbol,
        theme,
        fontSize,
      ];
}
