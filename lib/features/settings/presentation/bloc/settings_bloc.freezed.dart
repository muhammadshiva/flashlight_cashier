// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'settings_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SettingsEvent {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is SettingsEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'SettingsEvent()';
  }
}

/// @nodoc
class $SettingsEventCopyWith<$Res> {
  $SettingsEventCopyWith(SettingsEvent _, $Res Function(SettingsEvent) __);
}

/// Adds pattern-matching-related methods to [SettingsEvent].
extension SettingsEventPatterns on SettingsEvent {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadSettings value)? loadSettings,
    TResult Function(UpdateStoreInfo value)? updateStoreInfo,
    TResult Function(UpdatePOSSettings value)? updatePOSSettings,
    TResult Function(ToggleBluetooth value)? toggleBluetooth,
    TResult Function(ScanPrintersEvent value)? scanPrinters,
    TResult Function(ConnectPrinterEvent value)? connectPrinter,
    TResult Function(DisconnectPrinterEvent value)? disconnectPrinter,
    TResult Function(UpdatePrinterSettingsEvent value)? updatePrinterSettings,
    TResult Function(UpdateReceiptSettingsEvent value)? updateReceiptSettings,
    TResult Function(UpdateNotificationSettingsEvent value)?
        updateNotificationSettings,
    TResult Function(UpdateSecuritySettingsEvent value)? updateSecuritySettings,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case LoadSettings() when loadSettings != null:
        return loadSettings(_that);
      case UpdateStoreInfo() when updateStoreInfo != null:
        return updateStoreInfo(_that);
      case UpdatePOSSettings() when updatePOSSettings != null:
        return updatePOSSettings(_that);
      case ToggleBluetooth() when toggleBluetooth != null:
        return toggleBluetooth(_that);
      case ScanPrintersEvent() when scanPrinters != null:
        return scanPrinters(_that);
      case ConnectPrinterEvent() when connectPrinter != null:
        return connectPrinter(_that);
      case DisconnectPrinterEvent() when disconnectPrinter != null:
        return disconnectPrinter(_that);
      case UpdatePrinterSettingsEvent() when updatePrinterSettings != null:
        return updatePrinterSettings(_that);
      case UpdateReceiptSettingsEvent() when updateReceiptSettings != null:
        return updateReceiptSettings(_that);
      case UpdateNotificationSettingsEvent()
          when updateNotificationSettings != null:
        return updateNotificationSettings(_that);
      case UpdateSecuritySettingsEvent() when updateSecuritySettings != null:
        return updateSecuritySettings(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadSettings value) loadSettings,
    required TResult Function(UpdateStoreInfo value) updateStoreInfo,
    required TResult Function(UpdatePOSSettings value) updatePOSSettings,
    required TResult Function(ToggleBluetooth value) toggleBluetooth,
    required TResult Function(ScanPrintersEvent value) scanPrinters,
    required TResult Function(ConnectPrinterEvent value) connectPrinter,
    required TResult Function(DisconnectPrinterEvent value) disconnectPrinter,
    required TResult Function(UpdatePrinterSettingsEvent value)
        updatePrinterSettings,
    required TResult Function(UpdateReceiptSettingsEvent value)
        updateReceiptSettings,
    required TResult Function(UpdateNotificationSettingsEvent value)
        updateNotificationSettings,
    required TResult Function(UpdateSecuritySettingsEvent value)
        updateSecuritySettings,
  }) {
    final _that = this;
    switch (_that) {
      case LoadSettings():
        return loadSettings(_that);
      case UpdateStoreInfo():
        return updateStoreInfo(_that);
      case UpdatePOSSettings():
        return updatePOSSettings(_that);
      case ToggleBluetooth():
        return toggleBluetooth(_that);
      case ScanPrintersEvent():
        return scanPrinters(_that);
      case ConnectPrinterEvent():
        return connectPrinter(_that);
      case DisconnectPrinterEvent():
        return disconnectPrinter(_that);
      case UpdatePrinterSettingsEvent():
        return updatePrinterSettings(_that);
      case UpdateReceiptSettingsEvent():
        return updateReceiptSettings(_that);
      case UpdateNotificationSettingsEvent():
        return updateNotificationSettings(_that);
      case UpdateSecuritySettingsEvent():
        return updateSecuritySettings(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadSettings value)? loadSettings,
    TResult? Function(UpdateStoreInfo value)? updateStoreInfo,
    TResult? Function(UpdatePOSSettings value)? updatePOSSettings,
    TResult? Function(ToggleBluetooth value)? toggleBluetooth,
    TResult? Function(ScanPrintersEvent value)? scanPrinters,
    TResult? Function(ConnectPrinterEvent value)? connectPrinter,
    TResult? Function(DisconnectPrinterEvent value)? disconnectPrinter,
    TResult? Function(UpdatePrinterSettingsEvent value)? updatePrinterSettings,
    TResult? Function(UpdateReceiptSettingsEvent value)? updateReceiptSettings,
    TResult? Function(UpdateNotificationSettingsEvent value)?
        updateNotificationSettings,
    TResult? Function(UpdateSecuritySettingsEvent value)?
        updateSecuritySettings,
  }) {
    final _that = this;
    switch (_that) {
      case LoadSettings() when loadSettings != null:
        return loadSettings(_that);
      case UpdateStoreInfo() when updateStoreInfo != null:
        return updateStoreInfo(_that);
      case UpdatePOSSettings() when updatePOSSettings != null:
        return updatePOSSettings(_that);
      case ToggleBluetooth() when toggleBluetooth != null:
        return toggleBluetooth(_that);
      case ScanPrintersEvent() when scanPrinters != null:
        return scanPrinters(_that);
      case ConnectPrinterEvent() when connectPrinter != null:
        return connectPrinter(_that);
      case DisconnectPrinterEvent() when disconnectPrinter != null:
        return disconnectPrinter(_that);
      case UpdatePrinterSettingsEvent() when updatePrinterSettings != null:
        return updatePrinterSettings(_that);
      case UpdateReceiptSettingsEvent() when updateReceiptSettings != null:
        return updateReceiptSettings(_that);
      case UpdateNotificationSettingsEvent()
          when updateNotificationSettings != null:
        return updateNotificationSettings(_that);
      case UpdateSecuritySettingsEvent() when updateSecuritySettings != null:
        return updateSecuritySettings(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadSettings,
    TResult Function(String? storeName, String? storeAddress,
            String? storePhone, String? storeEmail)?
        updateStoreInfo,
    TResult Function(double? taxRate, bool? autoCalculateTax)?
        updatePOSSettings,
    TResult Function(bool enable)? toggleBluetooth,
    TResult Function()? scanPrinters,
    TResult Function(PrinterDevice device)? connectPrinter,
    TResult Function()? disconnectPrinter,
    TResult Function(PrinterSettings settings)? updatePrinterSettings,
    TResult Function(ReceiptSettings settings)? updateReceiptSettings,
    TResult Function(NotificationSettings settings)? updateNotificationSettings,
    TResult Function(SecuritySettings settings)? updateSecuritySettings,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case LoadSettings() when loadSettings != null:
        return loadSettings();
      case UpdateStoreInfo() when updateStoreInfo != null:
        return updateStoreInfo(_that.storeName, _that.storeAddress,
            _that.storePhone, _that.storeEmail);
      case UpdatePOSSettings() when updatePOSSettings != null:
        return updatePOSSettings(_that.taxRate, _that.autoCalculateTax);
      case ToggleBluetooth() when toggleBluetooth != null:
        return toggleBluetooth(_that.enable);
      case ScanPrintersEvent() when scanPrinters != null:
        return scanPrinters();
      case ConnectPrinterEvent() when connectPrinter != null:
        return connectPrinter(_that.device);
      case DisconnectPrinterEvent() when disconnectPrinter != null:
        return disconnectPrinter();
      case UpdatePrinterSettingsEvent() when updatePrinterSettings != null:
        return updatePrinterSettings(_that.settings);
      case UpdateReceiptSettingsEvent() when updateReceiptSettings != null:
        return updateReceiptSettings(_that.settings);
      case UpdateNotificationSettingsEvent()
          when updateNotificationSettings != null:
        return updateNotificationSettings(_that.settings);
      case UpdateSecuritySettingsEvent() when updateSecuritySettings != null:
        return updateSecuritySettings(_that.settings);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadSettings,
    required TResult Function(String? storeName, String? storeAddress,
            String? storePhone, String? storeEmail)
        updateStoreInfo,
    required TResult Function(double? taxRate, bool? autoCalculateTax)
        updatePOSSettings,
    required TResult Function(bool enable) toggleBluetooth,
    required TResult Function() scanPrinters,
    required TResult Function(PrinterDevice device) connectPrinter,
    required TResult Function() disconnectPrinter,
    required TResult Function(PrinterSettings settings) updatePrinterSettings,
    required TResult Function(ReceiptSettings settings) updateReceiptSettings,
    required TResult Function(NotificationSettings settings)
        updateNotificationSettings,
    required TResult Function(SecuritySettings settings) updateSecuritySettings,
  }) {
    final _that = this;
    switch (_that) {
      case LoadSettings():
        return loadSettings();
      case UpdateStoreInfo():
        return updateStoreInfo(_that.storeName, _that.storeAddress,
            _that.storePhone, _that.storeEmail);
      case UpdatePOSSettings():
        return updatePOSSettings(_that.taxRate, _that.autoCalculateTax);
      case ToggleBluetooth():
        return toggleBluetooth(_that.enable);
      case ScanPrintersEvent():
        return scanPrinters();
      case ConnectPrinterEvent():
        return connectPrinter(_that.device);
      case DisconnectPrinterEvent():
        return disconnectPrinter();
      case UpdatePrinterSettingsEvent():
        return updatePrinterSettings(_that.settings);
      case UpdateReceiptSettingsEvent():
        return updateReceiptSettings(_that.settings);
      case UpdateNotificationSettingsEvent():
        return updateNotificationSettings(_that.settings);
      case UpdateSecuritySettingsEvent():
        return updateSecuritySettings(_that.settings);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadSettings,
    TResult? Function(String? storeName, String? storeAddress,
            String? storePhone, String? storeEmail)?
        updateStoreInfo,
    TResult? Function(double? taxRate, bool? autoCalculateTax)?
        updatePOSSettings,
    TResult? Function(bool enable)? toggleBluetooth,
    TResult? Function()? scanPrinters,
    TResult? Function(PrinterDevice device)? connectPrinter,
    TResult? Function()? disconnectPrinter,
    TResult? Function(PrinterSettings settings)? updatePrinterSettings,
    TResult? Function(ReceiptSettings settings)? updateReceiptSettings,
    TResult? Function(NotificationSettings settings)?
        updateNotificationSettings,
    TResult? Function(SecuritySettings settings)? updateSecuritySettings,
  }) {
    final _that = this;
    switch (_that) {
      case LoadSettings() when loadSettings != null:
        return loadSettings();
      case UpdateStoreInfo() when updateStoreInfo != null:
        return updateStoreInfo(_that.storeName, _that.storeAddress,
            _that.storePhone, _that.storeEmail);
      case UpdatePOSSettings() when updatePOSSettings != null:
        return updatePOSSettings(_that.taxRate, _that.autoCalculateTax);
      case ToggleBluetooth() when toggleBluetooth != null:
        return toggleBluetooth(_that.enable);
      case ScanPrintersEvent() when scanPrinters != null:
        return scanPrinters();
      case ConnectPrinterEvent() when connectPrinter != null:
        return connectPrinter(_that.device);
      case DisconnectPrinterEvent() when disconnectPrinter != null:
        return disconnectPrinter();
      case UpdatePrinterSettingsEvent() when updatePrinterSettings != null:
        return updatePrinterSettings(_that.settings);
      case UpdateReceiptSettingsEvent() when updateReceiptSettings != null:
        return updateReceiptSettings(_that.settings);
      case UpdateNotificationSettingsEvent()
          when updateNotificationSettings != null:
        return updateNotificationSettings(_that.settings);
      case UpdateSecuritySettingsEvent() when updateSecuritySettings != null:
        return updateSecuritySettings(_that.settings);
      case _:
        return null;
    }
  }
}

