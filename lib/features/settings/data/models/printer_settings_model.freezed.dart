// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'printer_settings_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PrinterSettingsModel {
  @JsonKey(name: "bluetoothEnabled")
  bool get bluetoothEnabled;
  @JsonKey(name: "connectedPrinterName")
  String? get connectedPrinterName;
  @JsonKey(name: "connectedPrinterMac")
  String? get connectedPrinterMac;
  @JsonKey(name: "paperSize")
  String get paperSize;
  @JsonKey(name: "autoPrintReceipt")
  bool get autoPrintReceipt;
  @JsonKey(name: "printLogo")
  bool get printLogo;

  /// Create a copy of PrinterSettingsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PrinterSettingsModelCopyWith<PrinterSettingsModel> get copyWith =>
      _$PrinterSettingsModelCopyWithImpl<PrinterSettingsModel>(
          this as PrinterSettingsModel, _$identity);

  /// Serializes this PrinterSettingsModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PrinterSettingsModel &&
            (identical(other.bluetoothEnabled, bluetoothEnabled) ||
                other.bluetoothEnabled == bluetoothEnabled) &&
            (identical(other.connectedPrinterName, connectedPrinterName) ||
                other.connectedPrinterName == connectedPrinterName) &&
            (identical(other.connectedPrinterMac, connectedPrinterMac) ||
                other.connectedPrinterMac == connectedPrinterMac) &&
            (identical(other.paperSize, paperSize) ||
                other.paperSize == paperSize) &&
            (identical(other.autoPrintReceipt, autoPrintReceipt) ||
                other.autoPrintReceipt == autoPrintReceipt) &&
            (identical(other.printLogo, printLogo) ||
                other.printLogo == printLogo));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      bluetoothEnabled,
      connectedPrinterName,
      connectedPrinterMac,
      paperSize,
      autoPrintReceipt,
      printLogo);

  @override
  String toString() {
    return 'PrinterSettingsModel(bluetoothEnabled: $bluetoothEnabled, connectedPrinterName: $connectedPrinterName, connectedPrinterMac: $connectedPrinterMac, paperSize: $paperSize, autoPrintReceipt: $autoPrintReceipt, printLogo: $printLogo)';
  }
}

/// @nodoc
abstract mixin class $PrinterSettingsModelCopyWith<$Res> {
  factory $PrinterSettingsModelCopyWith(PrinterSettingsModel value,
          $Res Function(PrinterSettingsModel) _then) =
      _$PrinterSettingsModelCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: "bluetoothEnabled") bool bluetoothEnabled,
      @JsonKey(name: "connectedPrinterName") String? connectedPrinterName,
      @JsonKey(name: "connectedPrinterMac") String? connectedPrinterMac,
      @JsonKey(name: "paperSize") String paperSize,
      @JsonKey(name: "autoPrintReceipt") bool autoPrintReceipt,
      @JsonKey(name: "printLogo") bool printLogo});
}

