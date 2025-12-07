// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vehicle_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$VehicleModel {
  @JsonKey(name: "id")
  String get id;
  @JsonKey(name: "licensePlate")
  String get licensePlate;
  @JsonKey(name: "vehicleBrand")
  String get vehicleBrand;
  @JsonKey(name: "vehicleColor")
  String get vehicleColor;
  @JsonKey(name: "vehicleCategory")
  String get vehicleCategory;
  @JsonKey(name: "vehicleSpecs")
  String get vehicleSpecs;

  /// Create a copy of VehicleModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $VehicleModelCopyWith<VehicleModel> get copyWith =>
      _$VehicleModelCopyWithImpl<VehicleModel>(
          this as VehicleModel, _$identity);

  /// Serializes this VehicleModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is VehicleModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.licensePlate, licensePlate) ||
                other.licensePlate == licensePlate) &&
            (identical(other.vehicleBrand, vehicleBrand) ||
                other.vehicleBrand == vehicleBrand) &&
            (identical(other.vehicleColor, vehicleColor) ||
                other.vehicleColor == vehicleColor) &&
            (identical(other.vehicleCategory, vehicleCategory) ||
                other.vehicleCategory == vehicleCategory) &&
            (identical(other.vehicleSpecs, vehicleSpecs) ||
                other.vehicleSpecs == vehicleSpecs));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, licensePlate, vehicleBrand,
      vehicleColor, vehicleCategory, vehicleSpecs);

  @override
  String toString() {
    return 'VehicleModel(id: $id, licensePlate: $licensePlate, vehicleBrand: $vehicleBrand, vehicleColor: $vehicleColor, vehicleCategory: $vehicleCategory, vehicleSpecs: $vehicleSpecs)';
  }
}

/// @nodoc
abstract mixin class $VehicleModelCopyWith<$Res> {
  factory $VehicleModelCopyWith(
          VehicleModel value, $Res Function(VehicleModel) _then) =
      _$VehicleModelCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: "id") String id,
      @JsonKey(name: "licensePlate") String licensePlate,
      @JsonKey(name: "vehicleBrand") String vehicleBrand,
      @JsonKey(name: "vehicleColor") String vehicleColor,
      @JsonKey(name: "vehicleCategory") String vehicleCategory,
      @JsonKey(name: "vehicleSpecs") String vehicleSpecs});
}

/// @nodoc
class _$VehicleModelCopyWithImpl<$Res> implements $VehicleModelCopyWith<$Res> {
  _$VehicleModelCopyWithImpl(this._self, this._then);

  final VehicleModel _self;
  final $Res Function(VehicleModel) _then;