/// @nodoc

class LoadSettings implements SettingsEvent {
  const LoadSettings();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is LoadSettings);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'SettingsEvent.loadSettings()';
  }
}

/// @nodoc

class UpdateStoreInfo implements SettingsEvent {
  const UpdateStoreInfo(
      {this.storeName, this.storeAddress, this.storePhone, this.storeEmail});

  final String? storeName;
  final String? storeAddress;
  final String? storePhone;
  final String? storeEmail;

  /// Create a copy of SettingsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $UpdateStoreInfoCopyWith<UpdateStoreInfo> get copyWith =>
      _$UpdateStoreInfoCopyWithImpl<UpdateStoreInfo>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is UpdateStoreInfo &&
            (identical(other.storeName, storeName) ||
                other.storeName == storeName) &&
            (identical(other.storeAddress, storeAddress) ||
                other.storeAddress == storeAddress) &&
            (identical(other.storePhone, storePhone) ||
                other.storePhone == storePhone) &&
            (identical(other.storeEmail, storeEmail) ||
                other.storeEmail == storeEmail));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, storeName, storeAddress, storePhone, storeEmail);

  @override
  String toString() {
    return 'SettingsEvent.updateStoreInfo(storeName: $storeName, storeAddress: $storeAddress, storePhone: $storePhone, storeEmail: $storeEmail)';
  }
}

