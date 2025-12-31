// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'member_vehicle_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MemberVehicleModel {
  @JsonKey(name: "id")
  String get id;
  @JsonKey(name: "membershipId")
  String? get membershipId;
  @JsonKey(name: "name")
  String get name;
  @JsonKey(name: "plateNumber")
  String get plateNumber;
  @JsonKey(name: "specs")
  String? get specs;
  @JsonKey(name: "icon")
  String? get icon;

  /// Create a copy of MemberVehicleModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MemberVehicleModelCopyWith<MemberVehicleModel> get copyWith =>
      _$MemberVehicleModelCopyWithImpl<MemberVehicleModel>(
          this as MemberVehicleModel, _$identity);

  /// Serializes this MemberVehicleModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is MemberVehicleModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.membershipId, membershipId) ||
                other.membershipId == membershipId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.plateNumber, plateNumber) ||
                other.plateNumber == plateNumber) &&
            (identical(other.specs, specs) || other.specs == specs) &&
            (identical(other.icon, icon) || other.icon == icon));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, membershipId, name, plateNumber, specs, icon);

  @override
  String toString() {
    return 'MemberVehicleModel(id: $id, membershipId: $membershipId, name: $name, plateNumber: $plateNumber, specs: $specs, icon: $icon)';
  }
}

/// @nodoc
abstract mixin class $MemberVehicleModelCopyWith<$Res> {
  factory $MemberVehicleModelCopyWith(
          MemberVehicleModel value, $Res Function(MemberVehicleModel) _then) =
      _$MemberVehicleModelCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: "id") String id,
      @JsonKey(name: "membershipId") String? membershipId,
      @JsonKey(name: "name") String name,
      @JsonKey(name: "plateNumber") String plateNumber,
      @JsonKey(name: "specs") String? specs,
      @JsonKey(name: "icon") String? icon});
}

