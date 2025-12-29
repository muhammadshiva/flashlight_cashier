// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'report_data_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ReportDataModel {
  @JsonKey(name: 'totalRevenue')
  int get totalRevenue;
  @JsonKey(name: 'totalOrders')
  int get totalOrders;
  @JsonKey(name: 'ordersByStatus')
  Map<String, int> get ordersByStatus;
  @JsonKey(name: 'topCustomers')
  List<TopCustomerModel> get topCustomers;
  @JsonKey(name: 'popularServices')
  List<PopularServiceModel> get popularServices;

  /// Create a copy of ReportDataModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ReportDataModelCopyWith<ReportDataModel> get copyWith =>
      _$ReportDataModelCopyWithImpl<ReportDataModel>(
          this as ReportDataModel, _$identity);

  /// Serializes this ReportDataModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ReportDataModel &&
            (identical(other.totalRevenue, totalRevenue) ||
                other.totalRevenue == totalRevenue) &&
            (identical(other.totalOrders, totalOrders) ||
                other.totalOrders == totalOrders) &&
            const DeepCollectionEquality()
                .equals(other.ordersByStatus, ordersByStatus) &&
            const DeepCollectionEquality()
                .equals(other.topCustomers, topCustomers) &&
            const DeepCollectionEquality()
                .equals(other.popularServices, popularServices));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      totalRevenue,
      totalOrders,
      const DeepCollectionEquality().hash(ordersByStatus),
      const DeepCollectionEquality().hash(topCustomers),
      const DeepCollectionEquality().hash(popularServices));

  @override
  String toString() {
    return 'ReportDataModel(totalRevenue: $totalRevenue, totalOrders: $totalOrders, ordersByStatus: $ordersByStatus, topCustomers: $topCustomers, popularServices: $popularServices)';
  }
}

/// @nodoc
abstract mixin class $ReportDataModelCopyWith<$Res> {
  factory $ReportDataModelCopyWith(
          ReportDataModel value, $Res Function(ReportDataModel) _then) =
      _$ReportDataModelCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'totalRevenue') int totalRevenue,
      @JsonKey(name: 'totalOrders') int totalOrders,
      @JsonKey(name: 'ordersByStatus') Map<String, int> ordersByStatus,
      @JsonKey(name: 'topCustomers') List<TopCustomerModel> topCustomers,
      @JsonKey(name: 'popularServices')
      List<PopularServiceModel> popularServices});
}

/// @nodoc
class _$ReportDataModelCopyWithImpl<$Res>
    implements $ReportDataModelCopyWith<$Res> {
  _$ReportDataModelCopyWithImpl(this._self, this._then);

  final ReportDataModel _self;
  final $Res Function(ReportDataModel) _then;

  /// Create a copy of ReportDataModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalRevenue = null,
    Object? totalOrders = null,
    Object? ordersByStatus = null,
    Object? topCustomers = null,
    Object? popularServices = null,
  }) {
    return _then(_self.copyWith(
      totalRevenue: null == totalRevenue
          ? _self.totalRevenue
          : totalRevenue // ignore: cast_nullable_to_non_nullable
              as int,
      totalOrders: null == totalOrders
          ? _self.totalOrders
          : totalOrders // ignore: cast_nullable_to_non_nullable
              as int,
      ordersByStatus: null == ordersByStatus
          ? _self.ordersByStatus
          : ordersByStatus // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      topCustomers: null == topCustomers
          ? _self.topCustomers
          : topCustomers // ignore: cast_nullable_to_non_nullable
              as List<TopCustomerModel>,
      popularServices: null == popularServices
          ? _self.popularServices
          : popularServices // ignore: cast_nullable_to_non_nullable
              as List<PopularServiceModel>,
    ));
  }
}

