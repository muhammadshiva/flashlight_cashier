// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'work_order_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WorkOrderModel {
  @JsonKey(name: "id")
  String get id;
  @JsonKey(name: "workOrderCode")
  String get workOrderCode;
  @JsonKey(name: "customerId")
  String get customerId;
  @JsonKey(name: "vehicleDataId")
  String get vehicleDataId;
  @JsonKey(name: "queueNumber")
  String get queueNumber;
  @JsonKey(name: "estimatedTime")
  String get estimatedTime;
  @JsonKey(name: "status")
  String get status;
  @JsonKey(name: "paymentStatus")
  String? get paymentStatus;
  @JsonKey(name: "paymentMethod")
  String? get paymentMethod;
  @JsonKey(name: "paidAmount")
  int get paidAmount;
  @JsonKey(name: "totalPrice")
  int get totalPrice;
  @JsonKey(name: "services")
  List<WorkOrderServiceModel> get serviceModels;
  @JsonKey(name: "products")
  List<WorkOrderProductModel> get productModels;
  @JsonKey(name: "createdAt")
  DateTime? get createdAt;
  @JsonKey(name: "updatedAt")
  DateTime? get updatedAt;
  @JsonKey(name: "completedAt")
  DateTime? get completedAt;

  /// Create a copy of WorkOrderModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $WorkOrderModelCopyWith<WorkOrderModel> get copyWith =>
      _$WorkOrderModelCopyWithImpl<WorkOrderModel>(
          this as WorkOrderModel, _$identity);

  /// Serializes this WorkOrderModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is WorkOrderModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.workOrderCode, workOrderCode) ||
                other.workOrderCode == workOrderCode) &&
            (identical(other.customerId, customerId) ||
                other.customerId == customerId) &&
            (identical(other.vehicleDataId, vehicleDataId) ||
                other.vehicleDataId == vehicleDataId) &&
            (identical(other.queueNumber, queueNumber) ||
                other.queueNumber == queueNumber) &&
            (identical(other.estimatedTime, estimatedTime) ||
                other.estimatedTime == estimatedTime) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.paymentStatus, paymentStatus) ||
                other.paymentStatus == paymentStatus) &&
            (identical(other.paymentMethod, paymentMethod) ||
                other.paymentMethod == paymentMethod) &&
            (identical(other.paidAmount, paidAmount) ||
                other.paidAmount == paidAmount) &&
            (identical(other.totalPrice, totalPrice) ||
                other.totalPrice == totalPrice) &&
            const DeepCollectionEquality()
                .equals(other.serviceModels, serviceModels) &&
            const DeepCollectionEquality()
                .equals(other.productModels, productModels) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      workOrderCode,
      customerId,
      vehicleDataId,
      queueNumber,
      estimatedTime,
      status,
      paymentStatus,
      paymentMethod,
      paidAmount,
      totalPrice,
      const DeepCollectionEquality().hash(serviceModels),
      const DeepCollectionEquality().hash(productModels),
      createdAt,
      updatedAt,
      completedAt);

  @override
  String toString() {
    return 'WorkOrderModel(id: $id, workOrderCode: $workOrderCode, customerId: $customerId, vehicleDataId: $vehicleDataId, queueNumber: $queueNumber, estimatedTime: $estimatedTime, status: $status, paymentStatus: $paymentStatus, paymentMethod: $paymentMethod, paidAmount: $paidAmount, totalPrice: $totalPrice, serviceModels: $serviceModels, productModels: $productModels, createdAt: $createdAt, updatedAt: $updatedAt, completedAt: $completedAt)';
  }
}

/// @nodoc
abstract mixin class $WorkOrderModelCopyWith<$Res> {
  factory $WorkOrderModelCopyWith(
          WorkOrderModel value, $Res Function(WorkOrderModel) _then) =
      _$WorkOrderModelCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: "id") String id,
      @JsonKey(name: "workOrderCode") String workOrderCode,
      @JsonKey(name: "customerId") String customerId,
      @JsonKey(name: "vehicleDataId") String vehicleDataId,
      @JsonKey(name: "queueNumber") String queueNumber,
      @JsonKey(name: "estimatedTime") String estimatedTime,
      @JsonKey(name: "status") String status,
      @JsonKey(name: "paymentStatus") String? paymentStatus,
      @JsonKey(name: "paymentMethod") String? paymentMethod,
      @JsonKey(name: "paidAmount") int paidAmount,
      @JsonKey(name: "totalPrice") int totalPrice,
      @JsonKey(name: "services") List<WorkOrderServiceModel> serviceModels,
      @JsonKey(name: "products") List<WorkOrderProductModel> productModels,
      @JsonKey(name: "createdAt") DateTime? createdAt,
      @JsonKey(name: "updatedAt") DateTime? updatedAt,
      @JsonKey(name: "completedAt") DateTime? completedAt});
}

