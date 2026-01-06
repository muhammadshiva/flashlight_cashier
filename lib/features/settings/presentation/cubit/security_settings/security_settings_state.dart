part of 'security_settings_cubit.dart';

/// Security Settings State
///
/// Combines UIStateModel for data state with separate UI loading flags
class SecuritySettingsState extends Equatable {
  /// Main security settings data wrapped in UIStateModel
  final UIStateModel<SecuritySettings> data;

  /// UI loading states for individual toggles
  final bool isUpdatingPinForRefund;
  final bool isUpdatingPinForDiscount;
  final bool isUpdatingPinForVoid;
  final bool isUpdatingAutoLock;
  final bool isUpdatingAutoLockDuration;

  const SecuritySettingsState({
    required this.data,
    this.isUpdatingPinForRefund = false,
    this.isUpdatingPinForDiscount = false,
    this.isUpdatingPinForVoid = false,
    this.isUpdatingAutoLock = false,
    this.isUpdatingAutoLockDuration = false,
  });

  factory SecuritySettingsState.initial() => SecuritySettingsState(
        data: UIStateModel.success(data: SecuritySettings.initial()),
      );

  @override
  List<Object?> get props => [
        data,
        isUpdatingPinForRefund,
        isUpdatingPinForDiscount,
        isUpdatingPinForVoid,
        isUpdatingAutoLock,
        isUpdatingAutoLockDuration,
      ];

  SecuritySettingsState copyWith({
    UIStateModel<SecuritySettings>? data,
    bool? isUpdatingPinForRefund,
    bool? isUpdatingPinForDiscount,
    bool? isUpdatingPinForVoid,
    bool? isUpdatingAutoLock,
    bool? isUpdatingAutoLockDuration,
  }) {
    return SecuritySettingsState(
      data: data ?? this.data,
      isUpdatingPinForRefund: isUpdatingPinForRefund ?? this.isUpdatingPinForRefund,
      isUpdatingPinForDiscount: isUpdatingPinForDiscount ?? this.isUpdatingPinForDiscount,
      isUpdatingPinForVoid: isUpdatingPinForVoid ?? this.isUpdatingPinForVoid,
      isUpdatingAutoLock: isUpdatingAutoLock ?? this.isUpdatingAutoLock,
      isUpdatingAutoLockDuration: isUpdatingAutoLockDuration ?? this.isUpdatingAutoLockDuration,
    );
  }
}