/// Adds pattern-matching-related methods to [ReportDataModel].
extension ReportDataModelPatterns on ReportDataModel {
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
    TResult Function(_ReportDataModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ReportDataModel() when $default != null:
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
    TResult Function(_ReportDataModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ReportDataModel():
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
    TResult? Function(_ReportDataModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ReportDataModel() when $default != null:
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
            @JsonKey(name: 'totalRevenue') int totalRevenue,
            @JsonKey(name: 'totalOrders') int totalOrders,
            @JsonKey(name: 'ordersByStatus') Map<String, int> ordersByStatus,
            @JsonKey(name: 'topCustomers') List<TopCustomerModel> topCustomers,
            @JsonKey(name: 'popularServices')
            List<PopularServiceModel> popularServices)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ReportDataModel() when $default != null:
        return $default(_that.totalRevenue, _that.totalOrders,
            _that.ordersByStatus, _that.topCustomers, _that.popularServices);
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
            @JsonKey(name: 'totalRevenue') int totalRevenue,
            @JsonKey(name: 'totalOrders') int totalOrders,
            @JsonKey(name: 'ordersByStatus') Map<String, int> ordersByStatus,
            @JsonKey(name: 'topCustomers') List<TopCustomerModel> topCustomers,
            @JsonKey(name: 'popularServices')
            List<PopularServiceModel> popularServices)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ReportDataModel():
        return $default(_that.totalRevenue, _that.totalOrders,
            _that.ordersByStatus, _that.topCustomers, _that.popularServices);
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
            @JsonKey(name: 'totalRevenue') int totalRevenue,
            @JsonKey(name: 'totalOrders') int totalOrders,
            @JsonKey(name: 'ordersByStatus') Map<String, int> ordersByStatus,
            @JsonKey(name: 'topCustomers') List<TopCustomerModel> topCustomers,
            @JsonKey(name: 'popularServices')
            List<PopularServiceModel> popularServices)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ReportDataModel() when $default != null:
        return $default(_that.totalRevenue, _that.totalOrders,
            _that.ordersByStatus, _that.topCustomers, _that.popularServices);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ReportDataModel extends ReportDataModel {
  const _ReportDataModel(
      {@JsonKey(name: 'totalRevenue') required this.totalRevenue,
      @JsonKey(name: 'totalOrders') required this.totalOrders,
      @JsonKey(name: 'ordersByStatus')
      required final Map<String, int> ordersByStatus,
      @JsonKey(name: 'topCustomers')
      required final List<TopCustomerModel> topCustomers,
      @JsonKey(name: 'popularServices')
      required final List<PopularServiceModel> popularServices})
      : _ordersByStatus = ordersByStatus,
        _topCustomers = topCustomers,
        _popularServices = popularServices,
        super._();
  factory _ReportDataModel.fromJson(Map<String, dynamic> json) =>
      _$ReportDataModelFromJson(json);

  @override
  @JsonKey(name: 'totalRevenue')
  final int totalRevenue;
  @override
  @JsonKey(name: 'totalOrders')
  final int totalOrders;
  final Map<String, int> _ordersByStatus;
  @override
  @JsonKey(name: 'ordersByStatus')
  Map<String, int> get ordersByStatus {
    if (_ordersByStatus is EqualUnmodifiableMapView) return _ordersByStatus;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_ordersByStatus);
  }

  final List<TopCustomerModel> _topCustomers;
  @override
  @JsonKey(name: 'topCustomers')
  List<TopCustomerModel> get topCustomers {
    if (_topCustomers is EqualUnmodifiableListView) return _topCustomers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_topCustomers);
  }

  final List<PopularServiceModel> _popularServices;
  @override
  @JsonKey(name: 'popularServices')
  List<PopularServiceModel> get popularServices {
    if (_popularServices is EqualUnmodifiableListView) return _popularServices;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_popularServices);
  }

  /// Create a copy of ReportDataModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ReportDataModelCopyWith<_ReportDataModel> get copyWith =>
      __$ReportDataModelCopyWithImpl<_ReportDataModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ReportDataModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ReportDataModel &&
            (identical(other.totalRevenue, totalRevenue) ||
                other.totalRevenue == totalRevenue) &&
            (identical(other.totalOrders, totalOrders) ||
                other.totalOrders == totalOrders) &&
            const DeepCollectionEquality()
                .equals(other._ordersByStatus, _ordersByStatus) &&
            const DeepCollectionEquality()
                .equals(other._topCustomers, _topCustomers) &&
            const DeepCollectionEquality()
                .equals(other._popularServices, _popularServices));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      totalRevenue,
      totalOrders,
      const DeepCollectionEquality().hash(_ordersByStatus),
      const DeepCollectionEquality().hash(_topCustomers),
      const DeepCollectionEquality().hash(_popularServices));

  @override
  String toString() {
    return 'ReportDataModel(totalRevenue: $totalRevenue, totalOrders: $totalOrders, ordersByStatus: $ordersByStatus, topCustomers: $topCustomers, popularServices: $popularServices)';
  }
}

/// @nodoc
abstract mixin class _$ReportDataModelCopyWith<$Res>
    implements $ReportDataModelCopyWith<$Res> {
  factory _$ReportDataModelCopyWith(
          _ReportDataModel value, $Res Function(_ReportDataModel) _then) =
      __$ReportDataModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'totalRevenue') int totalRevenue,
      @JsonKey(name: 'totalOrders') int totalOrders,
      @JsonKey(name: 'ordersByStatus') Map<String, int> ordersByStatus,
      @JsonKey(name: 'topCustomers') List<TopCustomerModel> topCustomers,
      @JsonKey(name: 'popularServices')
      List<PopularServiceModel> popularServices});
}

