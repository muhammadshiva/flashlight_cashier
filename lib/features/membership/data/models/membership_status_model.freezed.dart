// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'membership_status_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MembershipStatusModel {
  @JsonKey(name: "type")
  String get type;
  @JsonKey(name: "message")
  String get message;
  @JsonKey(name: "membershipLevel")
  String? get membershipLevel;
  @JsonKey(name: "isLoading")
  bool get isLoading;

  /// Create a copy of MembershipStatusModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MembershipStatusModelCopyWith<MembershipStatusModel> get copyWith =>
      _$MembershipStatusModelCopyWithImpl<MembershipStatusModel>(
          this as MembershipStatusModel, _$identity);

  /// Serializes this MembershipStatusModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is MembershipStatusModel &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.membershipLevel, membershipLevel) ||
                other.membershipLevel == membershipLevel) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, type, message, membershipLevel, isLoading);

  @override
  String toString() {
    return 'MembershipStatusModel(type: $type, message: $message, membershipLevel: $membershipLevel, isLoading: $isLoading)';
  }
}

/// @nodoc
abstract mixin class $MembershipStatusModelCopyWith<$Res> {
  factory $MembershipStatusModelCopyWith(MembershipStatusModel value,
          $Res Function(MembershipStatusModel) _then) =
      _$MembershipStatusModelCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: "type") String type,
      @JsonKey(name: "message") String message,
      @JsonKey(name: "membershipLevel") String? membershipLevel,
      @JsonKey(name: "isLoading") bool isLoading});
}

/// @nodoc
class _$MembershipStatusModelCopyWithImpl<$Res>
    implements $MembershipStatusModelCopyWith<$Res> {
  _$MembershipStatusModelCopyWithImpl(this._self, this._then);

  final MembershipStatusModel _self;
  final $Res Function(MembershipStatusModel) _then;

  /// Create a copy of MembershipStatusModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? message = null,
    Object? membershipLevel = freezed,
    Object? isLoading = null,
  }) {
    return _then(_self.copyWith(
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      membershipLevel: freezed == membershipLevel
          ? _self.membershipLevel
          : membershipLevel // ignore: cast_nullable_to_non_nullable
              as String?,
      isLoading: null == isLoading
          ? _self.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// Adds pattern-matching-related methods to [MembershipStatusModel].
extension MembershipStatusModelPatterns on MembershipStatusModel {
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
    TResult Function(_MembershipStatusModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _MembershipStatusModel() when $default != null:
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
    TResult Function(_MembershipStatusModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MembershipStatusModel():
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
    TResult? Function(_MembershipStatusModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MembershipStatusModel() when $default != null:
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
            @JsonKey(name: "type") String type,
            @JsonKey(name: "message") String message,
            @JsonKey(name: "membershipLevel") String? membershipLevel,
            @JsonKey(name: "isLoading") bool isLoading)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _MembershipStatusModel() when $default != null:
        return $default(
            _that.type, _that.message, _that.membershipLevel, _that.isLoading);
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
            @JsonKey(name: "type") String type,
            @JsonKey(name: "message") String message,
            @JsonKey(name: "membershipLevel") String? membershipLevel,
            @JsonKey(name: "isLoading") bool isLoading)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MembershipStatusModel():
        return $default(
            _that.type, _that.message, _that.membershipLevel, _that.isLoading);
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
            @JsonKey(name: "type") String type,
            @JsonKey(name: "message") String message,
            @JsonKey(name: "membershipLevel") String? membershipLevel,
            @JsonKey(name: "isLoading") bool isLoading)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MembershipStatusModel() when $default != null:
        return $default(
            _that.type, _that.message, _that.membershipLevel, _that.isLoading);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _MembershipStatusModel extends MembershipStatusModel {
  const _MembershipStatusModel(
      {@JsonKey(name: "type") required this.type,
      @JsonKey(name: "message") required this.message,
      @JsonKey(name: "membershipLevel") this.membershipLevel,
      @JsonKey(name: "isLoading") required this.isLoading})
      : super._();
  factory _MembershipStatusModel.fromJson(Map<String, dynamic> json) =>
      _$MembershipStatusModelFromJson(json);

  @override
  @JsonKey(name: "type")
  final String type;
  @override
  @JsonKey(name: "message")
  final String message;
  @override
  @JsonKey(name: "membershipLevel")
  final String? membershipLevel;
  @override
  @JsonKey(name: "isLoading")
  final bool isLoading;

  /// Create a copy of MembershipStatusModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$MembershipStatusModelCopyWith<_MembershipStatusModel> get copyWith =>
      __$MembershipStatusModelCopyWithImpl<_MembershipStatusModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$MembershipStatusModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _MembershipStatusModel &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.membershipLevel, membershipLevel) ||
                other.membershipLevel == membershipLevel) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, type, message, membershipLevel, isLoading);

  @override
  String toString() {
    return 'MembershipStatusModel(type: $type, message: $message, membershipLevel: $membershipLevel, isLoading: $isLoading)';
  }
}

/// @nodoc
abstract mixin class _$MembershipStatusModelCopyWith<$Res>
    implements $MembershipStatusModelCopyWith<$Res> {
  factory _$MembershipStatusModelCopyWith(_MembershipStatusModel value,
          $Res Function(_MembershipStatusModel) _then) =
      __$MembershipStatusModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "type") String type,
      @JsonKey(name: "message") String message,
      @JsonKey(name: "membershipLevel") String? membershipLevel,
      @JsonKey(name: "isLoading") bool isLoading});
}

/// @nodoc
class __$MembershipStatusModelCopyWithImpl<$Res>
    implements _$MembershipStatusModelCopyWith<$Res> {
  __$MembershipStatusModelCopyWithImpl(this._self, this._then);

  final _MembershipStatusModel _self;
  final $Res Function(_MembershipStatusModel) _then;

  /// Create a copy of MembershipStatusModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? type = null,
    Object? message = null,
    Object? membershipLevel = freezed,
    Object? isLoading = null,
  }) {
    return _then(_MembershipStatusModel(
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      membershipLevel: freezed == membershipLevel
          ? _self.membershipLevel
          : membershipLevel // ignore: cast_nullable_to_non_nullable
              as String?,
      isLoading: null == isLoading
          ? _self.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
