// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/security_settings.dart';

part 'security_settings_model.freezed.dart';
part 'security_settings_model.g.dart';

@freezed
class SecuritySettingsModel with _$SecuritySettingsModel {
  const SecuritySettingsModel._();

  const factory SecuritySettingsModel({
    @JsonKey(name: "requirePinForRefund") required bool requirePinForRefund,
    @JsonKey(name: "requirePinForDiscount") required bool requirePinForDiscount,
    @JsonKey(name: "requirePinForVoid") required bool requirePinForVoid,
    @JsonKey(name: "autoLockAfterInactivity") required bool autoLockAfterInactivity,
    @JsonKey(name: "autoLockDurationMinutes") required int autoLockDurationMinutes,
  }) = _SecuritySettingsModel;

  factory SecuritySettingsModel.fromJson(Map<String, dynamic> json) =>
      _$SecuritySettingsModelFromJson(json);

  factory SecuritySettingsModel.fromEntity(SecuritySettings entity) {
    return SecuritySettingsModel(
      requirePinForRefund: entity.requirePinForRefund,
      requirePinForDiscount: entity.requirePinForDiscount,
      requirePinForVoid: entity.requirePinForVoid,
      autoLockAfterInactivity: entity.autoLockAfterInactivity,
      autoLockDurationMinutes: entity.autoLockDurationMinutes,
    );
  }

  SecuritySettings toEntity() => SecuritySettings(
        requirePinForRefund: requirePinForRefund,
        requirePinForDiscount: requirePinForDiscount,
        requirePinForVoid: requirePinForVoid,
        autoLockAfterInactivity: autoLockAfterInactivity,
        autoLockDurationMinutes: autoLockDurationMinutes,
      );

  @override
  // TODO: implement autoLockAfterInactivity
  bool get autoLockAfterInactivity => throw UnimplementedError();

  @override
  // TODO: implement autoLockDurationMinutes
  int get autoLockDurationMinutes => throw UnimplementedError();

  @override
  // TODO: implement requirePinForDiscount
  bool get requirePinForDiscount => throw UnimplementedError();

  @override
  // TODO: implement requirePinForRefund
  bool get requirePinForRefund => throw UnimplementedError();

  @override
  // TODO: implement requirePinForVoid
  bool get requirePinForVoid => throw UnimplementedError();

  @override
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }
}
