// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'customer_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CustomerModel {
  @JsonKey(name: "id")
  String get id;
  @JsonKey(name: "name")
  String get name;
  @JsonKey(name: "phoneNumber")
  String get phoneNumber;
  @JsonKey(name: "email")
  String get email;
  @JsonKey(name: "membership")
  MembershipModel? get membership;
  @JsonKey(name: "workOrders")
  List<WorkOrderModel>? get workOrders;

  /// Create a copy of CustomerModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CustomerModelCopyWith<CustomerModel> get copyWith =>
      _$CustomerModelCopyWithImpl<CustomerModel>(
          this as CustomerModel, _$identity);

  /// Serializes this CustomerModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CustomerModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.membership, membership) ||
                other.membership == membership) &&
            const DeepCollectionEquality()
                .equals(other.workOrders, workOrders));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, phoneNumber, email,
      membership, const DeepCollectionEquality().hash(workOrders));

  @override
  String toString() {
    return 'CustomerModel(id: $id, name: $name, phoneNumber: $phoneNumber, email: $email, membership: $membership, workOrders: $workOrders)';
  }
}

/// @nodoc
abstract mixin class $CustomerModelCopyWith<$Res> {
  factory $CustomerModelCopyWith(
          CustomerModel value, $Res Function(CustomerModel) _then) =
      _$CustomerModelCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: "id") String id,
      @JsonKey(name: "name") String name,
      @JsonKey(name: "phoneNumber") String phoneNumber,
      @JsonKey(name: "email") String email,
      @JsonKey(name: "membership") MembershipModel? membership,
      @JsonKey(name: "workOrders") List<WorkOrderModel>? workOrders});

  $MembershipModelCopyWith<$Res>? get membership;
}

/// @nodoc
class _$CustomerModelCopyWithImpl<$Res>
    implements $CustomerModelCopyWith<$Res> {
  _$CustomerModelCopyWithImpl(this._self, this._then);

  final CustomerModel _self;
  final $Res Function(CustomerModel) _then;

  /// Create a copy of CustomerModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? phoneNumber = null,
    Object? email = null,
    Object? membership = freezed,
    Object? workOrders = freezed,
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
      phoneNumber: null == phoneNumber
          ? _self.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      membership: freezed == membership
          ? _self.membership
          : membership // ignore: cast_nullable_to_non_nullable
              as MembershipModel?,
      workOrders: freezed == workOrders
          ? _self.workOrders
          : workOrders // ignore: cast_nullable_to_non_nullable
              as List<WorkOrderModel>?,
    ));
  }

  /// Create a copy of CustomerModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MembershipModelCopyWith<$Res>? get membership {
    if (_self.membership == null) {
      return null;
    }

    return $MembershipModelCopyWith<$Res>(_self.membership!, (value) {
      return _then(_self.copyWith(membership: value));
    });
  }
}

