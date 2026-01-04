// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ui_state_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$UIStateModel<T> {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(T data) success,
    required TResult Function(String message) empty,
    required TResult Function() loading,
    required TResult Function(String message) error,
    required TResult Function() idle,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(T data)? success,
    TResult? Function(String message)? empty,
    TResult? Function()? loading,
    TResult? Function(String message)? error,
    TResult? Function()? idle,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(T data)? success,
    TResult Function(String message)? empty,
    TResult Function()? loading,
    TResult Function(String message)? error,
    TResult Function()? idle,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UIStateModelSuccess<T> value) success,
    required TResult Function(UIStateModelEmpty<T> value) empty,
    required TResult Function(UIStateModelLoading<T> value) loading,
    required TResult Function(UIStateModelError<T> value) error,
    required TResult Function(UIStateModelIdle<T> value) idle,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(UIStateModelSuccess<T> value)? success,
    TResult? Function(UIStateModelEmpty<T> value)? empty,
    TResult? Function(UIStateModelLoading<T> value)? loading,
    TResult? Function(UIStateModelError<T> value)? error,
    TResult? Function(UIStateModelIdle<T> value)? idle,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UIStateModelSuccess<T> value)? success,
    TResult Function(UIStateModelEmpty<T> value)? empty,
    TResult Function(UIStateModelLoading<T> value)? loading,
    TResult Function(UIStateModelError<T> value)? error,
    TResult Function(UIStateModelIdle<T> value)? idle,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UIStateModelCopyWith<T, $Res> {
  factory $UIStateModelCopyWith(
          UIStateModel<T> value, $Res Function(UIStateModel<T>) then) =
      _$UIStateModelCopyWithImpl<T, $Res, UIStateModel<T>>;
}