/// @nodoc
class _$WorkOrderModelCopyWithImpl<$Res>
    implements $WorkOrderModelCopyWith<$Res> {
  _$WorkOrderModelCopyWithImpl(this._self, this._then);

  final WorkOrderModel _self;
  final $Res Function(WorkOrderModel) _then;

  /// Create a copy of WorkOrderModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? workOrderCode = null,
    Object? customerId = null,
    Object? vehicleDataId = null,
    Object? queueNumber = null,
    Object? estimatedTime = null,
    Object? status = null,
    Object? paymentStatus = freezed,
    Object? paymentMethod = freezed,
    Object? paidAmount = null,
    Object? totalPrice = null,
    Object? serviceModels = null,
    Object? productModels = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? completedAt = freezed,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      workOrderCode: null == workOrderCode
          ? _self.workOrderCode
          : workOrderCode // ignore: cast_nullable_to_non_nullable
              as String,
      customerId: null == customerId
          ? _self.customerId
          : customerId // ignore: cast_nullable_to_non_nullable
              as String,
      vehicleDataId: null == vehicleDataId
          ? _self.vehicleDataId
          : vehicleDataId // ignore: cast_nullable_to_non_nullable
              as String,
      queueNumber: null == queueNumber
          ? _self.queueNumber
          : queueNumber // ignore: cast_nullable_to_non_nullable
              as String,
      estimatedTime: null == estimatedTime
          ? _self.estimatedTime
          : estimatedTime // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      paymentStatus: freezed == paymentStatus
          ? _self.paymentStatus
          : paymentStatus // ignore: cast_nullable_to_non_nullable
              as String?,
      paymentMethod: freezed == paymentMethod
          ? _self.paymentMethod
          : paymentMethod // ignore: cast_nullable_to_non_nullable
              as String?,
      paidAmount: null == paidAmount
          ? _self.paidAmount
          : paidAmount // ignore: cast_nullable_to_non_nullable
              as int,
      totalPrice: null == totalPrice
          ? _self.totalPrice
          : totalPrice // ignore: cast_nullable_to_non_nullable
              as int,
      serviceModels: null == serviceModels
          ? _self.serviceModels
          : serviceModels // ignore: cast_nullable_to_non_nullable
              as List<WorkOrderServiceModel>,
      productModels: null == productModels
          ? _self.productModels
          : productModels // ignore: cast_nullable_to_non_nullable
              as List<WorkOrderProductModel>,
      createdAt: freezed == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      completedAt: freezed == completedAt
          ? _self.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// Adds pattern-matching-related methods to [WorkOrderModel].
extension WorkOrderModelPatterns on WorkOrderModel {
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
    TResult Function(_WorkOrderModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _WorkOrderModel() when $default != null:
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
    TResult Function(_WorkOrderModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WorkOrderModel():
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
    TResult? Function(_WorkOrderModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WorkOrderModel() when $default != null:
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
            @JsonKey(name: "workOrderCode") String workOrderCode,
            @JsonKey(name: "customerId") String customerId,
            @JsonKey(name: "vehicleDataId") String vehicleDataId,
            @JsonKey(name: "queueNumber") String queueNumber,
            @JsonKey(name: "estimatedTime") String estimatedTime,
            @JsonKey(name: "status") String status,
            @JsonKey(name: "paymentStatus") String? paymentStatus,
            @JsonKey(name: "paymentMethod") String? paymentMethod,
            @JsonKey(name: "paidAmount") int paidAmount,
            @JsonKey(name: "totalPrice") int totalPrice,
            @JsonKey(name: "services")
            List<WorkOrderServiceModel> serviceModels,
            @JsonKey(name: "products")
            List<WorkOrderProductModel> productModels,
            @JsonKey(name: "createdAt") DateTime? createdAt,
            @JsonKey(name: "updatedAt") DateTime? updatedAt,
            @JsonKey(name: "completedAt") DateTime? completedAt)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _WorkOrderModel() when $default != null:
        return $default(
            _that.id,
            _that.workOrderCode,
            _that.customerId,
            _that.vehicleDataId,
            _that.queueNumber,
            _that.estimatedTime,
            _that.status,
            _that.paymentStatus,
            _that.paymentMethod,
            _that.paidAmount,
            _that.totalPrice,
            _that.serviceModels,
            _that.productModels,
            _that.createdAt,
            _that.updatedAt,
            _that.completedAt);
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
            @JsonKey(name: "workOrderCode") String workOrderCode,
            @JsonKey(name: "customerId") String customerId,
            @JsonKey(name: "vehicleDataId") String vehicleDataId,
            @JsonKey(name: "queueNumber") String queueNumber,
            @JsonKey(name: "estimatedTime") String estimatedTime,
            @JsonKey(name: "status") String status,
            @JsonKey(name: "paymentStatus") String? paymentStatus,
            @JsonKey(name: "paymentMethod") String? paymentMethod,
            @JsonKey(name: "paidAmount") int paidAmount,
            @JsonKey(name: "totalPrice") int totalPrice,
            @JsonKey(name: "services")
            List<WorkOrderServiceModel> serviceModels,
            @JsonKey(name: "products")
            List<WorkOrderProductModel> productModels,
            @JsonKey(name: "createdAt") DateTime? createdAt,
            @JsonKey(name: "updatedAt") DateTime? updatedAt,
            @JsonKey(name: "completedAt") DateTime? completedAt)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WorkOrderModel():
        return $default(
            _that.id,
            _that.workOrderCode,
            _that.customerId,
            _that.vehicleDataId,
            _that.queueNumber,
            _that.estimatedTime,
            _that.status,
            _that.paymentStatus,
            _that.paymentMethod,
            _that.paidAmount,
            _that.totalPrice,
            _that.serviceModels,
            _that.productModels,
            _that.createdAt,
            _that.updatedAt,
            _that.completedAt);
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
            @JsonKey(name: "workOrderCode") String workOrderCode,
            @JsonKey(name: "customerId") String customerId,
            @JsonKey(name: "vehicleDataId") String vehicleDataId,
            @JsonKey(name: "queueNumber") String queueNumber,
            @JsonKey(name: "estimatedTime") String estimatedTime,
            @JsonKey(name: "status") String status,
            @JsonKey(name: "paymentStatus") String? paymentStatus,
            @JsonKey(name: "paymentMethod") String? paymentMethod,
            @JsonKey(name: "paidAmount") int paidAmount,
            @JsonKey(name: "totalPrice") int totalPrice,
            @JsonKey(name: "services")
            List<WorkOrderServiceModel> serviceModels,
            @JsonKey(name: "products")
            List<WorkOrderProductModel> productModels,
            @JsonKey(name: "createdAt") DateTime? createdAt,
            @JsonKey(name: "updatedAt") DateTime? updatedAt,
            @JsonKey(name: "completedAt") DateTime? completedAt)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WorkOrderModel() when $default != null:
        return $default(
            _that.id,
            _that.workOrderCode,
            _that.customerId,
            _that.vehicleDataId,
            _that.queueNumber,
            _that.estimatedTime,
            _that.status,
            _that.paymentStatus,
            _that.paymentMethod,
            _that.paidAmount,
            _that.totalPrice,
            _that.serviceModels,
            _that.productModels,
            _that.createdAt,
            _that.updatedAt,
            _that.completedAt);
      case _:
        return null;
    }
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _WorkOrderModel extends WorkOrderModel {
  const _WorkOrderModel(
      {@JsonKey(name: "id") required this.id,
      @JsonKey(name: "workOrderCode") required this.workOrderCode,
      @JsonKey(name: "customerId") required this.customerId,
      @JsonKey(name: "vehicleDataId") required this.vehicleDataId,
      @JsonKey(name: "queueNumber") required this.queueNumber,
      @JsonKey(name: "estimatedTime") required this.estimatedTime,
      @JsonKey(name: "status") required this.status,
      @JsonKey(name: "paymentStatus") this.paymentStatus,
      @JsonKey(name: "paymentMethod") this.paymentMethod,
      @JsonKey(name: "paidAmount") this.paidAmount = 0,
      @JsonKey(name: "totalPrice") required this.totalPrice,
      @JsonKey(name: "services")
      final List<WorkOrderServiceModel> serviceModels = const [],
      @JsonKey(name: "products")
      final List<WorkOrderProductModel> productModels = const [],
      @JsonKey(name: "createdAt") this.createdAt,
      @JsonKey(name: "updatedAt") this.updatedAt,
      @JsonKey(name: "completedAt") this.completedAt})
      : _serviceModels = serviceModels,
        _productModels = productModels,
        super._();
  factory _WorkOrderModel.fromJson(Map<String, dynamic> json) =>
      _$WorkOrderModelFromJson(json);

  @override
  @JsonKey(name: "id")
  final String id;
  @override
  @JsonKey(name: "workOrderCode")
  final String workOrderCode;
  @override
  @JsonKey(name: "customerId")
  final String customerId;
  @override
  @JsonKey(name: "vehicleDataId")
  final String vehicleDataId;
  @override
  @JsonKey(name: "queueNumber")
  final String queueNumber;
  @override
  @JsonKey(name: "estimatedTime")
  final String estimatedTime;
  @override
  @JsonKey(name: "status")
  final String status;
  @override
  @JsonKey(name: "paymentStatus")
  final String? paymentStatus;
  @override
  @JsonKey(name: "paymentMethod")
  final String? paymentMethod;
  @override
  @JsonKey(name: "paidAmount")
  final int paidAmount;
  @override
  @JsonKey(name: "totalPrice")
  final int totalPrice;
  final List<WorkOrderServiceModel> _serviceModels;
  @override
  @JsonKey(name: "services")
  List<WorkOrderServiceModel> get serviceModels {
    if (_serviceModels is EqualUnmodifiableListView) return _serviceModels;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_serviceModels);
  }

  final List<WorkOrderProductModel> _productModels;
  @override
  @JsonKey(name: "products")
  List<WorkOrderProductModel> get productModels {
    if (_productModels is EqualUnmodifiableListView) return _productModels;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_productModels);
  }

  @override
  @JsonKey(name: "createdAt")
  final DateTime? createdAt;
  @override
  @JsonKey(name: "updatedAt")
  final DateTime? updatedAt;
  @override
  @JsonKey(name: "completedAt")
  final DateTime? completedAt;

  /// Create a copy of WorkOrderModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$WorkOrderModelCopyWith<_WorkOrderModel> get copyWith =>
      __$WorkOrderModelCopyWithImpl<_WorkOrderModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$WorkOrderModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _WorkOrderModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.workOrderCode, workOrderCode) ||
                other.workOrderCode == workOrderCode) &&
            (identical(other.customerId, customerId) ||
                other.customerId == customerId) &&
            (identical(other.vehicleDataId, vehicleDataId) ||
                other.vehicleDataId == vehicleDataId) &&
            (identical(other.queueNumber, queueNumber) ||
                other.queueNumber == queueNumber) &&
            (identical(other.estimatedTime, estimatedTime) ||
                other.estimatedTime == estimatedTime) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.paymentStatus, paymentStatus) ||
                other.paymentStatus == paymentStatus) &&
            (identical(other.paymentMethod, paymentMethod) ||
                other.paymentMethod == paymentMethod) &&
            (identical(other.paidAmount, paidAmount) ||
                other.paidAmount == paidAmount) &&
            (identical(other.totalPrice, totalPrice) ||
                other.totalPrice == totalPrice) &&
            const DeepCollectionEquality()
                .equals(other._serviceModels, _serviceModels) &&
            const DeepCollectionEquality()
                .equals(other._productModels, _productModels) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      workOrderCode,
      customerId,
      vehicleDataId,
      queueNumber,
      estimatedTime,
      status,
      paymentStatus,
      paymentMethod,
      paidAmount,
      totalPrice,
      const DeepCollectionEquality().hash(_serviceModels),
      const DeepCollectionEquality().hash(_productModels),
      createdAt,
      updatedAt,
      completedAt);

  @override
  String toString() {
    return 'WorkOrderModel(id: $id, workOrderCode: $workOrderCode, customerId: $customerId, vehicleDataId: $vehicleDataId, queueNumber: $queueNumber, estimatedTime: $estimatedTime, status: $status, paymentStatus: $paymentStatus, paymentMethod: $paymentMethod, paidAmount: $paidAmount, totalPrice: $totalPrice, serviceModels: $serviceModels, productModels: $productModels, createdAt: $createdAt, updatedAt: $updatedAt, completedAt: $completedAt)';
  }
}

