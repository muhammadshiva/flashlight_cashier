// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_bloc.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SettingsState _$SettingsStateFromJson(Map<String, dynamic> json) =>
    _SettingsState(
      appSettings: const AppSettingsConverter()
          .fromJson(json['appSettings'] as Map<String, dynamic>),
      printerSettings: const PrinterSettingsConverter()
          .fromJson(json['printerSettings'] as Map<String, dynamic>),
      availablePrinters: json['availablePrinters'] == null
          ? const []
          : const PrinterDeviceListConverter()
              .fromJson(json['availablePrinters'] as List),
      isScanningPrinters: json['isScanningPrinters'] as bool? ?? false,
      isConnectingPrinter: json['isConnectingPrinter'] as bool? ?? false,
      isTogglingBluetooth: json['isTogglingBluetooth'] as bool? ?? false,
      receiptSettings: const ReceiptSettingsConverter()
          .fromJson(json['receiptSettings'] as Map<String, dynamic>),
      notificationSettings: const NotificationSettingsConverter()
          .fromJson(json['notificationSettings'] as Map<String, dynamic>),
      securitySettings: const SecuritySettingsConverter()
          .fromJson(json['securitySettings'] as Map<String, dynamic>),
      status: $enumDecodeNullable(_$SettingsStatusEnumMap, json['status']) ??
          SettingsStatus.initial,
      errorMessage: json['errorMessage'] as String?,
    );

Map<String, dynamic> _$SettingsStateToJson(_SettingsState instance) =>
    <String, dynamic>{
      'appSettings': const AppSettingsConverter().toJson(instance.appSettings),
      'printerSettings':
          const PrinterSettingsConverter().toJson(instance.printerSettings),
      'availablePrinters':
          const PrinterDeviceListConverter().toJson(instance.availablePrinters),
      'isScanningPrinters': instance.isScanningPrinters,
      'isConnectingPrinter': instance.isConnectingPrinter,
      'isTogglingBluetooth': instance.isTogglingBluetooth,
      'receiptSettings':
          const ReceiptSettingsConverter().toJson(instance.receiptSettings),
      'notificationSettings': const NotificationSettingsConverter()
          .toJson(instance.notificationSettings),
      'securitySettings':
          const SecuritySettingsConverter().toJson(instance.securitySettings),
      'status': _$SettingsStatusEnumMap[instance.status]!,
      'errorMessage': instance.errorMessage,
    };

const _$SettingsStatusEnumMap = {
  SettingsStatus.initial: 'initial',
  SettingsStatus.loading: 'loading',
  SettingsStatus.success: 'success',
  SettingsStatus.failure: 'failure',
};