/// @nodoc
abstract mixin class $UpdateStoreInfoCopyWith<$Res>
    implements $SettingsEventCopyWith<$Res> {
  factory $UpdateStoreInfoCopyWith(
          UpdateStoreInfo value, $Res Function(UpdateStoreInfo) _then) =
      _$UpdateStoreInfoCopyWithImpl;
  @useResult
  $Res call(
      {String? storeName,
      String? storeAddress,
      String? storePhone,
      String? storeEmail});
}

/// @nodoc
class _$UpdateStoreInfoCopyWithImpl<$Res>
    implements $UpdateStoreInfoCopyWith<$Res> {
  _$UpdateStoreInfoCopyWithImpl(this._self, this._then);

  final UpdateStoreInfo _self;
  final $Res Function(UpdateStoreInfo) _then;

  /// Create a copy of SettingsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? storeName = freezed,
    Object? storeAddress = freezed,
    Object? storePhone = freezed,
    Object? storeEmail = freezed,
  }) {
    return _then(UpdateStoreInfo(
      storeName: freezed == storeName
          ? _self.storeName
          : storeName // ignore: cast_nullable_to_non_nullable
              as String?,
      storeAddress: freezed == storeAddress
          ? _self.storeAddress
          : storeAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      storePhone: freezed == storePhone
          ? _self.storePhone
          : storePhone // ignore: cast_nullable_to_non_nullable
              as String?,
      storeEmail: freezed == storeEmail
          ? _self.storeEmail
          : storeEmail // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class UpdatePOSSettings implements SettingsEvent {
  const UpdatePOSSettings({this.taxRate, this.autoCalculateTax});

  final double? taxRate;
  final bool? autoCalculateTax;

  /// Create a copy of SettingsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $UpdatePOSSettingsCopyWith<UpdatePOSSettings> get copyWith =>
      _$UpdatePOSSettingsCopyWithImpl<UpdatePOSSettings>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is UpdatePOSSettings &&
            (identical(other.taxRate, taxRate) || other.taxRate == taxRate) &&
            (identical(other.autoCalculateTax, autoCalculateTax) ||
                other.autoCalculateTax == autoCalculateTax));
  }

  @override
  int get hashCode => Object.hash(runtimeType, taxRate, autoCalculateTax);

  @override
  String toString() {
    return 'SettingsEvent.updatePOSSettings(taxRate: $taxRate, autoCalculateTax: $autoCalculateTax)';
  }
}

/// @nodoc
abstract mixin class $UpdatePOSSettingsCopyWith<$Res>
    implements $SettingsEventCopyWith<$Res> {
  factory $UpdatePOSSettingsCopyWith(
          UpdatePOSSettings value, $Res Function(UpdatePOSSettings) _then) =
      _$UpdatePOSSettingsCopyWithImpl;
  @useResult
  $Res call({double? taxRate, bool? autoCalculateTax});
}

