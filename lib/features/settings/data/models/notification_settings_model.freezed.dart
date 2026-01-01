// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_settings_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NotificationSettingsModel {
  @JsonKey(name: "enableNotifications")
  bool get enableNotifications;
  @JsonKey(name: "enableSoundAlerts")
  bool get enableSoundAlerts;
  @JsonKey(name: "notifyOnLowStock")
  bool get notifyOnLowStock;
  @JsonKey(name: "notifyOnNewOrder")
  bool get notifyOnNewOrder;
  @JsonKey(name: "notifyOnPaymentReceived")
  bool get notifyOnPaymentReceived;

  /// Create a copy of NotificationSettingsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $NotificationSettingsModelCopyWith<NotificationSettingsModel> get copyWith =>
      _$NotificationSettingsModelCopyWithImpl<NotificationSettingsModel>(
          this as NotificationSettingsModel, _$identity);

  /// Serializes this NotificationSettingsModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is NotificationSettingsModel &&
            (identical(other.enableNotifications, enableNotifications) ||
                other.enableNotifications == enableNotifications) &&
            (identical(other.enableSoundAlerts, enableSoundAlerts) ||
                other.enableSoundAlerts == enableSoundAlerts) &&
            (identical(other.notifyOnLowStock, notifyOnLowStock) ||
                other.notifyOnLowStock == notifyOnLowStock) &&
            (identical(other.notifyOnNewOrder, notifyOnNewOrder) ||
                other.notifyOnNewOrder == notifyOnNewOrder) &&
            (identical(
                    other.notifyOnPaymentReceived, notifyOnPaymentReceived) ||
                other.notifyOnPaymentReceived == notifyOnPaymentReceived));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      enableNotifications,
      enableSoundAlerts,
      notifyOnLowStock,
      notifyOnNewOrder,
      notifyOnPaymentReceived);

  @override
  String toString() {
    return 'NotificationSettingsModel(enableNotifications: $enableNotifications, enableSoundAlerts: $enableSoundAlerts, notifyOnLowStock: $notifyOnLowStock, notifyOnNewOrder: $notifyOnNewOrder, notifyOnPaymentReceived: $notifyOnPaymentReceived)';
  }
}

/// @nodoc
abstract mixin class $NotificationSettingsModelCopyWith<$Res> {
  factory $NotificationSettingsModelCopyWith(NotificationSettingsModel value,
          $Res Function(NotificationSettingsModel) _then) =
      _$NotificationSettingsModelCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: "enableNotifications") bool enableNotifications,
      @JsonKey(name: "enableSoundAlerts") bool enableSoundAlerts,
      @JsonKey(name: "notifyOnLowStock") bool notifyOnLowStock,
      @JsonKey(name: "notifyOnNewOrder") bool notifyOnNewOrder,
      @JsonKey(name: "notifyOnPaymentReceived") bool notifyOnPaymentReceived});
}

