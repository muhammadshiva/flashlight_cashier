// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stock_adjustment_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$StockAdjustmentModel {
  @JsonKey(name: "product_id")
  String get productId;
  @JsonKey(name: "quantity")
  int get quantity;
  @JsonKey(name: "type")
  String get type;
  @JsonKey(name: "reason")
  String get reason;
  @JsonKey(name: "timestamp")
  DateTime get timestamp;

  /// Create a copy of StockAdjustmentModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $StockAdjustmentModelCopyWith<StockAdjustmentModel> get copyWith =>
      _$StockAdjustmentModelCopyWithImpl<StockAdjustmentModel>(
          this as StockAdjustmentModel, _$identity);

  /// Serializes this StockAdjustmentModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is StockAdjustmentModel &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.reason, reason) || other.reason == reason) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, productId, quantity, type, reason, timestamp);

  @override
  String toString() {
    return 'StockAdjustmentModel(productId: $productId, quantity: $quantity, type: $type, reason: $reason, timestamp: $timestamp)';
  }
}

/// @nodoc
abstract mixin class $StockAdjustmentModelCopyWith<$Res> {
  factory $StockAdjustmentModelCopyWith(StockAdjustmentModel value,
          $Res Function(StockAdjustmentModel) _then) =
      _$StockAdjustmentModelCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: "product_id") String productId,
      @JsonKey(name: "quantity") int quantity,
      @JsonKey(name: "type") String type,
      @JsonKey(name: "reason") String reason,
      @JsonKey(name: "timestamp") DateTime timestamp});
}

/// @nodoc
class _$StockAdjustmentModelCopyWithImpl<$Res>
    implements $StockAdjustmentModelCopyWith<$Res> {
  _$StockAdjustmentModelCopyWithImpl(this._self, this._then);

  final StockAdjustmentModel _self;
  final $Res Function(StockAdjustmentModel) _then;

  /// Create a copy of StockAdjustmentModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productId = null,
    Object? quantity = null,
    Object? type = null,
    Object? reason = null,
    Object? timestamp = null,
  }) {
    return _then(_self.copyWith(
      productId: null == productId
          ? _self.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _self.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      reason: null == reason
          ? _self.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _self.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// Adds pattern-matching-related methods to [StockAdjustmentModel].
extension StockAdjustmentModelPatterns on StockAdjustmentModel {
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
    TResult Function(_StockAdjustmentModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _StockAdjustmentModel() when $default != null:
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
    TResult Function(_StockAdjustmentModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _StockAdjustmentModel():
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
    TResult? Function(_StockAdjustmentModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _StockAdjustmentModel() when $default != null:
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
            @JsonKey(name: "product_id") String productId,
            @JsonKey(name: "quantity") int quantity,
            @JsonKey(name: "type") String type,
            @JsonKey(name: "reason") String reason,
            @JsonKey(name: "timestamp") DateTime timestamp)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _StockAdjustmentModel() when $default != null:
        return $default(_that.productId, _that.quantity, _that.type,
            _that.reason, _that.timestamp);
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
            @JsonKey(name: "product_id") String productId,
            @JsonKey(name: "quantity") int quantity,
            @JsonKey(name: "type") String type,
            @JsonKey(name: "reason") String reason,
            @JsonKey(name: "timestamp") DateTime timestamp)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _StockAdjustmentModel():
        return $default(_that.productId, _that.quantity, _that.type,
            _that.reason, _that.timestamp);
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
            @JsonKey(name: "product_id") String productId,
            @JsonKey(name: "quantity") int quantity,
            @JsonKey(name: "type") String type,
            @JsonKey(name: "reason") String reason,
            @JsonKey(name: "timestamp") DateTime timestamp)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _StockAdjustmentModel() when $default != null:
        return $default(_that.productId, _that.quantity, _that.type,
            _that.reason, _that.timestamp);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _StockAdjustmentModel extends StockAdjustmentModel {
  const _StockAdjustmentModel(
      {@JsonKey(name: "product_id") required this.productId,
      @JsonKey(name: "quantity") required this.quantity,
      @JsonKey(name: "type") required this.type,
      @JsonKey(name: "reason") required this.reason,
      @JsonKey(name: "timestamp") required this.timestamp})
      : super._();
  factory _StockAdjustmentModel.fromJson(Map<String, dynamic> json) =>
      _$StockAdjustmentModelFromJson(json);

  @override
  @JsonKey(name: "product_id")
  final String productId;
  @override
  @JsonKey(name: "quantity")
  final int quantity;
  @override
  @JsonKey(name: "type")
  final String type;
  @override
  @JsonKey(name: "reason")
  final String reason;
  @override
  @JsonKey(name: "timestamp")
  final DateTime timestamp;

  /// Create a copy of StockAdjustmentModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$StockAdjustmentModelCopyWith<_StockAdjustmentModel> get copyWith =>
      __$StockAdjustmentModelCopyWithImpl<_StockAdjustmentModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$StockAdjustmentModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _StockAdjustmentModel &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.reason, reason) || other.reason == reason) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, productId, quantity, type, reason, timestamp);

  @override
  String toString() {
    return 'StockAdjustmentModel(productId: $productId, quantity: $quantity, type: $type, reason: $reason, timestamp: $timestamp)';
  }
}

/// @nodoc
abstract mixin class _$StockAdjustmentModelCopyWith<$Res>
    implements $StockAdjustmentModelCopyWith<$Res> {
  factory _$StockAdjustmentModelCopyWith(_StockAdjustmentModel value,
          $Res Function(_StockAdjustmentModel) _then) =
      __$StockAdjustmentModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "product_id") String productId,
      @JsonKey(name: "quantity") int quantity,
      @JsonKey(name: "type") String type,
      @JsonKey(name: "reason") String reason,
      @JsonKey(name: "timestamp") DateTime timestamp});
}

/// @nodoc
class __$StockAdjustmentModelCopyWithImpl<$Res>
    implements _$StockAdjustmentModelCopyWith<$Res> {
  __$StockAdjustmentModelCopyWithImpl(this._self, this._then);

  final _StockAdjustmentModel _self;
  final $Res Function(_StockAdjustmentModel) _then;

  /// Create a copy of StockAdjustmentModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? productId = null,
    Object? quantity = null,
    Object? type = null,
    Object? reason = null,
    Object? timestamp = null,
  }) {
    return _then(_StockAdjustmentModel(
      productId: null == productId
          ? _self.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _self.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      reason: null == reason
          ? _self.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _self.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

// dart format on
