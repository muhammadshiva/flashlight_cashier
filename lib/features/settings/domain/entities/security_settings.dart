/// Domain Entity for Security Settings
class SecuritySettings {
  final bool requirePinForRefund;
  final bool requirePinForDiscount;
  final bool requirePinForVoid;
  final bool autoLockAfterInactivity;
  final int autoLockDurationMinutes;

  const SecuritySettings({
    required this.requirePinForRefund,
    required this.requirePinForDiscount,
    required this.requirePinForVoid,
    required this.autoLockAfterInactivity,
    required this.autoLockDurationMinutes,
  });

  factory SecuritySettings.initial() {
    return const SecuritySettings(
      requirePinForRefund: true,
      requirePinForDiscount: true,
      requirePinForVoid: true,
      autoLockAfterInactivity: false,
      autoLockDurationMinutes: 15,
    );
  }

  SecuritySettings copyWith({
    bool? requirePinForRefund,
    bool? requirePinForDiscount,
    bool? requirePinForVoid,
    bool? autoLockAfterInactivity,
    int? autoLockDurationMinutes,
  }) {
    return SecuritySettings(
      requirePinForRefund: requirePinForRefund ?? this.requirePinForRefund,
      requirePinForDiscount: requirePinForDiscount ?? this.requirePinForDiscount,
      requirePinForVoid: requirePinForVoid ?? this.requirePinForVoid,
      autoLockAfterInactivity: autoLockAfterInactivity ?? this.autoLockAfterInactivity,
      autoLockDurationMinutes: autoLockDurationMinutes ?? this.autoLockDurationMinutes,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SecuritySettings &&
        other.requirePinForRefund == requirePinForRefund &&
        other.requirePinForDiscount == requirePinForDiscount &&
        other.requirePinForVoid == requirePinForVoid &&
        other.autoLockAfterInactivity == autoLockAfterInactivity &&
        other.autoLockDurationMinutes == autoLockDurationMinutes;
  }

  @override
  int get hashCode {
    return Object.hash(
      requirePinForRefund,
      requirePinForDiscount,
      requirePinForVoid,
      autoLockAfterInactivity,
      autoLockDurationMinutes,
    );
  }
}
