// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'security_settings_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SecuritySettingsModel {
  @JsonKey(name: "requirePinForRefund")
  bool get requirePinForRefund;
  @JsonKey(name: "requirePinForDiscount")
  bool get requirePinForDiscount;
  @JsonKey(name: "requirePinForVoid")
  bool get requirePinForVoid;
  @JsonKey(name: "autoLockAfterInactivity")
  bool get autoLockAfterInactivity;
  @JsonKey(name: "autoLockDurationMinutes")
  int get autoLockDurationMinutes;

  /// Create a copy of SecuritySettingsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SecuritySettingsModelCopyWith<SecuritySettingsModel> get copyWith =>
      _$SecuritySettingsModelCopyWithImpl<SecuritySettingsModel>(
          this as SecuritySettingsModel, _$identity);

  /// Serializes this SecuritySettingsModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SecuritySettingsModel &&
            (identical(other.requirePinForRefund, requirePinForRefund) ||
                other.requirePinForRefund == requirePinForRefund) &&
            (identical(other.requirePinForDiscount, requirePinForDiscount) ||
                other.requirePinForDiscount == requirePinForDiscount) &&
            (identical(other.requirePinForVoid, requirePinForVoid) ||
                other.requirePinForVoid == requirePinForVoid) &&
            (identical(
                    other.autoLockAfterInactivity, autoLockAfterInactivity) ||
                other.autoLockAfterInactivity == autoLockAfterInactivity) &&
            (identical(
                    other.autoLockDurationMinutes, autoLockDurationMinutes) ||
                other.autoLockDurationMinutes == autoLockDurationMinutes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      requirePinForRefund,
      requirePinForDiscount,
      requirePinForVoid,
      autoLockAfterInactivity,
      autoLockDurationMinutes);

  @override
  String toString() {
    return 'SecuritySettingsModel(requirePinForRefund: $requirePinForRefund, requirePinForDiscount: $requirePinForDiscount, requirePinForVoid: $requirePinForVoid, autoLockAfterInactivity: $autoLockAfterInactivity, autoLockDurationMinutes: $autoLockDurationMinutes)';
  }
}

/// @nodoc
abstract mixin class $SecuritySettingsModelCopyWith<$Res> {
  factory $SecuritySettingsModelCopyWith(SecuritySettingsModel value,
          $Res Function(SecuritySettingsModel) _then) =
      _$SecuritySettingsModelCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: "requirePinForRefund") bool requirePinForRefund,
      @JsonKey(name: "requirePinForDiscount") bool requirePinForDiscount,
      @JsonKey(name: "requirePinForVoid") bool requirePinForVoid,
      @JsonKey(name: "autoLockAfterInactivity") bool autoLockAfterInactivity,
      @JsonKey(name: "autoLockDurationMinutes") int autoLockDurationMinutes});
}

