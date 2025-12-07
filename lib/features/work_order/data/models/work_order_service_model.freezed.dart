// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'work_order_service_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WorkOrderServiceModel {
  @JsonKey(name: "id")
  String get id;
  @JsonKey(name: "workOrderId")
  String get workOrderId;
  @JsonKey(name: "serviceId")
  String get serviceId;
  @JsonKey(name: "quantity")
  int get quantity;
  @JsonKey(name: "priceAtOrder")
  int get priceAtOrder;
  @JsonKey(name: "subtotal")
  int get subtotal;
  @JsonKey(name: "service")
  ServiceModel? get serviceModel;

  /// Create a copy of WorkOrderServiceModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $WorkOrderServiceModelCopyWith<WorkOrderServiceModel> get copyWith =>
      _$WorkOrderServiceModelCopyWithImpl<WorkOrderServiceModel>(
          this as WorkOrderServiceModel, _$identity);

  /// Serializes this WorkOrderServiceModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is WorkOrderServiceModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.workOrderId, workOrderId) ||
                other.workOrderId == workOrderId) &&
            (identical(other.serviceId, serviceId) ||
                other.serviceId == serviceId) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.priceAtOrder, priceAtOrder) ||
                other.priceAtOrder == priceAtOrder) &&
            (identical(other.subtotal, subtotal) ||
                other.subtotal == subtotal) &&
            (identical(other.serviceModel, serviceModel) ||
                other.serviceModel == serviceModel));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, workOrderId, serviceId,
      quantity, priceAtOrder, subtotal, serviceModel);

  @override
  String toString() {
    return 'WorkOrderServiceModel(id: $id, workOrderId: $workOrderId, serviceId: $serviceId, quantity: $quantity, priceAtOrder: $priceAtOrder, subtotal: $subtotal, serviceModel: $serviceModel)';
  }
}

/// @nodoc
abstract mixin class $WorkOrderServiceModelCopyWith<$Res> {
  factory $WorkOrderServiceModelCopyWith(WorkOrderServiceModel value,
          $Res Function(WorkOrderServiceModel) _then) =
      _$WorkOrderServiceModelCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: "id") String id,
      @JsonKey(name: "workOrderId") String workOrderId,
      @JsonKey(name: "serviceId") String serviceId,
      @JsonKey(name: "quantity") int quantity,
      @JsonKey(name: "priceAtOrder") int priceAtOrder,
      @JsonKey(name: "subtotal") int subtotal,
      @JsonKey(name: "service") ServiceModel? serviceModel});

  $ServiceModelCopyWith<$Res>? get serviceModel;
}

/// @nodoc
class _$WorkOrderServiceModelCopyWithImpl<$Res>
    implements $WorkOrderServiceModelCopyWith<$Res> {
  _$WorkOrderServiceModelCopyWithImpl(this._self, this._then);

  final WorkOrderServiceModel _self;
  final $Res Function(WorkOrderServiceModel) _then;

  /// Create a copy of WorkOrderServiceModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? workOrderId = null,
    Object? serviceId = null,
    Object? quantity = null,
    Object? priceAtOrder = null,
    Object? subtotal = null,
    Object? serviceModel = freezed,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      workOrderId: null == workOrderId
          ? _self.workOrderId
          : workOrderId // ignore: cast_nullable_to_non_nullable
              as String,
      serviceId: null == serviceId
          ? _self.serviceId
          : serviceId // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _self.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      priceAtOrder: null == priceAtOrder
          ? _self.priceAtOrder
          : priceAtOrder // ignore: cast_nullable_to_non_nullable
              as int,
      subtotal: null == subtotal
          ? _self.subtotal
          : subtotal // ignore: cast_nullable_to_non_nullable
              as int,
      serviceModel: freezed == serviceModel
          ? _self.serviceModel
          : serviceModel // ignore: cast_nullable_to_non_nullable
              as ServiceModel?,
    ));
  }

  /// Create a copy of WorkOrderServiceModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ServiceModelCopyWith<$Res>? get serviceModel {
    if (_self.serviceModel == null) {
      return null;
    }

    return $ServiceModelCopyWith<$Res>(_self.serviceModel!, (value) {
      return _then(_self.copyWith(serviceModel: value));
    });
  }
}

