// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dashboard_stats_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DashboardStatsModel {
  @JsonKey(name: "totalOrders")
  int get totalOrders;
  @JsonKey(name: "totalRevenue")
  int get totalRevenue;
  @JsonKey(name: "pendingOrders")
  int get pendingOrders;
  @JsonKey(name: "inProgressOrders")
  int get inProgressOrders;
  @JsonKey(name: "completedOrders")
  int get completedOrders;
  @JsonKey(name: "cancelledOrders")
  int get cancelledOrders;
  @JsonKey(name: "statusCounts")
  Map<String, int> get statusCounts;

  /// Create a copy of DashboardStatsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DashboardStatsModelCopyWith<DashboardStatsModel> get copyWith =>
      _$DashboardStatsModelCopyWithImpl<DashboardStatsModel>(
          this as DashboardStatsModel, _$identity);

  /// Serializes this DashboardStatsModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DashboardStatsModel &&
            (identical(other.totalOrders, totalOrders) ||
                other.totalOrders == totalOrders) &&
            (identical(other.totalRevenue, totalRevenue) ||
                other.totalRevenue == totalRevenue) &&
            (identical(other.pendingOrders, pendingOrders) ||
                other.pendingOrders == pendingOrders) &&
            (identical(other.inProgressOrders, inProgressOrders) ||
                other.inProgressOrders == inProgressOrders) &&
            (identical(other.completedOrders, completedOrders) ||
                other.completedOrders == completedOrders) &&
            (identical(other.cancelledOrders, cancelledOrders) ||
                other.cancelledOrders == cancelledOrders) &&
            const DeepCollectionEquality()
                .equals(other.statusCounts, statusCounts));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      totalOrders,
      totalRevenue,
      pendingOrders,
      inProgressOrders,
      completedOrders,
      cancelledOrders,
      const DeepCollectionEquality().hash(statusCounts));

  @override
  String toString() {
    return 'DashboardStatsModel(totalOrders: $totalOrders, totalRevenue: $totalRevenue, pendingOrders: $pendingOrders, inProgressOrders: $inProgressOrders, completedOrders: $completedOrders, cancelledOrders: $cancelledOrders, statusCounts: $statusCounts)';
  }
}

/// @nodoc
abstract mixin class $DashboardStatsModelCopyWith<$Res> {
  factory $DashboardStatsModelCopyWith(
          DashboardStatsModel value, $Res Function(DashboardStatsModel) _then) =
      _$DashboardStatsModelCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: "totalOrders") int totalOrders,
      @JsonKey(name: "totalRevenue") int totalRevenue,
      @JsonKey(name: "pendingOrders") int pendingOrders,
      @JsonKey(name: "inProgressOrders") int inProgressOrders,
      @JsonKey(name: "completedOrders") int completedOrders,
      @JsonKey(name: "cancelledOrders") int cancelledOrders,
      @JsonKey(name: "statusCounts") Map<String, int> statusCounts});
}

/// @nodoc
class _$DashboardStatsModelCopyWithImpl<$Res>
    implements $DashboardStatsModelCopyWith<$Res> {
  _$DashboardStatsModelCopyWithImpl(this._self, this._then);

  final DashboardStatsModel _self;
  final $Res Function(DashboardStatsModel) _then;

  /// Create a copy of DashboardStatsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalOrders = null,
    Object? totalRevenue = null,
    Object? pendingOrders = null,
    Object? inProgressOrders = null,
    Object? completedOrders = null,
    Object? cancelledOrders = null,
    Object? statusCounts = null,
  }) {
    return _then(_self.copyWith(
      totalOrders: null == totalOrders
          ? _self.totalOrders
          : totalOrders // ignore: cast_nullable_to_non_nullable
              as int,
      totalRevenue: null == totalRevenue
          ? _self.totalRevenue
          : totalRevenue // ignore: cast_nullable_to_non_nullable
              as int,
      pendingOrders: null == pendingOrders
          ? _self.pendingOrders
          : pendingOrders // ignore: cast_nullable_to_non_nullable
              as int,
      inProgressOrders: null == inProgressOrders
          ? _self.inProgressOrders
          : inProgressOrders // ignore: cast_nullable_to_non_nullable
              as int,
      completedOrders: null == completedOrders
          ? _self.completedOrders
          : completedOrders // ignore: cast_nullable_to_non_nullable
              as int,
      cancelledOrders: null == cancelledOrders
          ? _self.cancelledOrders
          : cancelledOrders // ignore: cast_nullable_to_non_nullable
              as int,
      statusCounts: null == statusCounts
          ? _self.statusCounts
          : statusCounts // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
    ));
  }
}