/// @nodoc
class _$UpdatePOSSettingsCopyWithImpl<$Res>
    implements $UpdatePOSSettingsCopyWith<$Res> {
  _$UpdatePOSSettingsCopyWithImpl(this._self, this._then);

  final UpdatePOSSettings _self;
  final $Res Function(UpdatePOSSettings) _then;

  /// Create a copy of SettingsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? taxRate = freezed,
    Object? autoCalculateTax = freezed,
  }) {
    return _then(UpdatePOSSettings(
      taxRate: freezed == taxRate
          ? _self.taxRate
          : taxRate // ignore: cast_nullable_to_non_nullable
              as double?,
      autoCalculateTax: freezed == autoCalculateTax
          ? _self.autoCalculateTax
          : autoCalculateTax // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc

class ToggleBluetooth implements SettingsEvent {
  const ToggleBluetooth({required this.enable});

  final bool enable;

  /// Create a copy of SettingsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ToggleBluetoothCopyWith<ToggleBluetooth> get copyWith =>
      _$ToggleBluetoothCopyWithImpl<ToggleBluetooth>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ToggleBluetooth &&
            (identical(other.enable, enable) || other.enable == enable));
  }

  @override
  int get hashCode => Object.hash(runtimeType, enable);

  @override
  String toString() {
    return 'SettingsEvent.toggleBluetooth(enable: $enable)';
  }
}

/// @nodoc
abstract mixin class $ToggleBluetoothCopyWith<$Res>
    implements $SettingsEventCopyWith<$Res> {
  factory $ToggleBluetoothCopyWith(
          ToggleBluetooth value, $Res Function(ToggleBluetooth) _then) =
      _$ToggleBluetoothCopyWithImpl;
  @useResult
  $Res call({bool enable});
}

/// @nodoc
class _$ToggleBluetoothCopyWithImpl<$Res>
    implements $ToggleBluetoothCopyWith<$Res> {
  _$ToggleBluetoothCopyWithImpl(this._self, this._then);

  final ToggleBluetooth _self;
  final $Res Function(ToggleBluetooth) _then;

  /// Create a copy of SettingsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? enable = null,
  }) {
    return _then(ToggleBluetooth(
      enable: null == enable
          ? _self.enable
          : enable // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class ScanPrintersEvent implements SettingsEvent {
  const ScanPrintersEvent();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is ScanPrintersEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'SettingsEvent.scanPrinters()';
  }
}

/// @nodoc

class ConnectPrinterEvent implements SettingsEvent {
  const ConnectPrinterEvent({required this.device});

  final PrinterDevice device;

  /// Create a copy of SettingsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ConnectPrinterEventCopyWith<ConnectPrinterEvent> get copyWith =>
      _$ConnectPrinterEventCopyWithImpl<ConnectPrinterEvent>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ConnectPrinterEvent &&
            (identical(other.device, device) || other.device == device));
  }

  @override
  int get hashCode => Object.hash(runtimeType, device);

  @override
  String toString() {
    return 'SettingsEvent.connectPrinter(device: $device)';
  }
}

/// @nodoc
abstract mixin class $ConnectPrinterEventCopyWith<$Res>
    implements $SettingsEventCopyWith<$Res> {
  factory $ConnectPrinterEventCopyWith(
          ConnectPrinterEvent value, $Res Function(ConnectPrinterEvent) _then) =
      _$ConnectPrinterEventCopyWithImpl;
  @useResult
  $Res call({PrinterDevice device});
}

/// @nodoc
class _$ConnectPrinterEventCopyWithImpl<$Res>
    implements $ConnectPrinterEventCopyWith<$Res> {
  _$ConnectPrinterEventCopyWithImpl(this._self, this._then);

  final ConnectPrinterEvent _self;
  final $Res Function(ConnectPrinterEvent) _then;

  /// Create a copy of SettingsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? device = null,
  }) {
    return _then(ConnectPrinterEvent(
      device: null == device
          ? _self.device
          : device // ignore: cast_nullable_to_non_nullable
              as PrinterDevice,
    ));
  }
}

/// @nodoc

class DisconnectPrinterEvent implements SettingsEvent {
  const DisconnectPrinterEvent();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is DisconnectPrinterEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'SettingsEvent.disconnectPrinter()';
  }
}

/// @nodoc

class UpdatePrinterSettingsEvent implements SettingsEvent {
  const UpdatePrinterSettingsEvent({required this.settings});

  final PrinterSettings settings;

  /// Create a copy of SettingsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $UpdatePrinterSettingsEventCopyWith<UpdatePrinterSettingsEvent>
      get copyWith =>
          _$UpdatePrinterSettingsEventCopyWithImpl<UpdatePrinterSettingsEvent>(
              this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is UpdatePrinterSettingsEvent &&
            (identical(other.settings, settings) ||
                other.settings == settings));
  }

  @override
  int get hashCode => Object.hash(runtimeType, settings);

  @override
  String toString() {
    return 'SettingsEvent.updatePrinterSettings(settings: $settings)';
  }
}

/// @nodoc
abstract mixin class $UpdatePrinterSettingsEventCopyWith<$Res>
    implements $SettingsEventCopyWith<$Res> {
  factory $UpdatePrinterSettingsEventCopyWith(UpdatePrinterSettingsEvent value,
          $Res Function(UpdatePrinterSettingsEvent) _then) =
      _$UpdatePrinterSettingsEventCopyWithImpl;
  @useResult
  $Res call({PrinterSettings settings});
}

