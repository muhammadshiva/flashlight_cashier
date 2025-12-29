// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'paginated_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PaginatedResponseModel<T> {
  @JsonKey(name: 'data')
  List<T> get data;
  @JsonKey(name: 'total')
  int get total;
  @JsonKey(name: 'page')
  int get page;
  @JsonKey(name: 'limit')
  int get limit;
  @JsonKey(name: 'totalPages')
  int get totalPages;

  /// Create a copy of PaginatedResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PaginatedResponseModelCopyWith<T, PaginatedResponseModel<T>> get copyWith =>
      _$PaginatedResponseModelCopyWithImpl<T, PaginatedResponseModel<T>>(
          this as PaginatedResponseModel<T>, _$identity);

  /// Serializes this PaginatedResponseModel to a JSON map.
  Map<String, dynamic> toJson(Object? Function(T) toJsonT);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PaginatedResponseModel<T> &&
            const DeepCollectionEquality().equals(other.data, data) &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.limit, limit) || other.limit == limit) &&
            (identical(other.totalPages, totalPages) ||
                other.totalPages == totalPages));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(data),
      total,
      page,
      limit,
      totalPages);

  @override
  String toString() {
    return 'PaginatedResponseModel<$T>(data: $data, total: $total, page: $page, limit: $limit, totalPages: $totalPages)';
  }
}

/// @nodoc
abstract mixin class $PaginatedResponseModelCopyWith<T, $Res> {
  factory $PaginatedResponseModelCopyWith(PaginatedResponseModel<T> value,
          $Res Function(PaginatedResponseModel<T>) _then) =
      _$PaginatedResponseModelCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'data') List<T> data,
      @JsonKey(name: 'total') int total,
      @JsonKey(name: 'page') int page,
      @JsonKey(name: 'limit') int limit,
      @JsonKey(name: 'totalPages') int totalPages});
}