/// @nodoc
class _$UIStateModelCopyWithImpl<T, $Res, $Val extends UIStateModel<T>>
    implements $UIStateModelCopyWith<T, $Res> {
  _$UIStateModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$UIStateModelSuccessImplCopyWith<T, $Res> {
  factory _$$UIStateModelSuccessImplCopyWith(_$UIStateModelSuccessImpl<T> value,
          $Res Function(_$UIStateModelSuccessImpl<T>) then) =
      __$$UIStateModelSuccessImplCopyWithImpl<T, $Res>;
  @useResult
  $Res call({T data});
}

/// @nodoc
class __$$UIStateModelSuccessImplCopyWithImpl<T, $Res>
    extends _$UIStateModelCopyWithImpl<T, $Res, _$UIStateModelSuccessImpl<T>>
    implements _$$UIStateModelSuccessImplCopyWith<T, $Res> {
  __$$UIStateModelSuccessImplCopyWithImpl(_$UIStateModelSuccessImpl<T> _value,
      $Res Function(_$UIStateModelSuccessImpl<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(_$UIStateModelSuccessImpl<T>(
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as T,
    ));
  }
}

/// @nodoc

class _$UIStateModelSuccessImpl<T> implements UIStateModelSuccess<T> {
  const _$UIStateModelSuccessImpl({required this.data});

  @override
  final T data;

  @override
  String toString() {
    return 'UIStateModel<$T>.success(data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UIStateModelSuccessImpl<T> &&
            const DeepCollectionEquality().equals(other.data, data));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UIStateModelSuccessImplCopyWith<T, _$UIStateModelSuccessImpl<T>>
      get copyWith => __$$UIStateModelSuccessImplCopyWithImpl<T,
          _$UIStateModelSuccessImpl<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(T data) success,
    required TResult Function(String message) empty,
    required TResult Function() loading,
    required TResult Function(String message) error,
    required TResult Function() idle,
  }) {
    return success(data);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(T data)? success,
    TResult? Function(String message)? empty,
    TResult? Function()? loading,
    TResult? Function(String message)? error,
    TResult? Function()? idle,
  }) {
    return success?.call(data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(T data)? success,
    TResult Function(String message)? empty,
    TResult Function()? loading,
    TResult Function(String message)? error,
    TResult Function()? idle,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UIStateModelSuccess<T> value) success,
    required TResult Function(UIStateModelEmpty<T> value) empty,
    required TResult Function(UIStateModelLoading<T> value) loading,
    required TResult Function(UIStateModelError<T> value) error,
    required TResult Function(UIStateModelIdle<T> value) idle,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(UIStateModelSuccess<T> value)? success,
    TResult? Function(UIStateModelEmpty<T> value)? empty,
    TResult? Function(UIStateModelLoading<T> value)? loading,
    TResult? Function(UIStateModelError<T> value)? error,
    TResult? Function(UIStateModelIdle<T> value)? idle,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UIStateModelSuccess<T> value)? success,
    TResult Function(UIStateModelEmpty<T> value)? empty,
    TResult Function(UIStateModelLoading<T> value)? loading,
    TResult Function(UIStateModelError<T> value)? error,
    TResult Function(UIStateModelIdle<T> value)? idle,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class UIStateModelSuccess<T> implements UIStateModel<T> {
  const factory UIStateModelSuccess({required final T data}) =
      _$UIStateModelSuccessImpl<T>;

  T get data;
  @JsonKey(ignore: true)
  _$$UIStateModelSuccessImplCopyWith<T, _$UIStateModelSuccessImpl<T>>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UIStateModelEmptyImplCopyWith<T, $Res> {
  factory _$$UIStateModelEmptyImplCopyWith(_$UIStateModelEmptyImpl<T> value,
          $Res Function(_$UIStateModelEmptyImpl<T>) then) =
      __$$UIStateModelEmptyImplCopyWithImpl<T, $Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$UIStateModelEmptyImplCopyWithImpl<T, $Res>
    extends _$UIStateModelCopyWithImpl<T, $Res, _$UIStateModelEmptyImpl<T>>
    implements _$$UIStateModelEmptyImplCopyWith<T, $Res> {
  __$$UIStateModelEmptyImplCopyWithImpl(_$UIStateModelEmptyImpl<T> _value,
      $Res Function(_$UIStateModelEmptyImpl<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$UIStateModelEmptyImpl<T>(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$UIStateModelEmptyImpl<T> implements UIStateModelEmpty<T> {
  const _$UIStateModelEmptyImpl(
      {this.message = 'Maaf, saat ini data kamu tidak tersedia'});

  @override
  @JsonKey()
  final String message;

  @override
  String toString() {
    return 'UIStateModel<$T>.empty(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UIStateModelEmptyImpl<T> &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UIStateModelEmptyImplCopyWith<T, _$UIStateModelEmptyImpl<T>>
      get copyWith =>
          __$$UIStateModelEmptyImplCopyWithImpl<T, _$UIStateModelEmptyImpl<T>>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(T data) success,
    required TResult Function(String message) empty,
    required TResult Function() loading,
    required TResult Function(String message) error,
    required TResult Function() idle,
  }) {
    return empty(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(T data)? success,
    TResult? Function(String message)? empty,
    TResult? Function()? loading,
    TResult? Function(String message)? error,
    TResult? Function()? idle,
  }) {
    return empty?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(T data)? success,
    TResult Function(String message)? empty,
    TResult Function()? loading,
    TResult Function(String message)? error,
    TResult Function()? idle,
    required TResult orElse(),
  }) {
    if (empty != null) {
      return empty(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UIStateModelSuccess<T> value) success,
    required TResult Function(UIStateModelEmpty<T> value) empty,
    required TResult Function(UIStateModelLoading<T> value) loading,
    required TResult Function(UIStateModelError<T> value) error,
    required TResult Function(UIStateModelIdle<T> value) idle,
  }) {
    return empty(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(UIStateModelSuccess<T> value)? success,
    TResult? Function(UIStateModelEmpty<T> value)? empty,
    TResult? Function(UIStateModelLoading<T> value)? loading,
    TResult? Function(UIStateModelError<T> value)? error,
    TResult? Function(UIStateModelIdle<T> value)? idle,
  }) {
    return empty?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UIStateModelSuccess<T> value)? success,
    TResult Function(UIStateModelEmpty<T> value)? empty,
    TResult Function(UIStateModelLoading<T> value)? loading,
    TResult Function(UIStateModelError<T> value)? error,
    TResult Function(UIStateModelIdle<T> value)? idle,
    required TResult orElse(),
  }) {
    if (empty != null) {
      return empty(this);
    }
    return orElse();
  }
}

abstract class UIStateModelEmpty<T> implements UIStateModel<T> {
  const factory UIStateModelEmpty({final String message}) =
      _$UIStateModelEmptyImpl<T>;

  String get message;
  @JsonKey(ignore: true)
  _$$UIStateModelEmptyImplCopyWith<T, _$UIStateModelEmptyImpl<T>>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UIStateModelLoadingImplCopyWith<T, $Res> {
  factory _$$UIStateModelLoadingImplCopyWith(_$UIStateModelLoadingImpl<T> value,
          $Res Function(_$UIStateModelLoadingImpl<T>) then) =
      __$$UIStateModelLoadingImplCopyWithImpl<T, $Res>;
}

/// @nodoc
class __$$UIStateModelLoadingImplCopyWithImpl<T, $Res>
    extends _$UIStateModelCopyWithImpl<T, $Res, _$UIStateModelLoadingImpl<T>>
    implements _$$UIStateModelLoadingImplCopyWith<T, $Res> {
  __$$UIStateModelLoadingImplCopyWithImpl(_$UIStateModelLoadingImpl<T> _value,
      $Res Function(_$UIStateModelLoadingImpl<T>) _then)
      : super(_value, _then);
}

/// @nodoc

class _$UIStateModelLoadingImpl<T> implements UIStateModelLoading<T> {
  const _$UIStateModelLoadingImpl();

  @override
  String toString() {
    return 'UIStateModel<$T>.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UIStateModelLoadingImpl<T>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(T data) success,
    required TResult Function(String message) empty,
    required TResult Function() loading,
    required TResult Function(String message) error,
    required TResult Function() idle,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(T data)? success,
    TResult? Function(String message)? empty,
    TResult? Function()? loading,
    TResult? Function(String message)? error,
    TResult? Function()? idle,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(T data)? success,
    TResult Function(String message)? empty,
    TResult Function()? loading,
    TResult Function(String message)? error,
    TResult Function()? idle,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UIStateModelSuccess<T> value) success,
    required TResult Function(UIStateModelEmpty<T> value) empty,
    required TResult Function(UIStateModelLoading<T> value) loading,
    required TResult Function(UIStateModelError<T> value) error,
    required TResult Function(UIStateModelIdle<T> value) idle,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(UIStateModelSuccess<T> value)? success,
    TResult? Function(UIStateModelEmpty<T> value)? empty,
    TResult? Function(UIStateModelLoading<T> value)? loading,
    TResult? Function(UIStateModelError<T> value)? error,
    TResult? Function(UIStateModelIdle<T> value)? idle,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UIStateModelSuccess<T> value)? success,
    TResult Function(UIStateModelEmpty<T> value)? empty,
    TResult Function(UIStateModelLoading<T> value)? loading,
    TResult Function(UIStateModelError<T> value)? error,
    TResult Function(UIStateModelIdle<T> value)? idle,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class UIStateModelLoading<T> implements UIStateModel<T> {
  const factory UIStateModelLoading() = _$UIStateModelLoadingImpl<T>;
}

/// @nodoc
abstract class _$$UIStateModelErrorImplCopyWith<T, $Res> {
  factory _$$UIStateModelErrorImplCopyWith(_$UIStateModelErrorImpl<T> value,
          $Res Function(_$UIStateModelErrorImpl<T>) then) =
      __$$UIStateModelErrorImplCopyWithImpl<T, $Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$UIStateModelErrorImplCopyWithImpl<T, $Res>
    extends _$UIStateModelCopyWithImpl<T, $Res, _$UIStateModelErrorImpl<T>>
    implements _$$UIStateModelErrorImplCopyWith<T, $Res> {
  __$$UIStateModelErrorImplCopyWithImpl(_$UIStateModelErrorImpl<T> _value,
      $Res Function(_$UIStateModelErrorImpl<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$UIStateModelErrorImpl<T>(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$UIStateModelErrorImpl<T> implements UIStateModelError<T> {
  const _$UIStateModelErrorImpl(
      {this.message = 'Terjadi Kesalahan, Silakan Coba Lagi'});

  @override
  @JsonKey()
  final String message;

  @override
  String toString() {
    return 'UIStateModel<$T>.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UIStateModelErrorImpl<T> &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UIStateModelErrorImplCopyWith<T, _$UIStateModelErrorImpl<T>>
      get copyWith =>
          __$$UIStateModelErrorImplCopyWithImpl<T, _$UIStateModelErrorImpl<T>>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(T data) success,
    required TResult Function(String message) empty,
    required TResult Function() loading,
    required TResult Function(String message) error,
    required TResult Function() idle,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(T data)? success,
    TResult? Function(String message)? empty,
    TResult? Function()? loading,
    TResult? Function(String message)? error,
    TResult? Function()? idle,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(T data)? success,
    TResult Function(String message)? empty,
    TResult Function()? loading,
    TResult Function(String message)? error,
    TResult Function()? idle,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UIStateModelSuccess<T> value) success,
    required TResult Function(UIStateModelEmpty<T> value) empty,
    required TResult Function(UIStateModelLoading<T> value) loading,
    required TResult Function(UIStateModelError<T> value) error,
    required TResult Function(UIStateModelIdle<T> value) idle,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(UIStateModelSuccess<T> value)? success,
    TResult? Function(UIStateModelEmpty<T> value)? empty,
    TResult? Function(UIStateModelLoading<T> value)? loading,
    TResult? Function(UIStateModelError<T> value)? error,
    TResult? Function(UIStateModelIdle<T> value)? idle,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UIStateModelSuccess<T> value)? success,
    TResult Function(UIStateModelEmpty<T> value)? empty,
    TResult Function(UIStateModelLoading<T> value)? loading,
    TResult Function(UIStateModelError<T> value)? error,
    TResult Function(UIStateModelIdle<T> value)? idle,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class UIStateModelError<T> implements UIStateModel<T> {
  const factory UIStateModelError({final String message}) =
      _$UIStateModelErrorImpl<T>;

  String get message;
  @JsonKey(ignore: true)
  _$$UIStateModelErrorImplCopyWith<T, _$UIStateModelErrorImpl<T>>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UIStateModelIdleImplCopyWith<T, $Res> {
  factory _$$UIStateModelIdleImplCopyWith(_$UIStateModelIdleImpl<T> value,
          $Res Function(_$UIStateModelIdleImpl<T>) then) =
      __$$UIStateModelIdleImplCopyWithImpl<T, $Res>;
}

/// @nodoc
class __$$UIStateModelIdleImplCopyWithImpl<T, $Res>
    extends _$UIStateModelCopyWithImpl<T, $Res, _$UIStateModelIdleImpl<T>>
    implements _$$UIStateModelIdleImplCopyWith<T, $Res> {
  __$$UIStateModelIdleImplCopyWithImpl(_$UIStateModelIdleImpl<T> _value,
      $Res Function(_$UIStateModelIdleImpl<T>) _then)
      : super(_value, _then);
}

/// @nodoc

class _$UIStateModelIdleImpl<T> implements UIStateModelIdle<T> {
  const _$UIStateModelIdleImpl();

  @override
  String toString() {
    return 'UIStateModel<$T>.idle()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UIStateModelIdleImpl<T>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(T data) success,
    required TResult Function(String message) empty,
    required TResult Function() loading,
    required TResult Function(String message) error,
    required TResult Function() idle,
  }) {
    return idle();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(T data)? success,
    TResult? Function(String message)? empty,
    TResult? Function()? loading,
    TResult? Function(String message)? error,
    TResult? Function()? idle,
  }) {
    return idle?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(T data)? success,
    TResult Function(String message)? empty,
    TResult Function()? loading,
    TResult Function(String message)? error,
    TResult Function()? idle,
    required TResult orElse(),
  }) {
    if (idle != null) {
      return idle();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UIStateModelSuccess<T> value) success,
    required TResult Function(UIStateModelEmpty<T> value) empty,
    required TResult Function(UIStateModelLoading<T> value) loading,
    required TResult Function(UIStateModelError<T> value) error,
    required TResult Function(UIStateModelIdle<T> value) idle,
  }) {
    return idle(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(UIStateModelSuccess<T> value)? success,
    TResult? Function(UIStateModelEmpty<T> value)? empty,
    TResult? Function(UIStateModelLoading<T> value)? loading,
    TResult? Function(UIStateModelError<T> value)? error,
    TResult? Function(UIStateModelIdle<T> value)? idle,
  }) {
    return idle?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UIStateModelSuccess<T> value)? success,
    TResult Function(UIStateModelEmpty<T> value)? empty,
    TResult Function(UIStateModelLoading<T> value)? loading,
    TResult Function(UIStateModelError<T> value)? error,
    TResult Function(UIStateModelIdle<T> value)? idle,
    required TResult orElse(),
  }) {
    if (idle != null) {
      return idle(this);
    }
    return orElse();
  }
}

abstract class UIStateModelIdle<T> implements UIStateModel<T> {
  const factory UIStateModelIdle() = _$UIStateModelIdleImpl<T>;
}
