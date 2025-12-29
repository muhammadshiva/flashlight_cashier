// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'report_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ReportModel {
  @JsonKey(name: 'reportId')
  String get reportId;
  @JsonKey(name: 'reportType')
  String get reportType;
  @JsonKey(name: 'generatedAt')
  DateTime get generatedAt;
  @JsonKey(name: 'data')
  ReportDataModel get data;

  /// Create a copy of ReportModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ReportModelCopyWith<ReportModel> get copyWith =>
      _$ReportModelCopyWithImpl<ReportModel>(this as ReportModel, _$identity);

  /// Serializes this ReportModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ReportModel &&
            (identical(other.reportId, reportId) ||
                other.reportId == reportId) &&
            (identical(other.reportType, reportType) ||
                other.reportType == reportType) &&
            (identical(other.generatedAt, generatedAt) ||
                other.generatedAt == generatedAt) &&
            (identical(other.data, data) || other.data == data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, reportId, reportType, generatedAt, data);

  @override
  String toString() {
    return 'ReportModel(reportId: $reportId, reportType: $reportType, generatedAt: $generatedAt, data: $data)';
  }
}

/// @nodoc
abstract mixin class $ReportModelCopyWith<$Res> {
  factory $ReportModelCopyWith(
          ReportModel value, $Res Function(ReportModel) _then) =
      _$ReportModelCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'reportId') String reportId,
      @JsonKey(name: 'reportType') String reportType,
      @JsonKey(name: 'generatedAt') DateTime generatedAt,
      @JsonKey(name: 'data') ReportDataModel data});

  $ReportDataModelCopyWith<$Res> get data;
}

/// @nodoc
class _$ReportModelCopyWithImpl<$Res> implements $ReportModelCopyWith<$Res> {
  _$ReportModelCopyWithImpl(this._self, this._then);

  final ReportModel _self;
  final $Res Function(ReportModel) _then;

  /// Create a copy of ReportModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? reportId = null,
    Object? reportType = null,
    Object? generatedAt = null,
    Object? data = null,
  }) {
    return _then(_self.copyWith(
      reportId: null == reportId
          ? _self.reportId
          : reportId // ignore: cast_nullable_to_non_nullable
              as String,
      reportType: null == reportType
          ? _self.reportType
          : reportType // ignore: cast_nullable_to_non_nullable
              as String,
      generatedAt: null == generatedAt
          ? _self.generatedAt
          : generatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      data: null == data
          ? _self.data
          : data // ignore: cast_nullable_to_non_nullable
              as ReportDataModel,
    ));
  }

  /// Create a copy of ReportModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ReportDataModelCopyWith<$Res> get data {
    return $ReportDataModelCopyWith<$Res>(_self.data, (value) {
      return _then(_self.copyWith(data: value));
    });
  }
}

/// Adds pattern-matching-related methods to [ReportModel].
extension ReportModelPatterns on ReportModel {
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
    TResult Function(_ReportModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ReportModel() when $default != null:
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
    TResult Function(_ReportModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ReportModel():
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
    TResult? Function(_ReportModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ReportModel() when $default != null:
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
            @JsonKey(name: 'reportId') String reportId,
            @JsonKey(name: 'reportType') String reportType,
            @JsonKey(name: 'generatedAt') DateTime generatedAt,
            @JsonKey(name: 'data') ReportDataModel data)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ReportModel() when $default != null:
        return $default(
            _that.reportId, _that.reportType, _that.generatedAt, _that.data);
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
            @JsonKey(name: 'reportId') String reportId,
            @JsonKey(name: 'reportType') String reportType,
            @JsonKey(name: 'generatedAt') DateTime generatedAt,
            @JsonKey(name: 'data') ReportDataModel data)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ReportModel():
        return $default(
            _that.reportId, _that.reportType, _that.generatedAt, _that.data);
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
            @JsonKey(name: 'reportId') String reportId,
            @JsonKey(name: 'reportType') String reportType,
            @JsonKey(name: 'generatedAt') DateTime generatedAt,
            @JsonKey(name: 'data') ReportDataModel data)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ReportModel() when $default != null:
        return $default(
            _that.reportId, _that.reportType, _that.generatedAt, _that.data);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ReportModel extends ReportModel {
  const _ReportModel(
      {@JsonKey(name: 'reportId') required this.reportId,
      @JsonKey(name: 'reportType') required this.reportType,
      @JsonKey(name: 'generatedAt') required this.generatedAt,
      @JsonKey(name: 'data') required this.data})
      : super._();
  factory _ReportModel.fromJson(Map<String, dynamic> json) =>
      _$ReportModelFromJson(json);

  @override
  @JsonKey(name: 'reportId')
  final String reportId;
  @override
  @JsonKey(name: 'reportType')
  final String reportType;
  @override
  @JsonKey(name: 'generatedAt')
  final DateTime generatedAt;
  @override
  @JsonKey(name: 'data')
  final ReportDataModel data;

  /// Create a copy of ReportModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ReportModelCopyWith<_ReportModel> get copyWith =>
      __$ReportModelCopyWithImpl<_ReportModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ReportModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ReportModel &&
            (identical(other.reportId, reportId) ||
                other.reportId == reportId) &&
            (identical(other.reportType, reportType) ||
                other.reportType == reportType) &&
            (identical(other.generatedAt, generatedAt) ||
                other.generatedAt == generatedAt) &&
            (identical(other.data, data) || other.data == data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, reportId, reportType, generatedAt, data);

  @override
  String toString() {
    return 'ReportModel(reportId: $reportId, reportType: $reportType, generatedAt: $generatedAt, data: $data)';
  }
}

/// @nodoc
abstract mixin class _$ReportModelCopyWith<$Res>
    implements $ReportModelCopyWith<$Res> {
  factory _$ReportModelCopyWith(
          _ReportModel value, $Res Function(_ReportModel) _then) =
      __$ReportModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'reportId') String reportId,
      @JsonKey(name: 'reportType') String reportType,
      @JsonKey(name: 'generatedAt') DateTime generatedAt,
      @JsonKey(name: 'data') ReportDataModel data});

  @override
  $ReportDataModelCopyWith<$Res> get data;
}

/// @nodoc
class __$ReportModelCopyWithImpl<$Res> implements _$ReportModelCopyWith<$Res> {
  __$ReportModelCopyWithImpl(this._self, this._then);

  final _ReportModel _self;
  final $Res Function(_ReportModel) _then;

  /// Create a copy of ReportModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? reportId = null,
    Object? reportType = null,
    Object? generatedAt = null,
    Object? data = null,
  }) {
    return _then(_ReportModel(
      reportId: null == reportId
          ? _self.reportId
          : reportId // ignore: cast_nullable_to_non_nullable
              as String,
      reportType: null == reportType
          ? _self.reportType
          : reportType // ignore: cast_nullable_to_non_nullable
              as String,
      generatedAt: null == generatedAt
          ? _self.generatedAt
          : generatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      data: null == data
          ? _self.data
          : data // ignore: cast_nullable_to_non_nullable
              as ReportDataModel,
    ));
  }

  /// Create a copy of ReportModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ReportDataModelCopyWith<$Res> get data {
    return $ReportDataModelCopyWith<$Res>(_self.data, (value) {
      return _then(_self.copyWith(data: value));
    });
  }
}

// dart format on