/// @nodoc
class _$PaginatedResponseModelCopyWithImpl<T, $Res>
    implements $PaginatedResponseModelCopyWith<T, $Res> {
  _$PaginatedResponseModelCopyWithImpl(this._self, this._then);

  final PaginatedResponseModel<T> _self;
  final $Res Function(PaginatedResponseModel<T>) _then;

  /// Create a copy of PaginatedResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? total = null,
    Object? page = null,
    Object? limit = null,
    Object? totalPages = null,
  }) {
    return _then(_self.copyWith(
      data: null == data
          ? _self.data
          : data // ignore: cast_nullable_to_non_nullable
              as List<T>,
      total: null == total
          ? _self.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      page: null == page
          ? _self.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      limit: null == limit
          ? _self.limit
          : limit // ignore: cast_nullable_to_non_nullable
              as int,
      totalPages: null == totalPages
          ? _self.totalPages
          : totalPages // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// Adds pattern-matching-related methods to [PaginatedResponseModel].
extension PaginatedResponseModelPatterns<T> on PaginatedResponseModel<T> {
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
    TResult Function(_PaginatedResponseModel<T> value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PaginatedResponseModel() when $default != null:
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
    TResult Function(_PaginatedResponseModel<T> value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PaginatedResponseModel():
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
    TResult? Function(_PaginatedResponseModel<T> value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PaginatedResponseModel() when $default != null:
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
            @JsonKey(name: 'data') List<T> data,
            @JsonKey(name: 'total') int total,
            @JsonKey(name: 'page') int page,
            @JsonKey(name: 'limit') int limit,
            @JsonKey(name: 'totalPages') int totalPages)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PaginatedResponseModel() when $default != null:
        return $default(
            _that.data, _that.total, _that.page, _that.limit, _that.totalPages);
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
            @JsonKey(name: 'data') List<T> data,
            @JsonKey(name: 'total') int total,
            @JsonKey(name: 'page') int page,
            @JsonKey(name: 'limit') int limit,
            @JsonKey(name: 'totalPages') int totalPages)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PaginatedResponseModel():
        return $default(
            _that.data, _that.total, _that.page, _that.limit, _that.totalPages);
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
            @JsonKey(name: 'data') List<T> data,
            @JsonKey(name: 'total') int total,
            @JsonKey(name: 'page') int page,
            @JsonKey(name: 'limit') int limit,
            @JsonKey(name: 'totalPages') int totalPages)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PaginatedResponseModel() when $default != null:
        return $default(
            _that.data, _that.total, _that.page, _that.limit, _that.totalPages);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable(genericArgumentFactories: true)
class _PaginatedResponseModel<T> extends PaginatedResponseModel<T> {
  const _PaginatedResponseModel(
      {@JsonKey(name: 'data') required final List<T> data,
      @JsonKey(name: 'total') required this.total,
      @JsonKey(name: 'page') required this.page,
      @JsonKey(name: 'limit') required this.limit,
      @JsonKey(name: 'totalPages') required this.totalPages})
      : _data = data,
        super._();
  factory _PaginatedResponseModel.fromJson(
          Map<String, dynamic> json, T Function(Object?) fromJsonT) =>
      _$PaginatedResponseModelFromJson(json, fromJsonT);

  final List<T> _data;
  @override
  @JsonKey(name: 'data')
  List<T> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  @override
  @JsonKey(name: 'total')
  final int total;
  @override
  @JsonKey(name: 'page')
  final int page;
  @override
  @JsonKey(name: 'limit')
  final int limit;
  @override
  @JsonKey(name: 'totalPages')
  final int totalPages;

  /// Create a copy of PaginatedResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PaginatedResponseModelCopyWith<T, _PaginatedResponseModel<T>>
      get copyWith =>
          __$PaginatedResponseModelCopyWithImpl<T, _PaginatedResponseModel<T>>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson(Object? Function(T) toJsonT) {
    return _$PaginatedResponseModelToJson<T>(this, toJsonT);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PaginatedResponseModel<T> &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.limit, limit) || other.limit == limit) &&
            (identical(other.totalPages, totalPages) ||
                other.totalPages == totalPages));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_data),
      total,
      page,
      limit,
      totalPages);

  @override
  String toString() {
    return 'PaginatedResponseModel<$T>(data: $data, total: $total, page: $page, limit: $limit, totalPages: $totalPages)';
  }
}

/// @nodoc
abstract mixin class _$PaginatedResponseModelCopyWith<T, $Res>
    implements $PaginatedResponseModelCopyWith<T, $Res> {
  factory _$PaginatedResponseModelCopyWith(_PaginatedResponseModel<T> value,
          $Res Function(_PaginatedResponseModel<T>) _then) =
      __$PaginatedResponseModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'data') List<T> data,
      @JsonKey(name: 'total') int total,
      @JsonKey(name: 'page') int page,
      @JsonKey(name: 'limit') int limit,
      @JsonKey(name: 'totalPages') int totalPages});
}

/// @nodoc
class __$PaginatedResponseModelCopyWithImpl<T, $Res>
    implements _$PaginatedResponseModelCopyWith<T, $Res> {
  __$PaginatedResponseModelCopyWithImpl(this._self, this._then);

  final _PaginatedResponseModel<T> _self;
  final $Res Function(_PaginatedResponseModel<T>) _then;

  /// Create a copy of PaginatedResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? data = null,
    Object? total = null,
    Object? page = null,
    Object? limit = null,
    Object? totalPages = null,
  }) {
    return _then(_PaginatedResponseModel<T>(
      data: null == data
          ? _self._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<T>,
      total: null == total
          ? _self.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      page: null == page
          ? _self.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      limit: null == limit
          ? _self.limit
          : limit // ignore: cast_nullable_to_non_nullable
              as int,
      totalPages: null == totalPages
          ? _self.totalPages
          : totalPages // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

// dart format on