/// @nodoc
abstract mixin class _$WorkOrderModelCopyWith<$Res>
    implements $WorkOrderModelCopyWith<$Res> {
  factory _$WorkOrderModelCopyWith(
          _WorkOrderModel value, $Res Function(_WorkOrderModel) _then) =
      __$WorkOrderModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "id") String id,
      @JsonKey(name: "workOrderCode") String workOrderCode,
      @JsonKey(name: "customerId") String customerId,
      @JsonKey(name: "vehicleDataId") String vehicleDataId,
      @JsonKey(name: "queueNumber") String queueNumber,
      @JsonKey(name: "estimatedTime") String estimatedTime,
      @JsonKey(name: "status") String status,
      @JsonKey(name: "paymentStatus") String? paymentStatus,
      @JsonKey(name: "paymentMethod") String? paymentMethod,
      @JsonKey(name: "paidAmount") int paidAmount,
      @JsonKey(name: "totalPrice") int totalPrice,
      @JsonKey(name: "services") List<WorkOrderServiceModel> serviceModels,
      @JsonKey(name: "products") List<WorkOrderProductModel> productModels,
      @JsonKey(name: "createdAt") DateTime? createdAt,
      @JsonKey(name: "updatedAt") DateTime? updatedAt,
      @JsonKey(name: "completedAt") DateTime? completedAt});
}