/// @nodoc
class _$UpdatePrinterSettingsEventCopyWithImpl<$Res>
    implements $UpdatePrinterSettingsEventCopyWith<$Res> {
  _$UpdatePrinterSettingsEventCopyWithImpl(this._self, this._then);

  final UpdatePrinterSettingsEvent _self;
  final $Res Function(UpdatePrinterSettingsEvent) _then;

  /// Create a copy of SettingsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? settings = null,
  }) {
    return _then(UpdatePrinterSettingsEvent(
      settings: null == settings
          ? _self.settings
          : settings // ignore: cast_nullable_to_non_nullable
              as PrinterSettings,
    ));
  }
}

/// @nodoc

class UpdateReceiptSettingsEvent implements SettingsEvent {
  const UpdateReceiptSettingsEvent({required this.settings});

  final ReceiptSettings settings;

  /// Create a copy of SettingsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $UpdateReceiptSettingsEventCopyWith<UpdateReceiptSettingsEvent>
      get copyWith =>
          _$UpdateReceiptSettingsEventCopyWithImpl<UpdateReceiptSettingsEvent>(
              this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is UpdateReceiptSettingsEvent &&
            (identical(other.settings, settings) ||
                other.settings == settings));
  }

  @override
  int get hashCode => Object.hash(runtimeType, settings);

  @override
  String toString() {
    return 'SettingsEvent.updateReceiptSettings(settings: $settings)';
  }
}

/// @nodoc
abstract mixin class $UpdateReceiptSettingsEventCopyWith<$Res>
    implements $SettingsEventCopyWith<$Res> {
  factory $UpdateReceiptSettingsEventCopyWith(UpdateReceiptSettingsEvent value,
          $Res Function(UpdateReceiptSettingsEvent) _then) =
      _$UpdateReceiptSettingsEventCopyWithImpl;
  @useResult
  $Res call({ReceiptSettings settings});
}

/// @nodoc
class _$UpdateReceiptSettingsEventCopyWithImpl<$Res>
    implements $UpdateReceiptSettingsEventCopyWith<$Res> {
  _$UpdateReceiptSettingsEventCopyWithImpl(this._self, this._then);

  final UpdateReceiptSettingsEvent _self;
  final $Res Function(UpdateReceiptSettingsEvent) _then;

  /// Create a copy of SettingsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? settings = null,
  }) {
    return _then(UpdateReceiptSettingsEvent(
      settings: null == settings
          ? _self.settings
          : settings // ignore: cast_nullable_to_non_nullable
              as ReceiptSettings,
    ));
  }
}

/// @nodoc

class UpdateNotificationSettingsEvent implements SettingsEvent {
  const UpdateNotificationSettingsEvent({required this.settings});

  final NotificationSettings settings;

  /// Create a copy of SettingsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $UpdateNotificationSettingsEventCopyWith<UpdateNotificationSettingsEvent>
      get copyWith => _$UpdateNotificationSettingsEventCopyWithImpl<
          UpdateNotificationSettingsEvent>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is UpdateNotificationSettingsEvent &&
            (identical(other.settings, settings) ||
                other.settings == settings));
  }

  @override
  int get hashCode => Object.hash(runtimeType, settings);

  @override
  String toString() {
    return 'SettingsEvent.updateNotificationSettings(settings: $settings)';
  }
}

/// @nodoc
abstract mixin class $UpdateNotificationSettingsEventCopyWith<$Res>
    implements $SettingsEventCopyWith<$Res> {
  factory $UpdateNotificationSettingsEventCopyWith(
          UpdateNotificationSettingsEvent value,
          $Res Function(UpdateNotificationSettingsEvent) _then) =
      _$UpdateNotificationSettingsEventCopyWithImpl;
  @useResult
  $Res call({NotificationSettings settings});
}

/// @nodoc
class _$UpdateNotificationSettingsEventCopyWithImpl<$Res>
    implements $UpdateNotificationSettingsEventCopyWith<$Res> {
  _$UpdateNotificationSettingsEventCopyWithImpl(this._self, this._then);

  final UpdateNotificationSettingsEvent _self;
  final $Res Function(UpdateNotificationSettingsEvent) _then;

  /// Create a copy of SettingsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? settings = null,
  }) {
    return _then(UpdateNotificationSettingsEvent(
      settings: null == settings
          ? _self.settings
          : settings // ignore: cast_nullable_to_non_nullable
              as NotificationSettings,
    ));
  }
}

/// @nodoc

class UpdateSecuritySettingsEvent implements SettingsEvent {
  const UpdateSecuritySettingsEvent({required this.settings});

  final SecuritySettings settings;

  /// Create a copy of SettingsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $UpdateSecuritySettingsEventCopyWith<UpdateSecuritySettingsEvent>
      get copyWith => _$UpdateSecuritySettingsEventCopyWithImpl<
          UpdateSecuritySettingsEvent>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is UpdateSecuritySettingsEvent &&
            (identical(other.settings, settings) ||
                other.settings == settings));
  }

  @override
  int get hashCode => Object.hash(runtimeType, settings);

  @override
  String toString() {
    return 'SettingsEvent.updateSecuritySettings(settings: $settings)';
  }
}

/// @nodoc
abstract mixin class $UpdateSecuritySettingsEventCopyWith<$Res>
    implements $SettingsEventCopyWith<$Res> {
  factory $UpdateSecuritySettingsEventCopyWith(
          UpdateSecuritySettingsEvent value,
          $Res Function(UpdateSecuritySettingsEvent) _then) =
      _$UpdateSecuritySettingsEventCopyWithImpl;
  @useResult
  $Res call({SecuritySettings settings});
}