/// Adds pattern-matching-related methods to [DashboardStatsModel].
extension DashboardStatsModelPatterns on DashboardStatsModel {
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
    TResult Function(_DashboardStatsModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _DashboardStatsModel() when $default != null:
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
    TResult Function(_DashboardStatsModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DashboardStatsModel():
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
    TResult? Function(_DashboardStatsModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DashboardStatsModel() when $default != null:
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
            @JsonKey(name: "totalOrders") int totalOrders,
            @JsonKey(name: "totalRevenue") int totalRevenue,
            @JsonKey(name: "pendingOrders") int pendingOrders,
            @JsonKey(name: "inProgressOrders") int inProgressOrders,
            @JsonKey(name: "completedOrders") int completedOrders,
            @JsonKey(name: "cancelledOrders") int cancelledOrders,
            @JsonKey(name: "statusCounts") Map<String, int> statusCounts)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _DashboardStatsModel() when $default != null:
        return $default(
            _that.totalOrders,
            _that.totalRevenue,
            _that.pendingOrders,
            _that.inProgressOrders,
            _that.completedOrders,
            _that.cancelledOrders,
            _that.statusCounts);
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
            @JsonKey(name: "totalOrders") int totalOrders,
            @JsonKey(name: "totalRevenue") int totalRevenue,
            @JsonKey(name: "pendingOrders") int pendingOrders,
            @JsonKey(name: "inProgressOrders") int inProgressOrders,
            @JsonKey(name: "completedOrders") int completedOrders,
            @JsonKey(name: "cancelledOrders") int cancelledOrders,
            @JsonKey(name: "statusCounts") Map<String, int> statusCounts)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DashboardStatsModel():
        return $default(
            _that.totalOrders,
            _that.totalRevenue,
            _that.pendingOrders,
            _that.inProgressOrders,
            _that.completedOrders,
            _that.cancelledOrders,
            _that.statusCounts);
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
            @JsonKey(name: "totalOrders") int totalOrders,
            @JsonKey(name: "totalRevenue") int totalRevenue,
            @JsonKey(name: "pendingOrders") int pendingOrders,
            @JsonKey(name: "inProgressOrders") int inProgressOrders,
            @JsonKey(name: "completedOrders") int completedOrders,
            @JsonKey(name: "cancelledOrders") int cancelledOrders,
            @JsonKey(name: "statusCounts") Map<String, int> statusCounts)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DashboardStatsModel() when $default != null:
        return $default(
            _that.totalOrders,
            _that.totalRevenue,
            _that.pendingOrders,
            _that.inProgressOrders,
            _that.completedOrders,
            _that.cancelledOrders,
            _that.statusCounts);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _DashboardStatsModel extends DashboardStatsModel {
  const _DashboardStatsModel(
      {@JsonKey(name: "totalOrders") required this.totalOrders,
      @JsonKey(name: "totalRevenue") required this.totalRevenue,
      @JsonKey(name: "pendingOrders") required this.pendingOrders,
      @JsonKey(name: "inProgressOrders") required this.inProgressOrders,
      @JsonKey(name: "completedOrders") required this.completedOrders,
      @JsonKey(name: "cancelledOrders") required this.cancelledOrders,
      @JsonKey(name: "statusCounts")
      required final Map<String, int> statusCounts})
      : _statusCounts = statusCounts,
        super._();
  factory _DashboardStatsModel.fromJson(Map<String, dynamic> json) =>
      _$DashboardStatsModelFromJson(json);

  @override
  @JsonKey(name: "totalOrders")
  final int totalOrders;
  @override
  @JsonKey(name: "totalRevenue")
  final int totalRevenue;
  @override
  @JsonKey(name: "pendingOrders")
  final int pendingOrders;
  @override
  @JsonKey(name: "inProgressOrders")
  final int inProgressOrders;
  @override
  @JsonKey(name: "completedOrders")
  final int completedOrders;
  @override
  @JsonKey(name: "cancelledOrders")
  final int cancelledOrders;
  final Map<String, int> _statusCounts;
  @override
  @JsonKey(name: "statusCounts")
  Map<String, int> get statusCounts {
    if (_statusCounts is EqualUnmodifiableMapView) return _statusCounts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_statusCounts);
  }