/// Adds pattern-matching-related methods to [CustomerModel].
extension CustomerModelPatterns on CustomerModel {
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
    TResult Function(_CustomerModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CustomerModel() when $default != null:
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
    TResult Function(_CustomerModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CustomerModel():
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
    TResult? Function(_CustomerModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CustomerModel() when $default != null:
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
            @JsonKey(name: "name") String name,
            @JsonKey(name: "phoneNumber") String phoneNumber,
            @JsonKey(name: "email") String email,
            @JsonKey(name: "membership") MembershipModel? membership,
            @JsonKey(name: "workOrders") List<WorkOrderModel>? workOrders)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CustomerModel() when $default != null:
        return $default(_that.id, _that.name, _that.phoneNumber, _that.email,
            _that.membership, _that.workOrders);
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
            @JsonKey(name: "name") String name,
            @JsonKey(name: "phoneNumber") String phoneNumber,
            @JsonKey(name: "email") String email,
            @JsonKey(name: "membership") MembershipModel? membership,
            @JsonKey(name: "workOrders") List<WorkOrderModel>? workOrders)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CustomerModel():
        return $default(_that.id, _that.name, _that.phoneNumber, _that.email,
            _that.membership, _that.workOrders);
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
            @JsonKey(name: "name") String name,
            @JsonKey(name: "phoneNumber") String phoneNumber,
            @JsonKey(name: "email") String email,
            @JsonKey(name: "membership") MembershipModel? membership,
            @JsonKey(name: "workOrders") List<WorkOrderModel>? workOrders)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CustomerModel() when $default != null:
        return $default(_that.id, _that.name, _that.phoneNumber, _that.email,
            _that.membership, _that.workOrders);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _CustomerModel extends CustomerModel {
  const _CustomerModel(
      {@JsonKey(name: "id") required this.id,
      @JsonKey(name: "name") required this.name,
      @JsonKey(name: "phoneNumber") required this.phoneNumber,
      @JsonKey(name: "email") required this.email,
      @JsonKey(name: "membership") this.membership,
      @JsonKey(name: "workOrders") final List<WorkOrderModel>? workOrders})
      : _workOrders = workOrders,
        super._();
  factory _CustomerModel.fromJson(Map<String, dynamic> json) =>
      _$CustomerModelFromJson(json);

  @override
  @JsonKey(name: "id")
  final String id;
  @override
  @JsonKey(name: "name")
  final String name;
  @override
  @JsonKey(name: "phoneNumber")
  final String phoneNumber;
  @override
  @JsonKey(name: "email")
  final String email;
  @override
  @JsonKey(name: "membership")
  final MembershipModel? membership;
  final List<WorkOrderModel>? _workOrders;
  @override
  @JsonKey(name: "workOrders")
  List<WorkOrderModel>? get workOrders {
    final value = _workOrders;
    if (value == null) return null;
    if (_workOrders is EqualUnmodifiableListView) return _workOrders;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  /// Create a copy of CustomerModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CustomerModelCopyWith<_CustomerModel> get copyWith =>
      __$CustomerModelCopyWithImpl<_CustomerModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$CustomerModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CustomerModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.membership, membership) ||
                other.membership == membership) &&
            const DeepCollectionEquality()
                .equals(other._workOrders, _workOrders));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, phoneNumber, email,
      membership, const DeepCollectionEquality().hash(_workOrders));

  @override
  String toString() {
    return 'CustomerModel(id: $id, name: $name, phoneNumber: $phoneNumber, email: $email, membership: $membership, workOrders: $workOrders)';
  }
}

/// @nodoc
abstract mixin class _$CustomerModelCopyWith<$Res>
    implements $CustomerModelCopyWith<$Res> {
  factory _$CustomerModelCopyWith(
          _CustomerModel value, $Res Function(_CustomerModel) _then) =
      __$CustomerModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "id") String id,
      @JsonKey(name: "name") String name,
      @JsonKey(name: "phoneNumber") String phoneNumber,
      @JsonKey(name: "email") String email,
      @JsonKey(name: "membership") MembershipModel? membership,
      @JsonKey(name: "workOrders") List<WorkOrderModel>? workOrders});

  @override
  $MembershipModelCopyWith<$Res>? get membership;
}

/// @nodoc
class __$CustomerModelCopyWithImpl<$Res>
    implements _$CustomerModelCopyWith<$Res> {
  __$CustomerModelCopyWithImpl(this._self, this._then);

  final _CustomerModel _self;
  final $Res Function(_CustomerModel) _then;

  /// Create a copy of CustomerModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? phoneNumber = null,
    Object? email = null,
    Object? membership = freezed,
    Object? workOrders = freezed,
  }) {
    return _then(_CustomerModel(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumber: null == phoneNumber
          ? _self.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      membership: freezed == membership
          ? _self.membership
          : membership // ignore: cast_nullable_to_non_nullable
              as MembershipModel?,
      workOrders: freezed == workOrders
          ? _self._workOrders
          : workOrders // ignore: cast_nullable_to_non_nullable
              as List<WorkOrderModel>?,
    ));
  }

  /// Create a copy of CustomerModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MembershipModelCopyWith<$Res>? get membership {
    if (_self.membership == null) {
      return null;
    }

    return $MembershipModelCopyWith<$Res>(_self.membership!, (value) {
      return _then(_self.copyWith(membership: value));
    });
  }
}

// dart format on