/// @nodoc
class __$WorkOrderModelCopyWithImpl<$Res>
    implements _$WorkOrderModelCopyWith<$Res> {
  __$WorkOrderModelCopyWithImpl(this._self, this._then);

  final _WorkOrderModel _self;
  final $Res Function(_WorkOrderModel) _then;

  /// Create a copy of WorkOrderModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? workOrderCode = null,
    Object? customerId = null,
    Object? vehicleDataId = null,
    Object? queueNumber = null,
    Object? estimatedTime = null,
    Object? status = null,
    Object? paymentStatus = freezed,
    Object? paymentMethod = freezed,
    Object? paidAmount = null,
    Object? totalPrice = null,
    Object? serviceModels = null,
    Object? productModels = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? completedAt = freezed,
  }) {
    return _then(_WorkOrderModel(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      workOrderCode: null == workOrderCode
          ? _self.workOrderCode
          : workOrderCode // ignore: cast_nullable_to_non_nullable
              as String,
      customerId: null == customerId
          ? _self.customerId
          : customerId // ignore: cast_nullable_to_non_nullable
              as String,
      vehicleDataId: null == vehicleDataId
          ? _self.vehicleDataId
          : vehicleDataId // ignore: cast_nullable_to_non_nullable
              as String,
      queueNumber: null == queueNumber
          ? _self.queueNumber
          : queueNumber // ignore: cast_nullable_to_non_nullable
              as String,
      estimatedTime: null == estimatedTime
          ? _self.estimatedTime
          : estimatedTime // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      paymentStatus: freezed == paymentStatus
          ? _self.paymentStatus
          : paymentStatus // ignore: cast_nullable_to_non_nullable
              as String?,
      paymentMethod: freezed == paymentMethod
          ? _self.paymentMethod
          : paymentMethod // ignore: cast_nullable_to_non_nullable
              as String?,
      paidAmount: null == paidAmount
          ? _self.paidAmount
          : paidAmount // ignore: cast_nullable_to_non_nullable
              as int,
      totalPrice: null == totalPrice
          ? _self.totalPrice
          : totalPrice // ignore: cast_nullable_to_non_nullable
              as int,
      serviceModels: null == serviceModels
          ? _self._serviceModels
          : serviceModels // ignore: cast_nullable_to_non_nullable
              as List<WorkOrderServiceModel>,
      productModels: null == productModels
          ? _self._productModels
          : productModels // ignore: cast_nullable_to_non_nullable
              as List<WorkOrderProductModel>,
      createdAt: freezed == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      completedAt: freezed == completedAt
          ? _self.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
mixin _$WorkOrderResponseModel {
  @JsonKey(name: "success")
  bool get success;
  @JsonKey(name: "message")
  String get message;
  @JsonKey(name: "data")
  WorkOrderDataModel get data;
  @JsonKey(name: "error_code")
  int get errorCode;

  /// Create a copy of WorkOrderResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $WorkOrderResponseModelCopyWith<WorkOrderResponseModel> get copyWith =>
      _$WorkOrderResponseModelCopyWithImpl<WorkOrderResponseModel>(
          this as WorkOrderResponseModel, _$identity);

  /// Serializes this WorkOrderResponseModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is WorkOrderResponseModel &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.data, data) || other.data == data) &&
            (identical(other.errorCode, errorCode) ||
                other.errorCode == errorCode));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, success, message, data, errorCode);

  @override
  String toString() {
    return 'WorkOrderResponseModel(success: $success, message: $message, data: $data, errorCode: $errorCode)';
  }
}

/// @nodoc
abstract mixin class $WorkOrderResponseModelCopyWith<$Res> {
  factory $WorkOrderResponseModelCopyWith(WorkOrderResponseModel value,
          $Res Function(WorkOrderResponseModel) _then) =
      _$WorkOrderResponseModelCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: "success") bool success,
      @JsonKey(name: "message") String message,
      @JsonKey(name: "data") WorkOrderDataModel data,
      @JsonKey(name: "error_code") int errorCode});

  $WorkOrderDataModelCopyWith<$Res> get data;
}

