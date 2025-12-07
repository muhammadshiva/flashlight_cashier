// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'membership_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MembershipModel {
  @JsonKey(name: "id")
  String get id;
  @JsonKey(name: "customerId")
  String get customerId;
  @JsonKey(name: "membershipType")
  String get membershipType;
  @JsonKey(name: "membershipLevel")
  String get membershipLevel;
  @JsonKey(name: "isActive")
  bool get isActive;

  /// Create a copy of MembershipModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MembershipModelCopyWith<MembershipModel> get copyWith =>
      _$MembershipModelCopyWithImpl<MembershipModel>(
          this as MembershipModel, _$identity);

  /// Serializes this MembershipModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is MembershipModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.customerId, customerId) ||
                other.customerId == customerId) &&
            (identical(other.membershipType, membershipType) ||
                other.membershipType == membershipType) &&
            (identical(other.membershipLevel, membershipLevel) ||
                other.membershipLevel == membershipLevel) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, customerId, membershipType, membershipLevel, isActive);

  @override
  String toString() {
    return 'MembershipModel(id: $id, customerId: $customerId, membershipType: $membershipType, membershipLevel: $membershipLevel, isActive: $isActive)';
  }
}

/// @nodoc
abstract mixin class $MembershipModelCopyWith<$Res> {
  factory $MembershipModelCopyWith(
          MembershipModel value, $Res Function(MembershipModel) _then) =
      _$MembershipModelCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: "id") String id,
      @JsonKey(name: "customerId") String customerId,
      @JsonKey(name: "membershipType") String membershipType,
      @JsonKey(name: "membershipLevel") String membershipLevel,
      @JsonKey(name: "isActive") bool isActive});
}

/// @nodoc
class _$MembershipModelCopyWithImpl<$Res>
    implements $MembershipModelCopyWith<$Res> {
  _$MembershipModelCopyWithImpl(this._self, this._then);

  final MembershipModel _self;
  final $Res Function(MembershipModel) _then;

  /// Create a copy of MembershipModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? customerId = null,
    Object? membershipType = null,
    Object? membershipLevel = null,
    Object? isActive = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      customerId: null == customerId
          ? _self.customerId
          : customerId // ignore: cast_nullable_to_non_nullable
              as String,
      membershipType: null == membershipType
          ? _self.membershipType
          : membershipType // ignore: cast_nullable_to_non_nullable
              as String,
      membershipLevel: null == membershipLevel
          ? _self.membershipLevel
          : membershipLevel // ignore: cast_nullable_to_non_nullable
              as String,
      isActive: null == isActive
          ? _self.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// Adds pattern-matching-related methods to [MembershipModel].
extension MembershipModelPatterns on MembershipModel {
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
    TResult Function(_MembershipModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _MembershipModel() when $default != null:
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
    TResult Function(_MembershipModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MembershipModel():
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
    TResult? Function(_MembershipModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MembershipModel() when $default != null:
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
            @JsonKey(name: "id") String id,
            @JsonKey(name: "customerId") String customerId,
            @JsonKey(name: "membershipType") String membershipType,
            @JsonKey(name: "membershipLevel") String membershipLevel,
            @JsonKey(name: "isActive") bool isActive)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _MembershipModel() when $default != null:
        return $default(_that.id, _that.customerId, _that.membershipType,
            _that.membershipLevel, _that.isActive);
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
            @JsonKey(name: "id") String id,
            @JsonKey(name: "customerId") String customerId,
            @JsonKey(name: "membershipType") String membershipType,
            @JsonKey(name: "membershipLevel") String membershipLevel,
            @JsonKey(name: "isActive") bool isActive)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MembershipModel():
        return $default(_that.id, _that.customerId, _that.membershipType,
            _that.membershipLevel, _that.isActive);
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
            @JsonKey(name: "id") String id,
            @JsonKey(name: "customerId") String customerId,
            @JsonKey(name: "membershipType") String membershipType,
            @JsonKey(name: "membershipLevel") String membershipLevel,
            @JsonKey(name: "isActive") bool isActive)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MembershipModel() when $default != null:
        return $default(_that.id, _that.customerId, _that.membershipType,
            _that.membershipLevel, _that.isActive);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _MembershipModel extends MembershipModel {
  const _MembershipModel(
      {@JsonKey(name: "id") required this.id,
      @JsonKey(name: "customerId") required this.customerId,
      @JsonKey(name: "membershipType") required this.membershipType,
      @JsonKey(name: "membershipLevel") required this.membershipLevel,
      @JsonKey(name: "isActive") required this.isActive})
      : super._();
  factory _MembershipModel.fromJson(Map<String, dynamic> json) =>
      _$MembershipModelFromJson(json);

  @override
  @JsonKey(name: "id")
  final String id;
  @override
  @JsonKey(name: "customerId")
  final String customerId;
  @override
  @JsonKey(name: "membershipType")
  final String membershipType;
  @override
  @JsonKey(name: "membershipLevel")
  final String membershipLevel;
  @override
  @JsonKey(name: "isActive")
  final bool isActive;

  /// Create a copy of MembershipModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$MembershipModelCopyWith<_MembershipModel> get copyWith =>
      __$MembershipModelCopyWithImpl<_MembershipModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$MembershipModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _MembershipModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.customerId, customerId) ||
                other.customerId == customerId) &&
            (identical(other.membershipType, membershipType) ||
                other.membershipType == membershipType) &&
            (identical(other.membershipLevel, membershipLevel) ||
                other.membershipLevel == membershipLevel) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, customerId, membershipType, membershipLevel, isActive);

  @override
  String toString() {
    return 'MembershipModel(id: $id, customerId: $customerId, membershipType: $membershipType, membershipLevel: $membershipLevel, isActive: $isActive)';
  }
}

/// @nodoc
abstract mixin class _$MembershipModelCopyWith<$Res>
    implements $MembershipModelCopyWith<$Res> {
  factory _$MembershipModelCopyWith(
          _MembershipModel value, $Res Function(_MembershipModel) _then) =
      __$MembershipModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "id") String id,
      @JsonKey(name: "customerId") String customerId,
      @JsonKey(name: "membershipType") String membershipType,
      @JsonKey(name: "membershipLevel") String membershipLevel,
      @JsonKey(name: "isActive") bool isActive});
}

/// @nodoc
class __$MembershipModelCopyWithImpl<$Res>
    implements _$MembershipModelCopyWith<$Res> {
  __$MembershipModelCopyWithImpl(this._self, this._then);

  final _MembershipModel _self;
  final $Res Function(_MembershipModel) _then;

  /// Create a copy of MembershipModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? customerId = null,
    Object? membershipType = null,
    Object? membershipLevel = null,
    Object? isActive = null,
  }) {
    return _then(_MembershipModel(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      customerId: null == customerId
          ? _self.customerId
          : customerId // ignore: cast_nullable_to_non_nullable
              as String,
      membershipType: null == membershipType
          ? _self.membershipType
          : membershipType // ignore: cast_nullable_to_non_nullable
              as String,
      membershipLevel: null == membershipLevel
          ? _self.membershipLevel
          : membershipLevel // ignore: cast_nullable_to_non_nullable
              as String,
      isActive: null == isActive
          ? _self.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