/// @nodoc
class _$SecuritySettingsModelCopyWithImpl<$Res>
    implements $SecuritySettingsModelCopyWith<$Res> {
  _$SecuritySettingsModelCopyWithImpl(this._self, this._then);

  final SecuritySettingsModel _self;
  final $Res Function(SecuritySettingsModel) _then;

  /// Create a copy of SecuritySettingsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? requirePinForRefund = null,
    Object? requirePinForDiscount = null,
    Object? requirePinForVoid = null,
    Object? autoLockAfterInactivity = null,
    Object? autoLockDurationMinutes = null,
  }) {
    return _then(_self.copyWith(
      requirePinForRefund: null == requirePinForRefund
          ? _self.requirePinForRefund
          : requirePinForRefund // ignore: cast_nullable_to_non_nullable
              as bool,
      requirePinForDiscount: null == requirePinForDiscount
          ? _self.requirePinForDiscount
          : requirePinForDiscount // ignore: cast_nullable_to_non_nullable
              as bool,
      requirePinForVoid: null == requirePinForVoid
          ? _self.requirePinForVoid
          : requirePinForVoid // ignore: cast_nullable_to_non_nullable
              as bool,
      autoLockAfterInactivity: null == autoLockAfterInactivity
          ? _self.autoLockAfterInactivity
          : autoLockAfterInactivity // ignore: cast_nullable_to_non_nullable
              as bool,
      autoLockDurationMinutes: null == autoLockDurationMinutes
          ? _self.autoLockDurationMinutes
          : autoLockDurationMinutes // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// Adds pattern-matching-related methods to [SecuritySettingsModel].
extension SecuritySettingsModelPatterns on SecuritySettingsModel {
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
    TResult Function(_SecuritySettingsModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SecuritySettingsModel() when $default != null:
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
    TResult Function(_SecuritySettingsModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SecuritySettingsModel():
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
    TResult? Function(_SecuritySettingsModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SecuritySettingsModel() when $default != null:
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
            @JsonKey(name: "requirePinForRefund") bool requirePinForRefund,
            @JsonKey(name: "requirePinForDiscount") bool requirePinForDiscount,
            @JsonKey(name: "requirePinForVoid") bool requirePinForVoid,
            @JsonKey(name: "autoLockAfterInactivity")
            bool autoLockAfterInactivity,
            @JsonKey(name: "autoLockDurationMinutes")
            int autoLockDurationMinutes)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SecuritySettingsModel() when $default != null:
        return $default(
            _that.requirePinForRefund,
            _that.requirePinForDiscount,
            _that.requirePinForVoid,
            _that.autoLockAfterInactivity,
            _that.autoLockDurationMinutes);
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
            @JsonKey(name: "requirePinForRefund") bool requirePinForRefund,
            @JsonKey(name: "requirePinForDiscount") bool requirePinForDiscount,
            @JsonKey(name: "requirePinForVoid") bool requirePinForVoid,
            @JsonKey(name: "autoLockAfterInactivity")
            bool autoLockAfterInactivity,
            @JsonKey(name: "autoLockDurationMinutes")
            int autoLockDurationMinutes)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SecuritySettingsModel():
        return $default(
            _that.requirePinForRefund,
            _that.requirePinForDiscount,
            _that.requirePinForVoid,
            _that.autoLockAfterInactivity,
            _that.autoLockDurationMinutes);
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
            @JsonKey(name: "requirePinForRefund") bool requirePinForRefund,
            @JsonKey(name: "requirePinForDiscount") bool requirePinForDiscount,
            @JsonKey(name: "requirePinForVoid") bool requirePinForVoid,
            @JsonKey(name: "autoLockAfterInactivity")
            bool autoLockAfterInactivity,
            @JsonKey(name: "autoLockDurationMinutes")
            int autoLockDurationMinutes)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SecuritySettingsModel() when $default != null:
        return $default(
            _that.requirePinForRefund,
            _that.requirePinForDiscount,
            _that.requirePinForVoid,
            _that.autoLockAfterInactivity,
            _that.autoLockDurationMinutes);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _SecuritySettingsModel extends SecuritySettingsModel {
  const _SecuritySettingsModel(
      {@JsonKey(name: "requirePinForRefund") required this.requirePinForRefund,
      @JsonKey(name: "requirePinForDiscount")
      required this.requirePinForDiscount,
      @JsonKey(name: "requirePinForVoid") required this.requirePinForVoid,
      @JsonKey(name: "autoLockAfterInactivity")
      required this.autoLockAfterInactivity,
      @JsonKey(name: "autoLockDurationMinutes")
      required this.autoLockDurationMinutes})
      : super._();
  factory _SecuritySettingsModel.fromJson(Map<String, dynamic> json) =>
      _$SecuritySettingsModelFromJson(json);

  @override
  @JsonKey(name: "requirePinForRefund")
  final bool requirePinForRefund;
  @override
  @JsonKey(name: "requirePinForDiscount")
  final bool requirePinForDiscount;
  @override
  @JsonKey(name: "requirePinForVoid")
  final bool requirePinForVoid;
  @override
  @JsonKey(name: "autoLockAfterInactivity")
  final bool autoLockAfterInactivity;
  @override
  @JsonKey(name: "autoLockDurationMinutes")
  final int autoLockDurationMinutes;

  /// Create a copy of SecuritySettingsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SecuritySettingsModelCopyWith<_SecuritySettingsModel> get copyWith =>
      __$SecuritySettingsModelCopyWithImpl<_SecuritySettingsModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SecuritySettingsModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SecuritySettingsModel &&
            (identical(other.requirePinForRefund, requirePinForRefund) ||
                other.requirePinForRefund == requirePinForRefund) &&
            (identical(other.requirePinForDiscount, requirePinForDiscount) ||
                other.requirePinForDiscount == requirePinForDiscount) &&
            (identical(other.requirePinForVoid, requirePinForVoid) ||
                other.requirePinForVoid == requirePinForVoid) &&
            (identical(
                    other.autoLockAfterInactivity, autoLockAfterInactivity) ||
                other.autoLockAfterInactivity == autoLockAfterInactivity) &&
            (identical(
                    other.autoLockDurationMinutes, autoLockDurationMinutes) ||
                other.autoLockDurationMinutes == autoLockDurationMinutes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      requirePinForRefund,
      requirePinForDiscount,
      requirePinForVoid,
      autoLockAfterInactivity,
      autoLockDurationMinutes);

  @override
  String toString() {
    return 'SecuritySettingsModel(requirePinForRefund: $requirePinForRefund, requirePinForDiscount: $requirePinForDiscount, requirePinForVoid: $requirePinForVoid, autoLockAfterInactivity: $autoLockAfterInactivity, autoLockDurationMinutes: $autoLockDurationMinutes)';
  }
}

/// @nodoc
abstract mixin class _$SecuritySettingsModelCopyWith<$Res>
    implements $SecuritySettingsModelCopyWith<$Res> {
  factory _$SecuritySettingsModelCopyWith(_SecuritySettingsModel value,
          $Res Function(_SecuritySettingsModel) _then) =
      __$SecuritySettingsModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "requirePinForRefund") bool requirePinForRefund,
      @JsonKey(name: "requirePinForDiscount") bool requirePinForDiscount,
      @JsonKey(name: "requirePinForVoid") bool requirePinForVoid,
      @JsonKey(name: "autoLockAfterInactivity") bool autoLockAfterInactivity,
      @JsonKey(name: "autoLockDurationMinutes") int autoLockDurationMinutes});
}

/// @nodoc
class __$SecuritySettingsModelCopyWithImpl<$Res>
    implements _$SecuritySettingsModelCopyWith<$Res> {
  __$SecuritySettingsModelCopyWithImpl(this._self, this._then);

  final _SecuritySettingsModel _self;
  final $Res Function(_SecuritySettingsModel) _then;

  /// Create a copy of SecuritySettingsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? requirePinForRefund = null,
    Object? requirePinForDiscount = null,
    Object? requirePinForVoid = null,
    Object? autoLockAfterInactivity = null,
    Object? autoLockDurationMinutes = null,
  }) {
    return _then(_SecuritySettingsModel(
      requirePinForRefund: null == requirePinForRefund
          ? _self.requirePinForRefund
          : requirePinForRefund // ignore: cast_nullable_to_non_nullable
              as bool,
      requirePinForDiscount: null == requirePinForDiscount
          ? _self.requirePinForDiscount
          : requirePinForDiscount // ignore: cast_nullable_to_non_nullable
              as bool,
      requirePinForVoid: null == requirePinForVoid
          ? _self.requirePinForVoid
          : requirePinForVoid // ignore: cast_nullable_to_non_nullable
              as bool,
      autoLockAfterInactivity: null == autoLockAfterInactivity
          ? _self.autoLockAfterInactivity
          : autoLockAfterInactivity // ignore: cast_nullable_to_non_nullable
              as bool,
      autoLockDurationMinutes: null == autoLockDurationMinutes
          ? _self.autoLockDurationMinutes
          : autoLockDurationMinutes // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

// dart format on