/// @nodoc
class _$WorkOrderResponseModelCopyWithImpl<$Res>
    implements $WorkOrderResponseModelCopyWith<$Res> {
  _$WorkOrderResponseModelCopyWithImpl(this._self, this._then);

  final WorkOrderResponseModel _self;
  final $Res Function(WorkOrderResponseModel) _then;

  /// Create a copy of WorkOrderResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? message = null,
    Object? data = null,
    Object? errorCode = null,
  }) {
    return _then(_self.copyWith(
      success: null == success
          ? _self.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      data: null == data
          ? _self.data
          : data // ignore: cast_nullable_to_non_nullable
              as WorkOrderDataModel,
      errorCode: null == errorCode
          ? _self.errorCode
          : errorCode // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }

  /// Create a copy of WorkOrderResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $WorkOrderDataModelCopyWith<$Res> get data {
    return $WorkOrderDataModelCopyWith<$Res>(_self.data, (value) {
      return _then(_self.copyWith(data: value));
    });
  }
}

/// Adds pattern-matching-related methods to [WorkOrderResponseModel].
extension WorkOrderResponseModelPatterns on WorkOrderResponseModel {
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
    TResult Function(_WorkOrderResponseModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _WorkOrderResponseModel() when $default != null:
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
    TResult Function(_WorkOrderResponseModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WorkOrderResponseModel():
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
    TResult? Function(_WorkOrderResponseModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WorkOrderResponseModel() when $default != null:
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
            @JsonKey(name: "success") bool success,
            @JsonKey(name: "message") String message,
            @JsonKey(name: "data") WorkOrderDataModel data,
            @JsonKey(name: "error_code") int errorCode)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _WorkOrderResponseModel() when $default != null:
        return $default(
            _that.success, _that.message, _that.data, _that.errorCode);
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
            @JsonKey(name: "success") bool success,
            @JsonKey(name: "message") String message,
            @JsonKey(name: "data") WorkOrderDataModel data,
            @JsonKey(name: "error_code") int errorCode)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WorkOrderResponseModel():
        return $default(
            _that.success, _that.message, _that.data, _that.errorCode);
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
            @JsonKey(name: "success") bool success,
            @JsonKey(name: "message") String message,
            @JsonKey(name: "data") WorkOrderDataModel data,
            @JsonKey(name: "error_code") int errorCode)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WorkOrderResponseModel() when $default != null:
        return $default(
            _that.success, _that.message, _that.data, _that.errorCode);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _WorkOrderResponseModel implements WorkOrderResponseModel {
  const _WorkOrderResponseModel(
      {@JsonKey(name: "success") required this.success,
      @JsonKey(name: "message") required this.message,
      @JsonKey(name: "data") required this.data,
      @JsonKey(name: "error_code") required this.errorCode});
  factory _WorkOrderResponseModel.fromJson(Map<String, dynamic> json) =>
      _$WorkOrderResponseModelFromJson(json);

  @override
  @JsonKey(name: "success")
  final bool success;
  @override
  @JsonKey(name: "message")
  final String message;
  @override
  @JsonKey(name: "data")
  final WorkOrderDataModel data;
  @override
  @JsonKey(name: "error_code")
  final int errorCode;

  /// Create a copy of WorkOrderResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$WorkOrderResponseModelCopyWith<_WorkOrderResponseModel> get copyWith =>
      __$WorkOrderResponseModelCopyWithImpl<_WorkOrderResponseModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$WorkOrderResponseModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _WorkOrderResponseModel &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.data, data) || other.data == data) &&
            (identical(other.errorCode, errorCode) ||
                other.errorCode == errorCode));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, success, message, data, errorCode);

  @override
  String toString() {
    return 'WorkOrderResponseModel(success: $success, message: $message, data: $data, errorCode: $errorCode)';
  }
}