/// @nodoc
class _$PrinterSettingsModelCopyWithImpl<$Res>
    implements $PrinterSettingsModelCopyWith<$Res> {
  _$PrinterSettingsModelCopyWithImpl(this._self, this._then);

  final PrinterSettingsModel _self;
  final $Res Function(PrinterSettingsModel) _then;

  /// Create a copy of PrinterSettingsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bluetoothEnabled = null,
    Object? connectedPrinterName = freezed,
    Object? connectedPrinterMac = freezed,
    Object? paperSize = null,
    Object? autoPrintReceipt = null,
    Object? printLogo = null,
  }) {
    return _then(_self.copyWith(
      bluetoothEnabled: null == bluetoothEnabled
          ? _self.bluetoothEnabled
          : bluetoothEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      connectedPrinterName: freezed == connectedPrinterName
          ? _self.connectedPrinterName
          : connectedPrinterName // ignore: cast_nullable_to_non_nullable
              as String?,
      connectedPrinterMac: freezed == connectedPrinterMac
          ? _self.connectedPrinterMac
          : connectedPrinterMac // ignore: cast_nullable_to_non_nullable
              as String?,
      paperSize: null == paperSize
          ? _self.paperSize
          : paperSize // ignore: cast_nullable_to_non_nullable
              as String,
      autoPrintReceipt: null == autoPrintReceipt
          ? _self.autoPrintReceipt
          : autoPrintReceipt // ignore: cast_nullable_to_non_nullable
              as bool,
      printLogo: null == printLogo
          ? _self.printLogo
          : printLogo // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// Adds pattern-matching-related methods to [PrinterSettingsModel].
extension PrinterSettingsModelPatterns on PrinterSettingsModel {
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
    TResult Function(_PrinterSettingsModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PrinterSettingsModel() when $default != null:
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
    TResult Function(_PrinterSettingsModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PrinterSettingsModel():
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
    TResult? Function(_PrinterSettingsModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PrinterSettingsModel() when $default != null:
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
            @JsonKey(name: "bluetoothEnabled") bool bluetoothEnabled,
            @JsonKey(name: "connectedPrinterName") String? connectedPrinterName,
            @JsonKey(name: "connectedPrinterMac") String? connectedPrinterMac,
            @JsonKey(name: "paperSize") String paperSize,
            @JsonKey(name: "autoPrintReceipt") bool autoPrintReceipt,
            @JsonKey(name: "printLogo") bool printLogo)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PrinterSettingsModel() when $default != null:
        return $default(
            _that.bluetoothEnabled,
            _that.connectedPrinterName,
            _that.connectedPrinterMac,
            _that.paperSize,
            _that.autoPrintReceipt,
            _that.printLogo);
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
            @JsonKey(name: "bluetoothEnabled") bool bluetoothEnabled,
            @JsonKey(name: "connectedPrinterName") String? connectedPrinterName,
            @JsonKey(name: "connectedPrinterMac") String? connectedPrinterMac,
            @JsonKey(name: "paperSize") String paperSize,
            @JsonKey(name: "autoPrintReceipt") bool autoPrintReceipt,
            @JsonKey(name: "printLogo") bool printLogo)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PrinterSettingsModel():
        return $default(
            _that.bluetoothEnabled,
            _that.connectedPrinterName,
            _that.connectedPrinterMac,
            _that.paperSize,
            _that.autoPrintReceipt,
            _that.printLogo);
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
            @JsonKey(name: "bluetoothEnabled") bool bluetoothEnabled,
            @JsonKey(name: "connectedPrinterName") String? connectedPrinterName,
            @JsonKey(name: "connectedPrinterMac") String? connectedPrinterMac,
            @JsonKey(name: "paperSize") String paperSize,
            @JsonKey(name: "autoPrintReceipt") bool autoPrintReceipt,
            @JsonKey(name: "printLogo") bool printLogo)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PrinterSettingsModel() when $default != null:
        return $default(
            _that.bluetoothEnabled,
            _that.connectedPrinterName,
            _that.connectedPrinterMac,
            _that.paperSize,
            _that.autoPrintReceipt,
            _that.printLogo);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _PrinterSettingsModel extends PrinterSettingsModel {
  const _PrinterSettingsModel(
      {@JsonKey(name: "bluetoothEnabled") required this.bluetoothEnabled,
      @JsonKey(name: "connectedPrinterName") this.connectedPrinterName,
      @JsonKey(name: "connectedPrinterMac") this.connectedPrinterMac,
      @JsonKey(name: "paperSize") required this.paperSize,
      @JsonKey(name: "autoPrintReceipt") required this.autoPrintReceipt,
      @JsonKey(name: "printLogo") required this.printLogo})
      : super._();
  factory _PrinterSettingsModel.fromJson(Map<String, dynamic> json) =>
      _$PrinterSettingsModelFromJson(json);

  @override
  @JsonKey(name: "bluetoothEnabled")
  final bool bluetoothEnabled;
  @override
  @JsonKey(name: "connectedPrinterName")
  final String? connectedPrinterName;
  @override
  @JsonKey(name: "connectedPrinterMac")
  final String? connectedPrinterMac;
  @override
  @JsonKey(name: "paperSize")
  final String paperSize;
  @override
  @JsonKey(name: "autoPrintReceipt")
  final bool autoPrintReceipt;
  @override
  @JsonKey(name: "printLogo")
  final bool printLogo;

  /// Create a copy of PrinterSettingsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PrinterSettingsModelCopyWith<_PrinterSettingsModel> get copyWith =>
      __$PrinterSettingsModelCopyWithImpl<_PrinterSettingsModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$PrinterSettingsModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PrinterSettingsModel &&
            (identical(other.bluetoothEnabled, bluetoothEnabled) ||
                other.bluetoothEnabled == bluetoothEnabled) &&
            (identical(other.connectedPrinterName, connectedPrinterName) ||
                other.connectedPrinterName == connectedPrinterName) &&
            (identical(other.connectedPrinterMac, connectedPrinterMac) ||
                other.connectedPrinterMac == connectedPrinterMac) &&
            (identical(other.paperSize, paperSize) ||
                other.paperSize == paperSize) &&
            (identical(other.autoPrintReceipt, autoPrintReceipt) ||
                other.autoPrintReceipt == autoPrintReceipt) &&
            (identical(other.printLogo, printLogo) ||
                other.printLogo == printLogo));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      bluetoothEnabled,
      connectedPrinterName,
      connectedPrinterMac,
      paperSize,
      autoPrintReceipt,
      printLogo);

  @override
  String toString() {
    return 'PrinterSettingsModel(bluetoothEnabled: $bluetoothEnabled, connectedPrinterName: $connectedPrinterName, connectedPrinterMac: $connectedPrinterMac, paperSize: $paperSize, autoPrintReceipt: $autoPrintReceipt, printLogo: $printLogo)';
  }
}

/// @nodoc
abstract mixin class _$PrinterSettingsModelCopyWith<$Res>
    implements $PrinterSettingsModelCopyWith<$Res> {
  factory _$PrinterSettingsModelCopyWith(_PrinterSettingsModel value,
          $Res Function(_PrinterSettingsModel) _then) =
      __$PrinterSettingsModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "bluetoothEnabled") bool bluetoothEnabled,
      @JsonKey(name: "connectedPrinterName") String? connectedPrinterName,
      @JsonKey(name: "connectedPrinterMac") String? connectedPrinterMac,
      @JsonKey(name: "paperSize") String paperSize,
      @JsonKey(name: "autoPrintReceipt") bool autoPrintReceipt,
      @JsonKey(name: "printLogo") bool printLogo});
}

