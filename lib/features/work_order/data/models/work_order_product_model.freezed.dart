// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'work_order_product_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WorkOrderProductModel {
  @JsonKey(name: "id")
  String get id;
  @JsonKey(name: "workOrderId")
  String get workOrderId;
  @JsonKey(name: "productId")
  String get productId;
  @JsonKey(name: "quantity")
  int get quantity;
  @JsonKey(name: "priceAtOrder")
  int get priceAtOrder;
  @JsonKey(name: "subtotal")
  int get subtotal;
  @JsonKey(name: "product")
  ProductModel? get productModel;

  /// Create a copy of WorkOrderProductModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $WorkOrderProductModelCopyWith<WorkOrderProductModel> get copyWith =>
      _$WorkOrderProductModelCopyWithImpl<WorkOrderProductModel>(
          this as WorkOrderProductModel, _$identity);

  /// Serializes this WorkOrderProductModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is WorkOrderProductModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.workOrderId, workOrderId) ||
                other.workOrderId == workOrderId) &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.priceAtOrder, priceAtOrder) ||
                other.priceAtOrder == priceAtOrder) &&
            (identical(other.subtotal, subtotal) ||
                other.subtotal == subtotal) &&
            (identical(other.productModel, productModel) ||
                other.productModel == productModel));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, workOrderId, productId,
      quantity, priceAtOrder, subtotal, productModel);

  @override
  String toString() {
    return 'WorkOrderProductModel(id: $id, workOrderId: $workOrderId, productId: $productId, quantity: $quantity, priceAtOrder: $priceAtOrder, subtotal: $subtotal, productModel: $productModel)';
  }
}

/// @nodoc
abstract mixin class $WorkOrderProductModelCopyWith<$Res> {
  factory $WorkOrderProductModelCopyWith(WorkOrderProductModel value,
          $Res Function(WorkOrderProductModel) _then) =
      _$WorkOrderProductModelCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: "id") String id,
      @JsonKey(name: "workOrderId") String workOrderId,
      @JsonKey(name: "productId") String productId,
      @JsonKey(name: "quantity") int quantity,
      @JsonKey(name: "priceAtOrder") int priceAtOrder,
      @JsonKey(name: "subtotal") int subtotal,
      @JsonKey(name: "product") ProductModel? productModel});

  $ProductModelCopyWith<$Res>? get productModel;
}

/// @nodoc
class _$WorkOrderProductModelCopyWithImpl<$Res>
    implements $WorkOrderProductModelCopyWith<$Res> {
  _$WorkOrderProductModelCopyWithImpl(this._self, this._then);

  final WorkOrderProductModel _self;
  final $Res Function(WorkOrderProductModel) _then;

  /// Create a copy of WorkOrderProductModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? workOrderId = null,
    Object? productId = null,
    Object? quantity = null,
    Object? priceAtOrder = null,
    Object? subtotal = null,
    Object? productModel = freezed,
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
      productId: null == productId
          ? _self.productId
          : productId // ignore: cast_nullable_to_non_nullable
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
      productModel: freezed == productModel
          ? _self.productModel
          : productModel // ignore: cast_nullable_to_non_nullable
              as ProductModel?,
    ));
  }

  /// Create a copy of WorkOrderProductModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ProductModelCopyWith<$Res>? get productModel {
    if (_self.productModel == null) {
      return null;
    }

    return $ProductModelCopyWith<$Res>(_self.productModel!, (value) {
      return _then(_self.copyWith(productModel: value));
    });
  }
}