/// @nodoc
abstract mixin class _$WorkOrderResponseModelCopyWith<$Res>
    implements $WorkOrderResponseModelCopyWith<$Res> {
  factory _$WorkOrderResponseModelCopyWith(_WorkOrderResponseModel value,
          $Res Function(_WorkOrderResponseModel) _then) =
      __$WorkOrderResponseModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "success") bool success,
      @JsonKey(name: "message") String message,
      @JsonKey(name: "data") WorkOrderDataModel data,
      @JsonKey(name: "error_code") int errorCode});

  @override
  $WorkOrderDataModelCopyWith<$Res> get data;
}

/// @nodoc
class __$WorkOrderResponseModelCopyWithImpl<$Res>
    implements _$WorkOrderResponseModelCopyWith<$Res> {
  __$WorkOrderResponseModelCopyWithImpl(this._self, this._then);

  final _WorkOrderResponseModel _self;
  final $Res Function(_WorkOrderResponseModel) _then;

  /// Create a copy of WorkOrderResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? success = null,
    Object? message = null,
    Object? data = null,
    Object? errorCode = null,
  }) {
    return _then(_WorkOrderResponseModel(
      success: null == success
          ? _self.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      data: null == data
          ? _self.data
          : data // ignore: cast_nullable_to_non_nullable
              as WorkOrderDataModel,
      errorCode: null == errorCode
          ? _self.errorCode
          : errorCode // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }

  /// Create a copy of WorkOrderResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $WorkOrderDataModelCopyWith<$Res> get data {
    return $WorkOrderDataModelCopyWith<$Res>(_self.data, (value) {
      return _then(_self.copyWith(data: value));
    });
  }
}

/// @nodoc
mixin _$WorkOrderDataModel {
  @JsonKey(name: "data")
  List<WorkOrderModel> get workOrders;
  @JsonKey(name: "total")
  int get total;

  /// Create a copy of WorkOrderDataModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $WorkOrderDataModelCopyWith<WorkOrderDataModel> get copyWith =>
      _$WorkOrderDataModelCopyWithImpl<WorkOrderDataModel>(
          this as WorkOrderDataModel, _$identity);

  /// Serializes this WorkOrderDataModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is WorkOrderDataModel &&
            const DeepCollectionEquality()
                .equals(other.workOrders, workOrders) &&
            (identical(other.total, total) || other.total == total));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(workOrders), total);

  @override
  String toString() {
    return 'WorkOrderDataModel(workOrders: $workOrders, total: $total)';
  }
}