/// @nodoc
class _$NotificationSettingsModelCopyWithImpl<$Res>
    implements $NotificationSettingsModelCopyWith<$Res> {
  _$NotificationSettingsModelCopyWithImpl(this._self, this._then);

  final NotificationSettingsModel _self;
  final $Res Function(NotificationSettingsModel) _then;

  /// Create a copy of NotificationSettingsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? enableNotifications = null,
    Object? enableSoundAlerts = null,
    Object? notifyOnLowStock = null,
    Object? notifyOnNewOrder = null,
    Object? notifyOnPaymentReceived = null,
  }) {
    return _then(_self.copyWith(
      enableNotifications: null == enableNotifications
          ? _self.enableNotifications
          : enableNotifications // ignore: cast_nullable_to_non_nullable
              as bool,
      enableSoundAlerts: null == enableSoundAlerts
          ? _self.enableSoundAlerts
          : enableSoundAlerts // ignore: cast_nullable_to_non_nullable
              as bool,
      notifyOnLowStock: null == notifyOnLowStock
          ? _self.notifyOnLowStock
          : notifyOnLowStock // ignore: cast_nullable_to_non_nullable
              as bool,
      notifyOnNewOrder: null == notifyOnNewOrder
          ? _self.notifyOnNewOrder
          : notifyOnNewOrder // ignore: cast_nullable_to_non_nullable
              as bool,
      notifyOnPaymentReceived: null == notifyOnPaymentReceived
          ? _self.notifyOnPaymentReceived
          : notifyOnPaymentReceived // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// Adds pattern-matching-related methods to [NotificationSettingsModel].
extension NotificationSettingsModelPatterns on NotificationSettingsModel {
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
    TResult Function(_NotificationSettingsModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _NotificationSettingsModel() when $default != null:
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
    TResult Function(_NotificationSettingsModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NotificationSettingsModel():
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
    TResult? Function(_NotificationSettingsModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NotificationSettingsModel() when $default != null:
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
            @JsonKey(name: "enableNotifications") bool enableNotifications,
            @JsonKey(name: "enableSoundAlerts") bool enableSoundAlerts,
            @JsonKey(name: "notifyOnLowStock") bool notifyOnLowStock,
            @JsonKey(name: "notifyOnNewOrder") bool notifyOnNewOrder,
            @JsonKey(name: "notifyOnPaymentReceived")
            bool notifyOnPaymentReceived)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _NotificationSettingsModel() when $default != null:
        return $default(
            _that.enableNotifications,
            _that.enableSoundAlerts,
            _that.notifyOnLowStock,
            _that.notifyOnNewOrder,
            _that.notifyOnPaymentReceived);
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
            @JsonKey(name: "enableNotifications") bool enableNotifications,
            @JsonKey(name: "enableSoundAlerts") bool enableSoundAlerts,
            @JsonKey(name: "notifyOnLowStock") bool notifyOnLowStock,
            @JsonKey(name: "notifyOnNewOrder") bool notifyOnNewOrder,
            @JsonKey(name: "notifyOnPaymentReceived")
            bool notifyOnPaymentReceived)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NotificationSettingsModel():
        return $default(
            _that.enableNotifications,
            _that.enableSoundAlerts,
            _that.notifyOnLowStock,
            _that.notifyOnNewOrder,
            _that.notifyOnPaymentReceived);
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
            @JsonKey(name: "enableNotifications") bool enableNotifications,
            @JsonKey(name: "enableSoundAlerts") bool enableSoundAlerts,
            @JsonKey(name: "notifyOnLowStock") bool notifyOnLowStock,
            @JsonKey(name: "notifyOnNewOrder") bool notifyOnNewOrder,
            @JsonKey(name: "notifyOnPaymentReceived")
            bool notifyOnPaymentReceived)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NotificationSettingsModel() when $default != null:
        return $default(
            _that.enableNotifications,
            _that.enableSoundAlerts,
            _that.notifyOnLowStock,
            _that.notifyOnNewOrder,
            _that.notifyOnPaymentReceived);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _NotificationSettingsModel extends NotificationSettingsModel {
  const _NotificationSettingsModel(
      {@JsonKey(name: "enableNotifications") required this.enableNotifications,
      @JsonKey(name: "enableSoundAlerts") required this.enableSoundAlerts,
      @JsonKey(name: "notifyOnLowStock") required this.notifyOnLowStock,
      @JsonKey(name: "notifyOnNewOrder") required this.notifyOnNewOrder,
      @JsonKey(name: "notifyOnPaymentReceived")
      required this.notifyOnPaymentReceived})
      : super._();
  factory _NotificationSettingsModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationSettingsModelFromJson(json);

  @override
  @JsonKey(name: "enableNotifications")
  final bool enableNotifications;
  @override
  @JsonKey(name: "enableSoundAlerts")
  final bool enableSoundAlerts;
  @override
  @JsonKey(name: "notifyOnLowStock")
  final bool notifyOnLowStock;
  @override
  @JsonKey(name: "notifyOnNewOrder")
  final bool notifyOnNewOrder;
  @override
  @JsonKey(name: "notifyOnPaymentReceived")
  final bool notifyOnPaymentReceived;

  /// Create a copy of NotificationSettingsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$NotificationSettingsModelCopyWith<_NotificationSettingsModel>
      get copyWith =>
          __$NotificationSettingsModelCopyWithImpl<_NotificationSettingsModel>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$NotificationSettingsModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _NotificationSettingsModel &&
            (identical(other.enableNotifications, enableNotifications) ||
                other.enableNotifications == enableNotifications) &&
            (identical(other.enableSoundAlerts, enableSoundAlerts) ||
                other.enableSoundAlerts == enableSoundAlerts) &&
            (identical(other.notifyOnLowStock, notifyOnLowStock) ||
                other.notifyOnLowStock == notifyOnLowStock) &&
            (identical(other.notifyOnNewOrder, notifyOnNewOrder) ||
                other.notifyOnNewOrder == notifyOnNewOrder) &&
            (identical(
                    other.notifyOnPaymentReceived, notifyOnPaymentReceived) ||
                other.notifyOnPaymentReceived == notifyOnPaymentReceived));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      enableNotifications,
      enableSoundAlerts,
      notifyOnLowStock,
      notifyOnNewOrder,
      notifyOnPaymentReceived);

  @override
  String toString() {
    return 'NotificationSettingsModel(enableNotifications: $enableNotifications, enableSoundAlerts: $enableSoundAlerts, notifyOnLowStock: $notifyOnLowStock, notifyOnNewOrder: $notifyOnNewOrder, notifyOnPaymentReceived: $notifyOnPaymentReceived)';
  }
}

/// @nodoc
abstract mixin class _$NotificationSettingsModelCopyWith<$Res>
    implements $NotificationSettingsModelCopyWith<$Res> {
  factory _$NotificationSettingsModelCopyWith(_NotificationSettingsModel value,
          $Res Function(_NotificationSettingsModel) _then) =
      __$NotificationSettingsModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "enableNotifications") bool enableNotifications,
      @JsonKey(name: "enableSoundAlerts") bool enableSoundAlerts,
      @JsonKey(name: "notifyOnLowStock") bool notifyOnLowStock,
      @JsonKey(name: "notifyOnNewOrder") bool notifyOnNewOrder,
      @JsonKey(name: "notifyOnPaymentReceived") bool notifyOnPaymentReceived});
}