/// @nodoc
class __$ReportDataModelCopyWithImpl<$Res>
    implements _$ReportDataModelCopyWith<$Res> {
  __$ReportDataModelCopyWithImpl(this._self, this._then);

  final _ReportDataModel _self;
  final $Res Function(_ReportDataModel) _then;

  /// Create a copy of ReportDataModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? totalRevenue = null,
    Object? totalOrders = null,
    Object? ordersByStatus = null,
    Object? topCustomers = null,
    Object? popularServices = null,
  }) {
    return _then(_ReportDataModel(
      totalRevenue: null == totalRevenue
          ? _self.totalRevenue
          : totalRevenue // ignore: cast_nullable_to_non_nullable
              as int,
      totalOrders: null == totalOrders
          ? _self.totalOrders
          : totalOrders // ignore: cast_nullable_to_non_nullable
              as int,
      ordersByStatus: null == ordersByStatus
          ? _self._ordersByStatus
          : ordersByStatus // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      topCustomers: null == topCustomers
          ? _self._topCustomers
          : topCustomers // ignore: cast_nullable_to_non_nullable
              as List<TopCustomerModel>,
      popularServices: null == popularServices
          ? _self._popularServices
          : popularServices // ignore: cast_nullable_to_non_nullable
              as List<PopularServiceModel>,
    ));
  }
}

/// @nodoc
mixin _$TopCustomerModel {
  @JsonKey(name: 'id')
  String get id;
  @JsonKey(name: 'name')
  String get name;
  @JsonKey(name: 'totalSpent')
  int get totalSpent;
  @JsonKey(name: 'orderCount')
  int get orderCount;

  /// Create a copy of TopCustomerModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TopCustomerModelCopyWith<TopCustomerModel> get copyWith =>
      _$TopCustomerModelCopyWithImpl<TopCustomerModel>(
          this as TopCustomerModel, _$identity);

  /// Serializes this TopCustomerModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TopCustomerModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.totalSpent, totalSpent) ||
                other.totalSpent == totalSpent) &&
            (identical(other.orderCount, orderCount) ||
                other.orderCount == orderCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, totalSpent, orderCount);

  @override
  String toString() {
    return 'TopCustomerModel(id: $id, name: $name, totalSpent: $totalSpent, orderCount: $orderCount)';
  }
}

/// @nodoc
abstract mixin class $TopCustomerModelCopyWith<$Res> {
  factory $TopCustomerModelCopyWith(
          TopCustomerModel value, $Res Function(TopCustomerModel) _then) =
      _$TopCustomerModelCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'id') String id,
      @JsonKey(name: 'name') String name,
      @JsonKey(name: 'totalSpent') int totalSpent,
      @JsonKey(name: 'orderCount') int orderCount});
}