/// @nodoc
class _$UpdateSecuritySettingsEventCopyWithImpl<$Res>
    implements $UpdateSecuritySettingsEventCopyWith<$Res> {
  _$UpdateSecuritySettingsEventCopyWithImpl(this._self, this._then);

  final UpdateSecuritySettingsEvent _self;
  final $Res Function(UpdateSecuritySettingsEvent) _then;

  /// Create a copy of SettingsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? settings = null,
  }) {
    return _then(UpdateSecuritySettingsEvent(
      settings: null == settings
          ? _self.settings
          : settings // ignore: cast_nullable_to_non_nullable
              as SecuritySettings,
    ));
  }
}

/// @nodoc
mixin _$SettingsState {
// App Settings (Store Info, POS, Language, Display)
  @AppSettingsConverter()
  AppSettings get appSettings; // Printer Settings
  @PrinterSettingsConverter()
  PrinterSettings get printerSettings;
  @PrinterDeviceListConverter()
  List<PrinterDevice> get availablePrinters;
  bool get isScanningPrinters;
  bool get isConnectingPrinter;
  bool get isTogglingBluetooth; // Receipt Settings
  @ReceiptSettingsConverter()
  ReceiptSettings get receiptSettings; // Notification Settings
  @NotificationSettingsConverter()
  NotificationSettings get notificationSettings; // Security Settings
  @SecuritySettingsConverter()
  SecuritySettings get securitySettings; // General Status
  SettingsStatus get status;
  String? get errorMessage;

  /// Create a copy of SettingsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SettingsStateCopyWith<SettingsState> get copyWith =>
      _$SettingsStateCopyWithImpl<SettingsState>(
          this as SettingsState, _$identity);

  /// Serializes this SettingsState to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SettingsState &&
            (identical(other.appSettings, appSettings) ||
                other.appSettings == appSettings) &&
            (identical(other.printerSettings, printerSettings) ||
                other.printerSettings == printerSettings) &&
            const DeepCollectionEquality()
                .equals(other.availablePrinters, availablePrinters) &&
            (identical(other.isScanningPrinters, isScanningPrinters) ||
                other.isScanningPrinters == isScanningPrinters) &&
            (identical(other.isConnectingPrinter, isConnectingPrinter) ||
                other.isConnectingPrinter == isConnectingPrinter) &&
            (identical(other.isTogglingBluetooth, isTogglingBluetooth) ||
                other.isTogglingBluetooth == isTogglingBluetooth) &&
            (identical(other.receiptSettings, receiptSettings) ||
                other.receiptSettings == receiptSettings) &&
            (identical(other.notificationSettings, notificationSettings) ||
                other.notificationSettings == notificationSettings) &&
            (identical(other.securitySettings, securitySettings) ||
                other.securitySettings == securitySettings) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      appSettings,
      printerSettings,
      const DeepCollectionEquality().hash(availablePrinters),
      isScanningPrinters,
      isConnectingPrinter,
      isTogglingBluetooth,
      receiptSettings,
      notificationSettings,
      securitySettings,
      status,
      errorMessage);

  @override
  String toString() {
    return 'SettingsState(appSettings: $appSettings, printerSettings: $printerSettings, availablePrinters: $availablePrinters, isScanningPrinters: $isScanningPrinters, isConnectingPrinter: $isConnectingPrinter, isTogglingBluetooth: $isTogglingBluetooth, receiptSettings: $receiptSettings, notificationSettings: $notificationSettings, securitySettings: $securitySettings, status: $status, errorMessage: $errorMessage)';
  }
}

/// @nodoc
abstract mixin class $SettingsStateCopyWith<$Res> {
  factory $SettingsStateCopyWith(
          SettingsState value, $Res Function(SettingsState) _then) =
      _$SettingsStateCopyWithImpl;
  @useResult
  $Res call(
      {@AppSettingsConverter() AppSettings appSettings,
      @PrinterSettingsConverter() PrinterSettings printerSettings,
      @PrinterDeviceListConverter() List<PrinterDevice> availablePrinters,
      bool isScanningPrinters,
      bool isConnectingPrinter,
      bool isTogglingBluetooth,
      @ReceiptSettingsConverter() ReceiptSettings receiptSettings,
      @NotificationSettingsConverter()
      NotificationSettings notificationSettings,
      @SecuritySettingsConverter() SecuritySettings securitySettings,
      SettingsStatus status,
      String? errorMessage});
}