/// Adds pattern-matching-related methods to [WorkOrderProductModel].
extension WorkOrderProductModelPatterns on WorkOrderProductModel {
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
    TResult Function(_WorkOrderProductModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _WorkOrderProductModel() when $default != null:
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
    TResult Function(_WorkOrderProductModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WorkOrderProductModel():
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
    TResult? Function(_WorkOrderProductModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WorkOrderProductModel() when $default != null:
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
            @JsonKey(name: "productId") String productId,
            @JsonKey(name: "quantity") int quantity,
            @JsonKey(name: "priceAtOrder") int priceAtOrder,
            @JsonKey(name: "subtotal") int subtotal,
            @JsonKey(name: "product") ProductModel? productModel)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _WorkOrderProductModel() when $default != null:
        return $default(
            _that.id,
            _that.workOrderId,
            _that.productId,
            _that.quantity,
            _that.priceAtOrder,
            _that.subtotal,
            _that.productModel);
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
            @JsonKey(name: "productId") String productId,
            @JsonKey(name: "quantity") int quantity,
            @JsonKey(name: "priceAtOrder") int priceAtOrder,
            @JsonKey(name: "subtotal") int subtotal,
            @JsonKey(name: "product") ProductModel? productModel)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WorkOrderProductModel():
        return $default(
            _that.id,
            _that.workOrderId,
            _that.productId,
            _that.quantity,
            _that.priceAtOrder,
            _that.subtotal,
            _that.productModel);
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
            @JsonKey(name: "productId") String productId,
            @JsonKey(name: "quantity") int quantity,
            @JsonKey(name: "priceAtOrder") int priceAtOrder,
            @JsonKey(name: "subtotal") int subtotal,
            @JsonKey(name: "product") ProductModel? productModel)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WorkOrderProductModel() when $default != null:
        return $default(
            _that.id,
            _that.workOrderId,
            _that.productId,
            _that.quantity,
            _that.priceAtOrder,
            _that.subtotal,
            _that.productModel);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _WorkOrderProductModel extends WorkOrderProductModel {
  const _WorkOrderProductModel(
      {@JsonKey(name: "id") required this.id,
      @JsonKey(name: "workOrderId") required this.workOrderId,
      @JsonKey(name: "productId") required this.productId,
      @JsonKey(name: "quantity") required this.quantity,
      @JsonKey(name: "priceAtOrder") required this.priceAtOrder,
      @JsonKey(name: "subtotal") required this.subtotal,
      @JsonKey(name: "product") this.productModel})
      : super._();
  factory _WorkOrderProductModel.fromJson(Map<String, dynamic> json) =>
      _$WorkOrderProductModelFromJson(json);

  @override
  @JsonKey(name: "id")
  final String id;
  @override
  @JsonKey(name: "workOrderId")
  final String workOrderId;
  @override
  @JsonKey(name: "productId")
  final String productId;
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
  @JsonKey(name: "product")
  final ProductModel? productModel;

  /// Create a copy of WorkOrderProductModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$WorkOrderProductModelCopyWith<_WorkOrderProductModel> get copyWith =>
      __$WorkOrderProductModelCopyWithImpl<_WorkOrderProductModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$WorkOrderProductModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _WorkOrderProductModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.workOrderId, workOrderId) ||
                other.workOrderId == workOrderId) &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.priceAtOrder, priceAtOrder) ||
                other.priceAtOrder == priceAtOrder) &&
            (identical(other.subtotal, subtotal) ||
                other.subtotal == subtotal) &&
            (identical(other.productModel, productModel) ||
                other.productModel == productModel));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, workOrderId, productId,
      quantity, priceAtOrder, subtotal, productModel);

  @override
  String toString() {
    return 'WorkOrderProductModel(id: $id, workOrderId: $workOrderId, productId: $productId, quantity: $quantity, priceAtOrder: $priceAtOrder, subtotal: $subtotal, productModel: $productModel)';
  }
}

/// @nodoc
abstract mixin class _$WorkOrderProductModelCopyWith<$Res>
    implements $WorkOrderProductModelCopyWith<$Res> {
  factory _$WorkOrderProductModelCopyWith(_WorkOrderProductModel value,
          $Res Function(_WorkOrderProductModel) _then) =
      __$WorkOrderProductModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "id") String id,
      @JsonKey(name: "workOrderId") String workOrderId,
      @JsonKey(name: "productId") String productId,
      @JsonKey(name: "quantity") int quantity,
      @JsonKey(name: "priceAtOrder") int priceAtOrder,
      @JsonKey(name: "subtotal") int subtotal,
      @JsonKey(name: "product") ProductModel? productModel});

  @override
  $ProductModelCopyWith<$Res>? get productModel;
}

/// @nodoc
class __$WorkOrderProductModelCopyWithImpl<$Res>
    implements _$WorkOrderProductModelCopyWith<$Res> {
  __$WorkOrderProductModelCopyWithImpl(this._self, this._then);

  final _WorkOrderProductModel _self;
  final $Res Function(_WorkOrderProductModel) _then;

  /// Create a copy of WorkOrderProductModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? workOrderId = null,
    Object? productId = null,
    Object? quantity = null,
    Object? priceAtOrder = null,
    Object? subtotal = null,
    Object? productModel = freezed,
  }) {
    return _then(_WorkOrderProductModel(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      workOrderId: null == workOrderId
          ? _self.workOrderId
          : workOrderId // ignore: cast_nullable_to_non_nullable
              as String,
      productId: null == productId
          ? _self.productId
          : productId // ignore: cast_nullable_to_non_nullable
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
      productModel: freezed == productModel
          ? _self.productModel
          : productModel // ignore: cast_nullable_to_non_nullable
              as ProductModel?,
    ));
  }

  /// Create a copy of WorkOrderProductModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ProductModelCopyWith<$Res>? get productModel {
    if (_self.productModel == null) {
      return null;
    }

    return $ProductModelCopyWith<$Res>(_self.productModel!, (value) {
      return _then(_self.copyWith(productModel: value));
    });
  }
}

// dart format on