/// @nodoc
abstract mixin class $WorkOrderDataModelCopyWith<$Res> {
  factory $WorkOrderDataModelCopyWith(
          WorkOrderDataModel value, $Res Function(WorkOrderDataModel) _then) =
      _$WorkOrderDataModelCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: "data") List<WorkOrderModel> workOrders,
      @JsonKey(name: "total") int total});
}

/// @nodoc
class _$WorkOrderDataModelCopyWithImpl<$Res>
    implements $WorkOrderDataModelCopyWith<$Res> {
  _$WorkOrderDataModelCopyWithImpl(this._self, this._then);

  final WorkOrderDataModel _self;
  final $Res Function(WorkOrderDataModel) _then;

  /// Create a copy of WorkOrderDataModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? workOrders = null,
    Object? total = null,
  }) {
    return _then(_self.copyWith(
      workOrders: null == workOrders
          ? _self.workOrders
          : workOrders // ignore: cast_nullable_to_non_nullable
              as List<WorkOrderModel>,
      total: null == total
          ? _self.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// Adds pattern-matching-related methods to [WorkOrderDataModel].
extension WorkOrderDataModelPatterns on WorkOrderDataModel {
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
    TResult Function(_WorkOrderDataModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _WorkOrderDataModel() when $default != null:
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
    TResult Function(_WorkOrderDataModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WorkOrderDataModel():
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
    TResult? Function(_WorkOrderDataModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WorkOrderDataModel() when $default != null:
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
    TResult Function(@JsonKey(name: "data") List<WorkOrderModel> workOrders,
            @JsonKey(name: "total") int total)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _WorkOrderDataModel() when $default != null:
        return $default(_that.workOrders, _that.total);
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
    TResult Function(@JsonKey(name: "data") List<WorkOrderModel> workOrders,
            @JsonKey(name: "total") int total)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WorkOrderDataModel():
        return $default(_that.workOrders, _that.total);
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
    TResult? Function(@JsonKey(name: "data") List<WorkOrderModel> workOrders,
            @JsonKey(name: "total") int total)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WorkOrderDataModel() when $default != null:
        return $default(_that.workOrders, _that.total);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _WorkOrderDataModel implements WorkOrderDataModel {
  const _WorkOrderDataModel(
      {@JsonKey(name: "data") required final List<WorkOrderModel> workOrders,
      @JsonKey(name: "total") required this.total})
      : _workOrders = workOrders;
  factory _WorkOrderDataModel.fromJson(Map<String, dynamic> json) =>
      _$WorkOrderDataModelFromJson(json);

  final List<WorkOrderModel> _workOrders;
  @override
  @JsonKey(name: "data")
  List<WorkOrderModel> get workOrders {
    if (_workOrders is EqualUnmodifiableListView) return _workOrders;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_workOrders);
  }

  @override
  @JsonKey(name: "total")
  final int total;

  /// Create a copy of WorkOrderDataModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$WorkOrderDataModelCopyWith<_WorkOrderDataModel> get copyWith =>
      __$WorkOrderDataModelCopyWithImpl<_WorkOrderDataModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$WorkOrderDataModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _WorkOrderDataModel &&
            const DeepCollectionEquality()
                .equals(other._workOrders, _workOrders) &&
            (identical(other.total, total) || other.total == total));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_workOrders), total);

  @override
  String toString() {
    return 'WorkOrderDataModel(workOrders: $workOrders, total: $total)';
  }
}

/// @nodoc
abstract mixin class _$WorkOrderDataModelCopyWith<$Res>
    implements $WorkOrderDataModelCopyWith<$Res> {
  factory _$WorkOrderDataModelCopyWith(
          _WorkOrderDataModel value, $Res Function(_WorkOrderDataModel) _then) =
      __$WorkOrderDataModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "data") List<WorkOrderModel> workOrders,
      @JsonKey(name: "total") int total});
}

/// @nodoc
class __$WorkOrderDataModelCopyWithImpl<$Res>
    implements _$WorkOrderDataModelCopyWith<$Res> {
  __$WorkOrderDataModelCopyWithImpl(this._self, this._then);

  final _WorkOrderDataModel _self;
  final $Res Function(_WorkOrderDataModel) _then;

  /// Create a copy of WorkOrderDataModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? workOrders = null,
    Object? total = null,
  }) {
    return _then(_WorkOrderDataModel(
      workOrders: null == workOrders
          ? _self._workOrders
          : workOrders // ignore: cast_nullable_to_non_nullable
              as List<WorkOrderModel>,
      total: null == total
          ? _self.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

// dart format on