/// @nodoc
class _$TopCustomerModelCopyWithImpl<$Res>
    implements $TopCustomerModelCopyWith<$Res> {
  _$TopCustomerModelCopyWithImpl(this._self, this._then);

  final TopCustomerModel _self;
  final $Res Function(TopCustomerModel) _then;

  /// Create a copy of TopCustomerModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? totalSpent = null,
    Object? orderCount = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      totalSpent: null == totalSpent
          ? _self.totalSpent
          : totalSpent // ignore: cast_nullable_to_non_nullable
              as int,
      orderCount: null == orderCount
          ? _self.orderCount
          : orderCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// Adds pattern-matching-related methods to [TopCustomerModel].
extension TopCustomerModelPatterns on TopCustomerModel {
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
    TResult Function(_TopCustomerModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _TopCustomerModel() when $default != null:
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
    TResult Function(_TopCustomerModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TopCustomerModel():
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
    TResult? Function(_TopCustomerModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TopCustomerModel() when $default != null:
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
            @JsonKey(name: 'id') String id,
            @JsonKey(name: 'name') String name,
            @JsonKey(name: 'totalSpent') int totalSpent,
            @JsonKey(name: 'orderCount') int orderCount)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _TopCustomerModel() when $default != null:
        return $default(
            _that.id, _that.name, _that.totalSpent, _that.orderCount);
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
            @JsonKey(name: 'id') String id,
            @JsonKey(name: 'name') String name,
            @JsonKey(name: 'totalSpent') int totalSpent,
            @JsonKey(name: 'orderCount') int orderCount)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TopCustomerModel():
        return $default(
            _that.id, _that.name, _that.totalSpent, _that.orderCount);
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
            @JsonKey(name: 'id') String id,
            @JsonKey(name: 'name') String name,
            @JsonKey(name: 'totalSpent') int totalSpent,
            @JsonKey(name: 'orderCount') int orderCount)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TopCustomerModel() when $default != null:
        return $default(
            _that.id, _that.name, _that.totalSpent, _that.orderCount);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _TopCustomerModel extends TopCustomerModel {
  const _TopCustomerModel(
      {@JsonKey(name: 'id') required this.id,
      @JsonKey(name: 'name') required this.name,
      @JsonKey(name: 'totalSpent') required this.totalSpent,
      @JsonKey(name: 'orderCount') required this.orderCount})
      : super._();
  factory _TopCustomerModel.fromJson(Map<String, dynamic> json) =>
      _$TopCustomerModelFromJson(json);

  @override
  @JsonKey(name: 'id')
  final String id;
  @override
  @JsonKey(name: 'name')
  final String name;
  @override
  @JsonKey(name: 'totalSpent')
  final int totalSpent;
  @override
  @JsonKey(name: 'orderCount')
  final int orderCount;

  /// Create a copy of TopCustomerModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TopCustomerModelCopyWith<_TopCustomerModel> get copyWith =>
      __$TopCustomerModelCopyWithImpl<_TopCustomerModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$TopCustomerModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TopCustomerModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.totalSpent, totalSpent) ||
                other.totalSpent == totalSpent) &&
            (identical(other.orderCount, orderCount) ||
                other.orderCount == orderCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, totalSpent, orderCount);

  @override
  String toString() {
    return 'TopCustomerModel(id: $id, name: $name, totalSpent: $totalSpent, orderCount: $orderCount)';
  }
}

/// @nodoc
abstract mixin class _$TopCustomerModelCopyWith<$Res>
    implements $TopCustomerModelCopyWith<$Res> {
  factory _$TopCustomerModelCopyWith(
          _TopCustomerModel value, $Res Function(_TopCustomerModel) _then) =
      __$TopCustomerModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'id') String id,
      @JsonKey(name: 'name') String name,
      @JsonKey(name: 'totalSpent') int totalSpent,
      @JsonKey(name: 'orderCount') int orderCount});
}

/// @nodoc
class __$TopCustomerModelCopyWithImpl<$Res>
    implements _$TopCustomerModelCopyWith<$Res> {
  __$TopCustomerModelCopyWithImpl(this._self, this._then);

  final _TopCustomerModel _self;
  final $Res Function(_TopCustomerModel) _then;

  /// Create a copy of TopCustomerModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? totalSpent = null,
    Object? orderCount = null,
  }) {
    return _then(_TopCustomerModel(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      totalSpent: null == totalSpent
          ? _self.totalSpent
          : totalSpent // ignore: cast_nullable_to_non_nullable
              as int,
      orderCount: null == orderCount
          ? _self.orderCount
          : orderCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
mixin _$PopularServiceModel {
  @JsonKey(name: 'id')
  String get id;
  @JsonKey(name: 'name')
  String get name;
  @JsonKey(name: 'orderCount')
  int get orderCount;
  @JsonKey(name: 'totalRevenue')
  int get totalRevenue;

  /// Create a copy of PopularServiceModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PopularServiceModelCopyWith<PopularServiceModel> get copyWith =>
      _$PopularServiceModelCopyWithImpl<PopularServiceModel>(
          this as PopularServiceModel, _$identity);

  /// Serializes this PopularServiceModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PopularServiceModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.orderCount, orderCount) ||
                other.orderCount == orderCount) &&
            (identical(other.totalRevenue, totalRevenue) ||
                other.totalRevenue == totalRevenue));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, orderCount, totalRevenue);

  @override
  String toString() {
    return 'PopularServiceModel(id: $id, name: $name, orderCount: $orderCount, totalRevenue: $totalRevenue)';
  }
}

/// @nodoc
abstract mixin class $PopularServiceModelCopyWith<$Res> {
  factory $PopularServiceModelCopyWith(
          PopularServiceModel value, $Res Function(PopularServiceModel) _then) =
      _$PopularServiceModelCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'id') String id,
      @JsonKey(name: 'name') String name,
      @JsonKey(name: 'orderCount') int orderCount,
      @JsonKey(name: 'totalRevenue') int totalRevenue});
}

