import 'package:equatable/equatable.dart';

import '../../domain/entities/security_settings.dart';

/// Security Settings Model
///
/// Data layer model for security settings with JSON serialization
/// Uses manual implementation without Freezed code generation
class SecuritySettingsModel extends Equatable {
  final bool requirePinForRefund;
  final bool requirePinForDiscount;
  final bool requirePinForVoid;
  final bool autoLockAfterInactivity;
  final int autoLockDurationMinutes;

  const SecuritySettingsModel({
    required this.requirePinForRefund,
    required this.requirePinForDiscount,
    required this.requirePinForVoid,
    required this.autoLockAfterInactivity,
    required this.autoLockDurationMinutes,
  });

  /// Create model from JSON
  factory SecuritySettingsModel.fromJson(Map<String, dynamic> json) {
    return SecuritySettingsModel(
      requirePinForRefund: json['requirePinForRefund'] as bool,
      requirePinForDiscount: json['requirePinForDiscount'] as bool,
      requirePinForVoid: json['requirePinForVoid'] as bool,
      autoLockAfterInactivity: json['autoLockAfterInactivity'] as bool,
      autoLockDurationMinutes: json['autoLockDurationMinutes'] as int,
    );
  }

  /// Convert model to JSON
  Map<String, dynamic> toJson() {
    return {
      'requirePinForRefund': requirePinForRefund,
      'requirePinForDiscount': requirePinForDiscount,
      'requirePinForVoid': requirePinForVoid,
      'autoLockAfterInactivity': autoLockAfterInactivity,
      'autoLockDurationMinutes': autoLockDurationMinutes,
    };
  }

  /// Create model from domain entity
  factory SecuritySettingsModel.fromEntity(SecuritySettings entity) {
    return SecuritySettingsModel(
      requirePinForRefund: entity.requirePinForRefund,
      requirePinForDiscount: entity.requirePinForDiscount,
      requirePinForVoid: entity.requirePinForVoid,
      autoLockAfterInactivity: entity.autoLockAfterInactivity,
      autoLockDurationMinutes: entity.autoLockDurationMinutes,
    );
  }

  /// Convert model to domain entity
  SecuritySettings toEntity() {
    return SecuritySettings(
      requirePinForRefund: requirePinForRefund,
      requirePinForDiscount: requirePinForDiscount,
      requirePinForVoid: requirePinForVoid,
      autoLockAfterInactivity: autoLockAfterInactivity,
      autoLockDurationMinutes: autoLockDurationMinutes,
    );
  }

  /// Create a copy with updated fields
  SecuritySettingsModel copyWith({
    bool? requirePinForRefund,
    bool? requirePinForDiscount,
    bool? requirePinForVoid,
    bool? autoLockAfterInactivity,
    int? autoLockDurationMinutes,
  }) {
    return SecuritySettingsModel(
      requirePinForRefund: requirePinForRefund ?? this.requirePinForRefund,
      requirePinForDiscount: requirePinForDiscount ?? this.requirePinForDiscount,
      requirePinForVoid: requirePinForVoid ?? this.requirePinForVoid,
      autoLockAfterInactivity: autoLockAfterInactivity ?? this.autoLockAfterInactivity,
      autoLockDurationMinutes: autoLockDurationMinutes ?? this.autoLockDurationMinutes,
    );
  }

  @override
  List<Object?> get props => [
        requirePinForRefund,
        requirePinForDiscount,
        requirePinForVoid,
        autoLockAfterInactivity,
        autoLockDurationMinutes,
      ];
}