/// @nodoc
class _$MemberVehicleModelCopyWithImpl<$Res>
    implements $MemberVehicleModelCopyWith<$Res> {
  _$MemberVehicleModelCopyWithImpl(this._self, this._then);

  final MemberVehicleModel _self;
  final $Res Function(MemberVehicleModel) _then;

  /// Create a copy of MemberVehicleModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? membershipId = freezed,
    Object? name = null,
    Object? plateNumber = null,
    Object? specs = freezed,
    Object? icon = freezed,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      membershipId: freezed == membershipId
          ? _self.membershipId
          : membershipId // ignore: cast_nullable_to_non_nullable
              as String?,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      plateNumber: null == plateNumber
          ? _self.plateNumber
          : plateNumber // ignore: cast_nullable_to_non_nullable
              as String,
      specs: freezed == specs
          ? _self.specs
          : specs // ignore: cast_nullable_to_non_nullable
              as String?,
      icon: freezed == icon
          ? _self.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [MemberVehicleModel].
extension MemberVehicleModelPatterns on MemberVehicleModel {
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
    TResult Function(_MemberVehicleModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _MemberVehicleModel() when $default != null:
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
    TResult Function(_MemberVehicleModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MemberVehicleModel():
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
    TResult? Function(_MemberVehicleModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MemberVehicleModel() when $default != null:
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
            @JsonKey(name: "membershipId") String? membershipId,
            @JsonKey(name: "name") String name,
            @JsonKey(name: "plateNumber") String plateNumber,
            @JsonKey(name: "specs") String? specs,
            @JsonKey(name: "icon") String? icon)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _MemberVehicleModel() when $default != null:
        return $default(_that.id, _that.membershipId, _that.name,
            _that.plateNumber, _that.specs, _that.icon);
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
            @JsonKey(name: "membershipId") String? membershipId,
            @JsonKey(name: "name") String name,
            @JsonKey(name: "plateNumber") String plateNumber,
            @JsonKey(name: "specs") String? specs,
            @JsonKey(name: "icon") String? icon)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MemberVehicleModel():
        return $default(_that.id, _that.membershipId, _that.name,
            _that.plateNumber, _that.specs, _that.icon);
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
            @JsonKey(name: "membershipId") String? membershipId,
            @JsonKey(name: "name") String name,
            @JsonKey(name: "plateNumber") String plateNumber,
            @JsonKey(name: "specs") String? specs,
            @JsonKey(name: "icon") String? icon)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MemberVehicleModel() when $default != null:
        return $default(_that.id, _that.membershipId, _that.name,
            _that.plateNumber, _that.specs, _that.icon);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _MemberVehicleModel extends MemberVehicleModel {
  const _MemberVehicleModel(
      {@JsonKey(name: "id") required this.id,
      @JsonKey(name: "membershipId") this.membershipId,
      @JsonKey(name: "name") required this.name,
      @JsonKey(name: "plateNumber") required this.plateNumber,
      @JsonKey(name: "specs") this.specs,
      @JsonKey(name: "icon") this.icon})
      : super._();
  factory _MemberVehicleModel.fromJson(Map<String, dynamic> json) =>
      _$MemberVehicleModelFromJson(json);

  @override
  @JsonKey(name: "id")
  final String id;
  @override
  @JsonKey(name: "membershipId")
  final String? membershipId;
  @override
  @JsonKey(name: "name")
  final String name;
  @override
  @JsonKey(name: "plateNumber")
  final String plateNumber;
  @override
  @JsonKey(name: "specs")
  final String? specs;
  @override
  @JsonKey(name: "icon")
  final String? icon;

  /// Create a copy of MemberVehicleModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$MemberVehicleModelCopyWith<_MemberVehicleModel> get copyWith =>
      __$MemberVehicleModelCopyWithImpl<_MemberVehicleModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$MemberVehicleModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _MemberVehicleModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.membershipId, membershipId) ||
                other.membershipId == membershipId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.plateNumber, plateNumber) ||
                other.plateNumber == plateNumber) &&
            (identical(other.specs, specs) || other.specs == specs) &&
            (identical(other.icon, icon) || other.icon == icon));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, membershipId, name, plateNumber, specs, icon);

  @override
  String toString() {
    return 'MemberVehicleModel(id: $id, membershipId: $membershipId, name: $name, plateNumber: $plateNumber, specs: $specs, icon: $icon)';
  }
}

/// @nodoc
abstract mixin class _$MemberVehicleModelCopyWith<$Res>
    implements $MemberVehicleModelCopyWith<$Res> {
  factory _$MemberVehicleModelCopyWith(
          _MemberVehicleModel value, $Res Function(_MemberVehicleModel) _then) =
      __$MemberVehicleModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "id") String id,
      @JsonKey(name: "membershipId") String? membershipId,
      @JsonKey(name: "name") String name,
      @JsonKey(name: "plateNumber") String plateNumber,
      @JsonKey(name: "specs") String? specs,
      @JsonKey(name: "icon") String? icon});
}

/// @nodoc
class __$MemberVehicleModelCopyWithImpl<$Res>
    implements _$MemberVehicleModelCopyWith<$Res> {
  __$MemberVehicleModelCopyWithImpl(this._self, this._then);

  final _MemberVehicleModel _self;
  final $Res Function(_MemberVehicleModel) _then;

  /// Create a copy of MemberVehicleModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? membershipId = freezed,
    Object? name = null,
    Object? plateNumber = null,
    Object? specs = freezed,
    Object? icon = freezed,
  }) {
    return _then(_MemberVehicleModel(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      membershipId: freezed == membershipId
          ? _self.membershipId
          : membershipId // ignore: cast_nullable_to_non_nullable
              as String?,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      plateNumber: null == plateNumber
          ? _self.plateNumber
          : plateNumber // ignore: cast_nullable_to_non_nullable
              as String,
      specs: freezed == specs
          ? _self.specs
          : specs // ignore: cast_nullable_to_non_nullable
              as String?,
      icon: freezed == icon
          ? _self.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