/// @nodoc
class __$PrinterSettingsModelCopyWithImpl<$Res>
    implements _$PrinterSettingsModelCopyWith<$Res> {
  __$PrinterSettingsModelCopyWithImpl(this._self, this._then);

  final _PrinterSettingsModel _self;
  final $Res Function(_PrinterSettingsModel) _then;

  /// Create a copy of PrinterSettingsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? bluetoothEnabled = null,
    Object? connectedPrinterName = freezed,
    Object? connectedPrinterMac = freezed,
    Object? paperSize = null,
    Object? autoPrintReceipt = null,
    Object? printLogo = null,
  }) {
    return _then(_PrinterSettingsModel(
      bluetoothEnabled: null == bluetoothEnabled
          ? _self.bluetoothEnabled
          : bluetoothEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      connectedPrinterName: freezed == connectedPrinterName
          ? _self.connectedPrinterName
          : connectedPrinterName // ignore: cast_nullable_to_non_nullable
              as String?,
      connectedPrinterMac: freezed == connectedPrinterMac
          ? _self.connectedPrinterMac
          : connectedPrinterMac // ignore: cast_nullable_to_non_nullable
              as String?,
      paperSize: null == paperSize
          ? _self.paperSize
          : paperSize // ignore: cast_nullable_to_non_nullable
              as String,
      autoPrintReceipt: null == autoPrintReceipt
          ? _self.autoPrintReceipt
          : autoPrintReceipt // ignore: cast_nullable_to_non_nullable
              as bool,
      printLogo: null == printLogo
          ? _self.printLogo
          : printLogo // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
