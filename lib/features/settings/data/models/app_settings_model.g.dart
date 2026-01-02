// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_settings_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AppSettingsModel _$AppSettingsModelFromJson(Map<String, dynamic> json) =>
    _AppSettingsModel(
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

Map<String, dynamic> _$AppSettingsModelToJson(_AppSettingsModel instance) =>
    <String, dynamic>{
      'storeName': instance.storeName,
      'storeAddress': instance.storeAddress,
      'storePhone': instance.storePhone,
      'storeEmail': instance.storeEmail,
      'taxRate': instance.taxRate,
      'autoCalculateTax': instance.autoCalculateTax,
      'language': instance.language,
      'region': instance.region,
      'currencySymbol': instance.currencySymbol,
      'theme': instance.theme,
      'fontSize': instance.fontSize,
    };