/// @nodoc
class _$SettingsStateCopyWithImpl<$Res>
    implements $SettingsStateCopyWith<$Res> {
  _$SettingsStateCopyWithImpl(this._self, this._then);

  final SettingsState _self;
  final $Res Function(SettingsState) _then;

  /// Create a copy of SettingsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? appSettings = null,
    Object? printerSettings = null,
    Object? availablePrinters = null,
    Object? isScanningPrinters = null,
    Object? isConnectingPrinter = null,
    Object? isTogglingBluetooth = null,
    Object? receiptSettings = null,
    Object? notificationSettings = null,
    Object? securitySettings = null,
    Object? status = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_self.copyWith(
      appSettings: null == appSettings
          ? _self.appSettings
          : appSettings // ignore: cast_nullable_to_non_nullable
              as AppSettings,
      printerSettings: null == printerSettings
          ? _self.printerSettings
          : printerSettings // ignore: cast_nullable_to_non_nullable
              as PrinterSettings,
      availablePrinters: null == availablePrinters
          ? _self.availablePrinters
          : availablePrinters // ignore: cast_nullable_to_non_nullable
              as List<PrinterDevice>,
      isScanningPrinters: null == isScanningPrinters
          ? _self.isScanningPrinters
          : isScanningPrinters // ignore: cast_nullable_to_non_nullable
              as bool,
      isConnectingPrinter: null == isConnectingPrinter
          ? _self.isConnectingPrinter
          : isConnectingPrinter // ignore: cast_nullable_to_non_nullable
              as bool,
      isTogglingBluetooth: null == isTogglingBluetooth
          ? _self.isTogglingBluetooth
          : isTogglingBluetooth // ignore: cast_nullable_to_non_nullable
              as bool,
      receiptSettings: null == receiptSettings
          ? _self.receiptSettings
          : receiptSettings // ignore: cast_nullable_to_non_nullable
              as ReceiptSettings,
      notificationSettings: null == notificationSettings
          ? _self.notificationSettings
          : notificationSettings // ignore: cast_nullable_to_non_nullable
              as NotificationSettings,
      securitySettings: null == securitySettings
          ? _self.securitySettings
          : securitySettings // ignore: cast_nullable_to_non_nullable
              as SecuritySettings,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as SettingsStatus,
      errorMessage: freezed == errorMessage
          ? _self.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [SettingsState].
extension SettingsStatePatterns on SettingsState {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_SettingsState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SettingsState() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_SettingsState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SettingsState():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_SettingsState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SettingsState() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            @AppSettingsConverter() AppSettings appSettings,
            @PrinterSettingsConverter() PrinterSettings printerSettings,
            @PrinterDeviceListConverter() List<PrinterDevice> availablePrinters,
            bool isScanningPrinters,
            bool isConnectingPrinter,
            bool isTogglingBluetooth,
            @ReceiptSettingsConverter() ReceiptSettings receiptSettings,
            @NotificationSettingsConverter()
            NotificationSettings notificationSettings,
            @SecuritySettingsConverter() SecuritySettings securitySettings,
            SettingsStatus status,
            String? errorMessage)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SettingsState() when $default != null:
        return $default(
            _that.appSettings,
            _that.printerSettings,
            _that.availablePrinters,
            _that.isScanningPrinters,
            _that.isConnectingPrinter,
            _that.isTogglingBluetooth,
            _that.receiptSettings,
            _that.notificationSettings,
            _that.securitySettings,
            _that.status,
            _that.errorMessage);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            @AppSettingsConverter() AppSettings appSettings,
            @PrinterSettingsConverter() PrinterSettings printerSettings,
            @PrinterDeviceListConverter() List<PrinterDevice> availablePrinters,
            bool isScanningPrinters,
            bool isConnectingPrinter,
            bool isTogglingBluetooth,
            @ReceiptSettingsConverter() ReceiptSettings receiptSettings,
            @NotificationSettingsConverter()
            NotificationSettings notificationSettings,
            @SecuritySettingsConverter() SecuritySettings securitySettings,
            SettingsStatus status,
            String? errorMessage)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SettingsState():
        return $default(
            _that.appSettings,
            _that.printerSettings,
            _that.availablePrinters,
            _that.isScanningPrinters,
            _that.isConnectingPrinter,
            _that.isTogglingBluetooth,
            _that.receiptSettings,
            _that.notificationSettings,
            _that.securitySettings,
            _that.status,
            _that.errorMessage);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            @AppSettingsConverter() AppSettings appSettings,
            @PrinterSettingsConverter() PrinterSettings printerSettings,
            @PrinterDeviceListConverter() List<PrinterDevice> availablePrinters,
            bool isScanningPrinters,
            bool isConnectingPrinter,
            bool isTogglingBluetooth,
            @ReceiptSettingsConverter() ReceiptSettings receiptSettings,
            @NotificationSettingsConverter()
            NotificationSettings notificationSettings,
            @SecuritySettingsConverter() SecuritySettings securitySettings,
            SettingsStatus status,
            String? errorMessage)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SettingsState() when $default != null:
        return $default(
            _that.appSettings,
            _that.printerSettings,
            _that.availablePrinters,
            _that.isScanningPrinters,
            _that.isConnectingPrinter,
            _that.isTogglingBluetooth,
            _that.receiptSettings,
            _that.notificationSettings,
            _that.securitySettings,
            _that.status,
            _that.errorMessage);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _SettingsState implements SettingsState {
  const _SettingsState(
      {@AppSettingsConverter() required this.appSettings,
      @PrinterSettingsConverter() required this.printerSettings,
      @PrinterDeviceListConverter()
      final List<PrinterDevice> availablePrinters = const [],
      this.isScanningPrinters = false,
      this.isConnectingPrinter = false,
      this.isTogglingBluetooth = false,
      @ReceiptSettingsConverter() required this.receiptSettings,
      @NotificationSettingsConverter() required this.notificationSettings,
      @SecuritySettingsConverter() required this.securitySettings,
      this.status = SettingsStatus.initial,
      this.errorMessage})
      : _availablePrinters = availablePrinters;
  factory _SettingsState.fromJson(Map<String, dynamic> json) =>
      _$SettingsStateFromJson(json);

// App Settings (Store Info, POS, Language, Display)
  @override
  @AppSettingsConverter()
  final AppSettings appSettings;
// Printer Settings
  @override
  @PrinterSettingsConverter()
  final PrinterSettings printerSettings;
  final List<PrinterDevice> _availablePrinters;
  @override
  @JsonKey()
  @PrinterDeviceListConverter()
  List<PrinterDevice> get availablePrinters {
    if (_availablePrinters is EqualUnmodifiableListView)
      return _availablePrinters;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_availablePrinters);
  }

  @override
  @JsonKey()
  final bool isScanningPrinters;
  @override
  @JsonKey()
  final bool isConnectingPrinter;
  @override
  @JsonKey()
  final bool isTogglingBluetooth;
// Receipt Settings
  @override
  @ReceiptSettingsConverter()
  final ReceiptSettings receiptSettings;