/// @nodoc
class _$PopularServiceModelCopyWithImpl<$Res>
    implements $PopularServiceModelCopyWith<$Res> {
  _$PopularServiceModelCopyWithImpl(this._self, this._then);

  final PopularServiceModel _self;
  final $Res Function(PopularServiceModel) _then;

  /// Create a copy of PopularServiceModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? orderCount = null,
    Object? totalRevenue = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      orderCount: null == orderCount
          ? _self.orderCount
          : orderCount // ignore: cast_nullable_to_non_nullable
              as int,
      totalRevenue: null == totalRevenue
          ? _self.totalRevenue
          : totalRevenue // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// Adds pattern-matching-related methods to [PopularServiceModel].
extension PopularServiceModelPatterns on PopularServiceModel {
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
    TResult Function(_PopularServiceModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PopularServiceModel() when $default != null:
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
    TResult Function(_PopularServiceModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PopularServiceModel():
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
    TResult? Function(_PopularServiceModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PopularServiceModel() when $default != null:
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
            @JsonKey(name: 'id') String id,
            @JsonKey(name: 'name') String name,
            @JsonKey(name: 'orderCount') int orderCount,
            @JsonKey(name: 'totalRevenue') int totalRevenue)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PopularServiceModel() when $default != null:
        return $default(
            _that.id, _that.name, _that.orderCount, _that.totalRevenue);
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
            @JsonKey(name: 'id') String id,
            @JsonKey(name: 'name') String name,
            @JsonKey(name: 'orderCount') int orderCount,
            @JsonKey(name: 'totalRevenue') int totalRevenue)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PopularServiceModel():
        return $default(
            _that.id, _that.name, _that.orderCount, _that.totalRevenue);
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
            @JsonKey(name: 'id') String id,
            @JsonKey(name: 'name') String name,
            @JsonKey(name: 'orderCount') int orderCount,
            @JsonKey(name: 'totalRevenue') int totalRevenue)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PopularServiceModel() when $default != null:
        return $default(
            _that.id, _that.name, _that.orderCount, _that.totalRevenue);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _PopularServiceModel extends PopularServiceModel {
  const _PopularServiceModel(
      {@JsonKey(name: 'id') required this.id,
      @JsonKey(name: 'name') required this.name,
      @JsonKey(name: 'orderCount') required this.orderCount,
      @JsonKey(name: 'totalRevenue') required this.totalRevenue})
      : super._();
  factory _PopularServiceModel.fromJson(Map<String, dynamic> json) =>
      _$PopularServiceModelFromJson(json);

  @override
  @JsonKey(name: 'id')
  final String id;
  @override
  @JsonKey(name: 'name')
  final String name;
  @override
  @JsonKey(name: 'orderCount')
  final int orderCount;
  @override
  @JsonKey(name: 'totalRevenue')
  final int totalRevenue;

  /// Create a copy of PopularServiceModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PopularServiceModelCopyWith<_PopularServiceModel> get copyWith =>
      __$PopularServiceModelCopyWithImpl<_PopularServiceModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$PopularServiceModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PopularServiceModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.orderCount, orderCount) ||
                other.orderCount == orderCount) &&
            (identical(other.totalRevenue, totalRevenue) ||
                other.totalRevenue == totalRevenue));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, orderCount, totalRevenue);

  @override
  String toString() {
    return 'PopularServiceModel(id: $id, name: $name, orderCount: $orderCount, totalRevenue: $totalRevenue)';
  }
}

/// @nodoc
abstract mixin class _$PopularServiceModelCopyWith<$Res>
    implements $PopularServiceModelCopyWith<$Res> {
  factory _$PopularServiceModelCopyWith(_PopularServiceModel value,
          $Res Function(_PopularServiceModel) _then) =
      __$PopularServiceModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'id') String id,
      @JsonKey(name: 'name') String name,
      @JsonKey(name: 'orderCount') int orderCount,
      @JsonKey(name: 'totalRevenue') int totalRevenue});
}

/// @nodoc
class __$PopularServiceModelCopyWithImpl<$Res>
    implements _$PopularServiceModelCopyWith<$Res> {
  __$PopularServiceModelCopyWithImpl(this._self, this._then);

  final _PopularServiceModel _self;
  final $Res Function(_PopularServiceModel) _then;

  /// Create a copy of PopularServiceModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? orderCount = null,
    Object? totalRevenue = null,
  }) {
    return _then(_PopularServiceModel(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      orderCount: null == orderCount
          ? _self.orderCount
          : orderCount // ignore: cast_nullable_to_non_nullable
              as int,
      totalRevenue: null == totalRevenue
          ? _self.totalRevenue
          : totalRevenue // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

// dart format on