  /// Create a copy of VehicleModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? licensePlate = null,
    Object? vehicleBrand = null,
    Object? vehicleColor = null,
    Object? vehicleCategory = null,
    Object? vehicleSpecs = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      licensePlate: null == licensePlate
          ? _self.licensePlate
          : licensePlate // ignore: cast_nullable_to_non_nullable
              as String,
      vehicleBrand: null == vehicleBrand
          ? _self.vehicleBrand
          : vehicleBrand // ignore: cast_nullable_to_non_nullable
              as String,
      vehicleColor: null == vehicleColor
          ? _self.vehicleColor
          : vehicleColor // ignore: cast_nullable_to_non_nullable
              as String,
      vehicleCategory: null == vehicleCategory
          ? _self.vehicleCategory
          : vehicleCategory // ignore: cast_nullable_to_non_nullable
              as String,
      vehicleSpecs: null == vehicleSpecs
          ? _self.vehicleSpecs
          : vehicleSpecs // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [VehicleModel].
extension VehicleModelPatterns on VehicleModel {
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
    TResult Function(_VehicleModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _VehicleModel() when $default != null:
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
    TResult Function(_VehicleModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _VehicleModel():
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
    TResult? Function(_VehicleModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _VehicleModel() when $default != null:
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
            @JsonKey(name: "licensePlate") String licensePlate,
            @JsonKey(name: "vehicleBrand") String vehicleBrand,
            @JsonKey(name: "vehicleColor") String vehicleColor,
            @JsonKey(name: "vehicleCategory") String vehicleCategory,
            @JsonKey(name: "vehicleSpecs") String vehicleSpecs)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _VehicleModel() when $default != null:
        return $default(_that.id, _that.licensePlate, _that.vehicleBrand,
            _that.vehicleColor, _that.vehicleCategory, _that.vehicleSpecs);
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
            @JsonKey(name: "licensePlate") String licensePlate,
            @JsonKey(name: "vehicleBrand") String vehicleBrand,
            @JsonKey(name: "vehicleColor") String vehicleColor,
            @JsonKey(name: "vehicleCategory") String vehicleCategory,
            @JsonKey(name: "vehicleSpecs") String vehicleSpecs)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _VehicleModel():
        return $default(_that.id, _that.licensePlate, _that.vehicleBrand,
            _that.vehicleColor, _that.vehicleCategory, _that.vehicleSpecs);
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
            @JsonKey(name: "licensePlate") String licensePlate,
            @JsonKey(name: "vehicleBrand") String vehicleBrand,
            @JsonKey(name: "vehicleColor") String vehicleColor,
            @JsonKey(name: "vehicleCategory") String vehicleCategory,
            @JsonKey(name: "vehicleSpecs") String vehicleSpecs)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _VehicleModel() when $default != null:
        return $default(_that.id, _that.licensePlate, _that.vehicleBrand,
            _that.vehicleColor, _that.vehicleCategory, _that.vehicleSpecs);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _VehicleModel extends VehicleModel {
  const _VehicleModel(
      {@JsonKey(name: "id") required this.id,
      @JsonKey(name: "licensePlate") required this.licensePlate,
      @JsonKey(name: "vehicleBrand") required this.vehicleBrand,
      @JsonKey(name: "vehicleColor") required this.vehicleColor,
      @JsonKey(name: "vehicleCategory") required this.vehicleCategory,
      @JsonKey(name: "vehicleSpecs") required this.vehicleSpecs})
      : super._();
  factory _VehicleModel.fromJson(Map<String, dynamic> json) =>
      _$VehicleModelFromJson(json);

  @override
  @JsonKey(name: "id")
  final String id;
  @override
  @JsonKey(name: "licensePlate")
  final String licensePlate;
  @override
  @JsonKey(name: "vehicleBrand")
  final String vehicleBrand;
  @override
  @JsonKey(name: "vehicleColor")
  final String vehicleColor;
  @override
  @JsonKey(name: "vehicleCategory")
  final String vehicleCategory;
  @override
  @JsonKey(name: "vehicleSpecs")
  final String vehicleSpecs;

  /// Create a copy of VehicleModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$VehicleModelCopyWith<_VehicleModel> get copyWith =>
      __$VehicleModelCopyWithImpl<_VehicleModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$VehicleModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _VehicleModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.licensePlate, licensePlate) ||
                other.licensePlate == licensePlate) &&
            (identical(other.vehicleBrand, vehicleBrand) ||
                other.vehicleBrand == vehicleBrand) &&
            (identical(other.vehicleColor, vehicleColor) ||
                other.vehicleColor == vehicleColor) &&
            (identical(other.vehicleCategory, vehicleCategory) ||
                other.vehicleCategory == vehicleCategory) &&
            (identical(other.vehicleSpecs, vehicleSpecs) ||
                other.vehicleSpecs == vehicleSpecs));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, licensePlate, vehicleBrand,
      vehicleColor, vehicleCategory, vehicleSpecs);

  @override
  String toString() {
    return 'VehicleModel(id: $id, licensePlate: $licensePlate, vehicleBrand: $vehicleBrand, vehicleColor: $vehicleColor, vehicleCategory: $vehicleCategory, vehicleSpecs: $vehicleSpecs)';
  }
}

/// @nodoc
abstract mixin class _$VehicleModelCopyWith<$Res>
    implements $VehicleModelCopyWith<$Res> {
  factory _$VehicleModelCopyWith(
          _VehicleModel value, $Res Function(_VehicleModel) _then) =
      __$VehicleModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "id") String id,
      @JsonKey(name: "licensePlate") String licensePlate,
      @JsonKey(name: "vehicleBrand") String vehicleBrand,
      @JsonKey(name: "vehicleColor") String vehicleColor,
      @JsonKey(name: "vehicleCategory") String vehicleCategory,
      @JsonKey(name: "vehicleSpecs") String vehicleSpecs});
}

/// @nodoc
class __$VehicleModelCopyWithImpl<$Res>
    implements _$VehicleModelCopyWith<$Res> {
  __$VehicleModelCopyWithImpl(this._self, this._then);

  final _VehicleModel _self;
  final $Res Function(_VehicleModel) _then;

  /// Create a copy of VehicleModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? licensePlate = null,
    Object? vehicleBrand = null,
    Object? vehicleColor = null,
    Object? vehicleCategory = null,
    Object? vehicleSpecs = null,
  }) {
    return _then(_VehicleModel(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      licensePlate: null == licensePlate
          ? _self.licensePlate
          : licensePlate // ignore: cast_nullable_to_non_nullable
              as String,
      vehicleBrand: null == vehicleBrand
          ? _self.vehicleBrand
          : vehicleBrand // ignore: cast_nullable_to_non_nullable
              as String,
      vehicleColor: null == vehicleColor
          ? _self.vehicleColor
          : vehicleColor // ignore: cast_nullable_to_non_nullable
              as String,
      vehicleCategory: null == vehicleCategory
          ? _self.vehicleCategory
          : vehicleCategory // ignore: cast_nullable_to_non_nullable
              as String,
      vehicleSpecs: null == vehicleSpecs
          ? _self.vehicleSpecs
          : vehicleSpecs // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