// Notification Settings
  @override
  @NotificationSettingsConverter()
  final NotificationSettings notificationSettings;
// Security Settings
  @override
  @SecuritySettingsConverter()
  final SecuritySettings securitySettings;
// General Status
  @override
  @JsonKey()
  final SettingsStatus status;
  @override
  final String? errorMessage;

  /// Create a copy of SettingsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SettingsStateCopyWith<_SettingsState> get copyWith =>
      __$SettingsStateCopyWithImpl<_SettingsState>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SettingsStateToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SettingsState &&
            (identical(other.appSettings, appSettings) ||
                other.appSettings == appSettings) &&
            (identical(other.printerSettings, printerSettings) ||
                other.printerSettings == printerSettings) &&
            const DeepCollectionEquality()
                .equals(other._availablePrinters, _availablePrinters) &&
            (identical(other.isScanningPrinters, isScanningPrinters) ||
                other.isScanningPrinters == isScanningPrinters) &&
            (identical(other.isConnectingPrinter, isConnectingPrinter) ||
                other.isConnectingPrinter == isConnectingPrinter) &&
            (identical(other.isTogglingBluetooth, isTogglingBluetooth) ||
                other.isTogglingBluetooth == isTogglingBluetooth) &&
            (identical(other.receiptSettings, receiptSettings) ||
                other.receiptSettings == receiptSettings) &&
            (identical(other.notificationSettings, notificationSettings) ||
                other.notificationSettings == notificationSettings) &&
            (identical(other.securitySettings, securitySettings) ||
                other.securitySettings == securitySettings) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      appSettings,
      printerSettings,
      const DeepCollectionEquality().hash(_availablePrinters),
      isScanningPrinters,
      isConnectingPrinter,
      isTogglingBluetooth,
      receiptSettings,
      notificationSettings,
      securitySettings,
      status,
      errorMessage);

  @override
  String toString() {
    return 'SettingsState(appSettings: $appSettings, printerSettings: $printerSettings, availablePrinters: $availablePrinters, isScanningPrinters: $isScanningPrinters, isConnectingPrinter: $isConnectingPrinter, isTogglingBluetooth: $isTogglingBluetooth, receiptSettings: $receiptSettings, notificationSettings: $notificationSettings, securitySettings: $securitySettings, status: $status, errorMessage: $errorMessage)';
  }
}

/// @nodoc
abstract mixin class _$SettingsStateCopyWith<$Res>
    implements $SettingsStateCopyWith<$Res> {
  factory _$SettingsStateCopyWith(
          _SettingsState value, $Res Function(_SettingsState) _then) =
      __$SettingsStateCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@AppSettingsConverter() AppSettings appSettings,
      @PrinterSettingsConverter() PrinterSettings printerSettings,
      @PrinterDeviceListConverter() List<PrinterDevice> availablePrinters,
      bool isScanningPrinters,
      bool isConnectingPrinter,
      bool isTogglingBluetooth,
      @ReceiptSettingsConverter() ReceiptSettings receiptSettings,
      @NotificationSettingsConverter()
      NotificationSettings notificationSettings,
      @SecuritySettingsConverter() SecuritySettings securitySettings,
      SettingsStatus status,
      String? errorMessage});
}

/// @nodoc
class __$SettingsStateCopyWithImpl<$Res>
    implements _$SettingsStateCopyWith<$Res> {
  __$SettingsStateCopyWithImpl(this._self, this._then);

  final _SettingsState _self;
  final $Res Function(_SettingsState) _then;

  /// Create a copy of SettingsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? appSettings = null,
    Object? printerSettings = null,
    Object? availablePrinters = null,
    Object? isScanningPrinters = null,
    Object? isConnectingPrinter = null,
    Object? isTogglingBluetooth = null,
    Object? receiptSettings = null,
    Object? notificationSettings = null,
    Object? securitySettings = null,
    Object? status = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_SettingsState(
      appSettings: null == appSettings
          ? _self.appSettings
          : appSettings // ignore: cast_nullable_to_non_nullable
              as AppSettings,
      printerSettings: null == printerSettings
          ? _self.printerSettings
          : printerSettings // ignore: cast_nullable_to_non_nullable
              as PrinterSettings,
      availablePrinters: null == availablePrinters
          ? _self._availablePrinters
          : availablePrinters // ignore: cast_nullable_to_non_nullable
              as List<PrinterDevice>,
      isScanningPrinters: null == isScanningPrinters
          ? _self.isScanningPrinters
          : isScanningPrinters // ignore: cast_nullable_to_non_nullable
              as bool,
      isConnectingPrinter: null == isConnectingPrinter
          ? _self.isConnectingPrinter
          : isConnectingPrinter // ignore: cast_nullable_to_non_nullable
              as bool,
      isTogglingBluetooth: null == isTogglingBluetooth
          ? _self.isTogglingBluetooth
          : isTogglingBluetooth // ignore: cast_nullable_to_non_nullable
              as bool,
      receiptSettings: null == receiptSettings
          ? _self.receiptSettings
          : receiptSettings // ignore: cast_nullable_to_non_nullable
              as ReceiptSettings,
      notificationSettings: null == notificationSettings
          ? _self.notificationSettings
          : notificationSettings // ignore: cast_nullable_to_non_nullable
              as NotificationSettings,
      securitySettings: null == securitySettings
          ? _self.securitySettings
          : securitySettings // ignore: cast_nullable_to_non_nullable
              as SecuritySettings,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as SettingsStatus,
      errorMessage: freezed == errorMessage
          ? _self.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