  /// Create a copy of DashboardStatsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$DashboardStatsModelCopyWith<_DashboardStatsModel> get copyWith =>
      __$DashboardStatsModelCopyWithImpl<_DashboardStatsModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$DashboardStatsModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _DashboardStatsModel &&
            (identical(other.totalOrders, totalOrders) ||
                other.totalOrders == totalOrders) &&
            (identical(other.totalRevenue, totalRevenue) ||
                other.totalRevenue == totalRevenue) &&
            (identical(other.pendingOrders, pendingOrders) ||
                other.pendingOrders == pendingOrders) &&
            (identical(other.inProgressOrders, inProgressOrders) ||
                other.inProgressOrders == inProgressOrders) &&
            (identical(other.completedOrders, completedOrders) ||
                other.completedOrders == completedOrders) &&
            (identical(other.cancelledOrders, cancelledOrders) ||
                other.cancelledOrders == cancelledOrders) &&
            const DeepCollectionEquality()
                .equals(other._statusCounts, _statusCounts));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      totalOrders,
      totalRevenue,
      pendingOrders,
      inProgressOrders,
      completedOrders,
      cancelledOrders,
      const DeepCollectionEquality().hash(_statusCounts));

  @override
  String toString() {
    return 'DashboardStatsModel(totalOrders: $totalOrders, totalRevenue: $totalRevenue, pendingOrders: $pendingOrders, inProgressOrders: $inProgressOrders, completedOrders: $completedOrders, cancelledOrders: $cancelledOrders, statusCounts: $statusCounts)';
  }
}

/// @nodoc
abstract mixin class _$DashboardStatsModelCopyWith<$Res>
    implements $DashboardStatsModelCopyWith<$Res> {
  factory _$DashboardStatsModelCopyWith(_DashboardStatsModel value,
          $Res Function(_DashboardStatsModel) _then) =
      __$DashboardStatsModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "totalOrders") int totalOrders,
      @JsonKey(name: "totalRevenue") int totalRevenue,
      @JsonKey(name: "pendingOrders") int pendingOrders,
      @JsonKey(name: "inProgressOrders") int inProgressOrders,
      @JsonKey(name: "completedOrders") int completedOrders,
      @JsonKey(name: "cancelledOrders") int cancelledOrders,
      @JsonKey(name: "statusCounts") Map<String, int> statusCounts});
}

/// @nodoc
class __$DashboardStatsModelCopyWithImpl<$Res>
    implements _$DashboardStatsModelCopyWith<$Res> {
  __$DashboardStatsModelCopyWithImpl(this._self, this._then);

  final _DashboardStatsModel _self;
  final $Res Function(_DashboardStatsModel) _then;

  /// Create a copy of DashboardStatsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? totalOrders = null,
    Object? totalRevenue = null,
    Object? pendingOrders = null,
    Object? inProgressOrders = null,
    Object? completedOrders = null,
    Object? cancelledOrders = null,
    Object? statusCounts = null,
  }) {
    return _then(_DashboardStatsModel(
      totalOrders: null == totalOrders
          ? _self.totalOrders
          : totalOrders // ignore: cast_nullable_to_non_nullable
              as int,
      totalRevenue: null == totalRevenue
          ? _self.totalRevenue
          : totalRevenue // ignore: cast_nullable_to_non_nullable
              as int,
      pendingOrders: null == pendingOrders
          ? _self.pendingOrders
          : pendingOrders // ignore: cast_nullable_to_non_nullable
              as int,
      inProgressOrders: null == inProgressOrders
          ? _self.inProgressOrders
          : inProgressOrders // ignore: cast_nullable_to_non_nullable
              as int,
      completedOrders: null == completedOrders
          ? _self.completedOrders
          : completedOrders // ignore: cast_nullable_to_non_nullable
              as int,
      cancelledOrders: null == cancelledOrders
          ? _self.cancelledOrders
          : cancelledOrders // ignore: cast_nullable_to_non_nullable
              as int,
      statusCounts: null == statusCounts
          ? _self._statusCounts
          : statusCounts // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
    ));
  }
}

// dart format on