/// Adds pattern-matching-related methods to [WorkOrderServiceModel].
extension WorkOrderServiceModelPatterns on WorkOrderServiceModel {
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
    TResult Function(_WorkOrderServiceModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _WorkOrderServiceModel() when $default != null:
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
    TResult Function(_WorkOrderServiceModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WorkOrderServiceModel():
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
    TResult? Function(_WorkOrderServiceModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WorkOrderServiceModel() when $default != null:
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
            @JsonKey(name: "workOrderId") String workOrderId,
            @JsonKey(name: "serviceId") String serviceId,
            @JsonKey(name: "quantity") int quantity,
            @JsonKey(name: "priceAtOrder") int priceAtOrder,
            @JsonKey(name: "subtotal") int subtotal,
            @JsonKey(name: "service") ServiceModel? serviceModel)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _WorkOrderServiceModel() when $default != null:
        return $default(
            _that.id,
            _that.workOrderId,
            _that.serviceId,
            _that.quantity,
            _that.priceAtOrder,
            _that.subtotal,
            _that.serviceModel);
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
            @JsonKey(name: "workOrderId") String workOrderId,
            @JsonKey(name: "serviceId") String serviceId,
            @JsonKey(name: "quantity") int quantity,
            @JsonKey(name: "priceAtOrder") int priceAtOrder,
            @JsonKey(name: "subtotal") int subtotal,
            @JsonKey(name: "service") ServiceModel? serviceModel)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WorkOrderServiceModel():
        return $default(
            _that.id,
            _that.workOrderId,
            _that.serviceId,
            _that.quantity,
            _that.priceAtOrder,
            _that.subtotal,
            _that.serviceModel);
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
            @JsonKey(name: "workOrderId") String workOrderId,
            @JsonKey(name: "serviceId") String serviceId,
            @JsonKey(name: "quantity") int quantity,
            @JsonKey(name: "priceAtOrder") int priceAtOrder,
            @JsonKey(name: "subtotal") int subtotal,
            @JsonKey(name: "service") ServiceModel? serviceModel)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WorkOrderServiceModel() when $default != null:
        return $default(
            _that.id,
            _that.workOrderId,
            _that.serviceId,
            _that.quantity,
            _that.priceAtOrder,
            _that.subtotal,
            _that.serviceModel);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _WorkOrderServiceModel extends WorkOrderServiceModel {
  const _WorkOrderServiceModel(
      {@JsonKey(name: "id") required this.id,
      @JsonKey(name: "workOrderId") required this.workOrderId,
      @JsonKey(name: "serviceId") required this.serviceId,
      @JsonKey(name: "quantity") required this.quantity,
      @JsonKey(name: "priceAtOrder") required this.priceAtOrder,
      @JsonKey(name: "subtotal") required this.subtotal,
      @JsonKey(name: "service") this.serviceModel})
      : super._();
  factory _WorkOrderServiceModel.fromJson(Map<String, dynamic> json) =>
      _$WorkOrderServiceModelFromJson(json);

  @override
  @JsonKey(name: "id")
  final String id;
  @override
  @JsonKey(name: "workOrderId")
  final String workOrderId;
  @override
  @JsonKey(name: "serviceId")
  final String serviceId;
  @override
  @JsonKey(name: "quantity")
  final int quantity;
  @override
  @JsonKey(name: "priceAtOrder")
  final int priceAtOrder;
  @override
  @JsonKey(name: "subtotal")
  final int subtotal;
  @override
  @JsonKey(name: "service")
  final ServiceModel? serviceModel;

  /// Create a copy of WorkOrderServiceModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$WorkOrderServiceModelCopyWith<_WorkOrderServiceModel> get copyWith =>
      __$WorkOrderServiceModelCopyWithImpl<_WorkOrderServiceModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$WorkOrderServiceModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _WorkOrderServiceModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.workOrderId, workOrderId) ||
                other.workOrderId == workOrderId) &&
            (identical(other.serviceId, serviceId) ||
                other.serviceId == serviceId) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.priceAtOrder, priceAtOrder) ||
                other.priceAtOrder == priceAtOrder) &&
            (identical(other.subtotal, subtotal) ||
                other.subtotal == subtotal) &&
            (identical(other.serviceModel, serviceModel) ||
                other.serviceModel == serviceModel));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, workOrderId, serviceId,
      quantity, priceAtOrder, subtotal, serviceModel);

  @override
  String toString() {
    return 'WorkOrderServiceModel(id: $id, workOrderId: $workOrderId, serviceId: $serviceId, quantity: $quantity, priceAtOrder: $priceAtOrder, subtotal: $subtotal, serviceModel: $serviceModel)';
  }
}

/// @nodoc
abstract mixin class _$WorkOrderServiceModelCopyWith<$Res>
    implements $WorkOrderServiceModelCopyWith<$Res> {
  factory _$WorkOrderServiceModelCopyWith(_WorkOrderServiceModel value,
          $Res Function(_WorkOrderServiceModel) _then) =
      __$WorkOrderServiceModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "id") String id,
      @JsonKey(name: "workOrderId") String workOrderId,
      @JsonKey(name: "serviceId") String serviceId,
      @JsonKey(name: "quantity") int quantity,
      @JsonKey(name: "priceAtOrder") int priceAtOrder,
      @JsonKey(name: "subtotal") int subtotal,
      @JsonKey(name: "service") ServiceModel? serviceModel});

  @override
  $ServiceModelCopyWith<$Res>? get serviceModel;
}

/// @nodoc
class __$WorkOrderServiceModelCopyWithImpl<$Res>
    implements _$WorkOrderServiceModelCopyWith<$Res> {
  __$WorkOrderServiceModelCopyWithImpl(this._self, this._then);

  final _WorkOrderServiceModel _self;
  final $Res Function(_WorkOrderServiceModel) _then;

  /// Create a copy of WorkOrderServiceModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? workOrderId = null,
    Object? serviceId = null,
    Object? quantity = null,
    Object? priceAtOrder = null,
    Object? subtotal = null,
    Object? serviceModel = freezed,
  }) {
    return _then(_WorkOrderServiceModel(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      workOrderId: null == workOrderId
          ? _self.workOrderId
          : workOrderId // ignore: cast_nullable_to_non_nullable
              as String,
      serviceId: null == serviceId
          ? _self.serviceId
          : serviceId // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _self.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      priceAtOrder: null == priceAtOrder
          ? _self.priceAtOrder
          : priceAtOrder // ignore: cast_nullable_to_non_nullable
              as int,
      subtotal: null == subtotal
          ? _self.subtotal
          : subtotal // ignore: cast_nullable_to_non_nullable
              as int,
      serviceModel: freezed == serviceModel
          ? _self.serviceModel
          : serviceModel // ignore: cast_nullable_to_non_nullable
              as ServiceModel?,
    ));
  }

  /// Create a copy of WorkOrderServiceModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ServiceModelCopyWith<$Res>? get serviceModel {
    if (_self.serviceModel == null) {
      return null;
    }

    return $ServiceModelCopyWith<$Res>(_self.serviceModel!, (value) {
      return _then(_self.copyWith(serviceModel: value));
    });
  }
}

// dart format on
