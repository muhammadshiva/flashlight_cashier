// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/app_settings.dart';

part 'app_settings_model.freezed.dart';
part 'app_settings_model.g.dart';

@freezed
class AppSettingsModel with _$AppSettingsModel {
  const factory AppSettingsModel({
    @JsonKey(name: "storeName") required String storeName,
    @JsonKey(name: "storeAddress") required String storeAddress,
    @JsonKey(name: "storePhone") required String storePhone,
    @JsonKey(name: "storeEmail") required String storeEmail,
    @JsonKey(name: "taxRate") required double taxRate,
    @JsonKey(name: "autoCalculateTax") required bool autoCalculateTax,
    @JsonKey(name: "language") required String language,
    @JsonKey(name: "region") required String region,
    @JsonKey(name: "currencySymbol") required String currencySymbol,
    @JsonKey(name: "theme") required String theme,
    @JsonKey(name: "fontSize") required double fontSize,
  }) = _AppSettingsModel;

  factory AppSettingsModel.fromJson(Map<String, dynamic> json) => _$AppSettingsModelFromJson(json);

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

  AppSettings toEntity() => AppSettings(
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

  @override
  // TODO: implement autoCalculateTax
  bool get autoCalculateTax => throw UnimplementedError();

  @override
  // TODO: implement currencySymbol
  String get currencySymbol => throw UnimplementedError();

  @override
  // TODO: implement fontSize
  double get fontSize => throw UnimplementedError();

  @override
  // TODO: implement language
  String get language => throw UnimplementedError();

  @override
  // TODO: implement region
  String get region => throw UnimplementedError();

  @override
  // TODO: implement storeAddress
  String get storeAddress => throw UnimplementedError();

  @override
  // TODO: implement storeEmail
  String get storeEmail => throw UnimplementedError();

  @override
  // TODO: implement storeName
  String get storeName => throw UnimplementedError();

  @override
  // TODO: implement storePhone
  String get storePhone => throw UnimplementedError();

  @override
  // TODO: implement taxRate
  double get taxRate => throw UnimplementedError();

  @override
  // TODO: implement theme
  String get theme => throw UnimplementedError();

  @override
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }
}