/// @nodoc
class __$NotificationSettingsModelCopyWithImpl<$Res>
    implements _$NotificationSettingsModelCopyWith<$Res> {
  __$NotificationSettingsModelCopyWithImpl(this._self, this._then);

  final _NotificationSettingsModel _self;
  final $Res Function(_NotificationSettingsModel) _then;

  /// Create a copy of NotificationSettingsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? enableNotifications = null,
    Object? enableSoundAlerts = null,
    Object? notifyOnLowStock = null,
    Object? notifyOnNewOrder = null,
    Object? notifyOnPaymentReceived = null,
  }) {
    return _then(_NotificationSettingsModel(
      enableNotifications: null == enableNotifications
          ? _self.enableNotifications
          : enableNotifications // ignore: cast_nullable_to_non_nullable
              as bool,
      enableSoundAlerts: null == enableSoundAlerts
          ? _self.enableSoundAlerts
          : enableSoundAlerts // ignore: cast_nullable_to_non_nullable
              as bool,
      notifyOnLowStock: null == notifyOnLowStock
          ? _self.notifyOnLowStock
          : notifyOnLowStock // ignore: cast_nullable_to_non_nullable
              as bool,
      notifyOnNewOrder: null == notifyOnNewOrder
          ? _self.notifyOnNewOrder
          : notifyOnNewOrder // ignore: cast_nullable_to_non_nullable
              as bool,
      notifyOnPaymentReceived: null == notifyOnPaymentReceived
          ? _self.notifyOnPaymentReceived
          : notifyOnPaymentReceived // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
