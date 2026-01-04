// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ui_state_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UIStateModel<T> {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is UIStateModel<T>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'UIStateModel<$T>()';
  }
}

/// @nodoc
class $UIStateModelCopyWith<T, $Res> {
  $UIStateModelCopyWith(UIStateModel<T> _, $Res Function(UIStateModel<T>) __);
}

/// Adds pattern-matching-related methods to [UIStateModel].
extension UIStateModelPatterns<T> on UIStateModel<T> {
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
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UIStateModelSuccess<T> value)? success,
    TResult Function(UIStateModelEmpty<T> value)? empty,
    TResult Function(UIStateModelLoading<T> value)? loading,
    TResult Function(UIStateModelError<T> value)? error,
    TResult Function(UIStateModelIdle<T> value)? idle,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case UIStateModelSuccess() when success != null:
        return success(_that);
      case UIStateModelEmpty() when empty != null:
        return empty(_that);
      case UIStateModelLoading() when loading != null:
        return loading(_that);
      case UIStateModelError() when error != null:
        return error(_that);
      case UIStateModelIdle() when idle != null:
        return idle(_that);
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
  TResult map<TResult extends Object?>({
    required TResult Function(UIStateModelSuccess<T> value) success,
    required TResult Function(UIStateModelEmpty<T> value) empty,
    required TResult Function(UIStateModelLoading<T> value) loading,
    required TResult Function(UIStateModelError<T> value) error,
    required TResult Function(UIStateModelIdle<T> value) idle,
  }) {
    final _that = this;
    switch (_that) {
      case UIStateModelSuccess():
        return success(_that);
      case UIStateModelEmpty():
        return empty(_that);
      case UIStateModelLoading():
        return loading(_that);
      case UIStateModelError():
        return error(_that);
      case UIStateModelIdle():
        return idle(_that);
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
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(UIStateModelSuccess<T> value)? success,
    TResult? Function(UIStateModelEmpty<T> value)? empty,
    TResult? Function(UIStateModelLoading<T> value)? loading,
    TResult? Function(UIStateModelError<T> value)? error,
    TResult? Function(UIStateModelIdle<T> value)? idle,
  }) {
    final _that = this;
    switch (_that) {
      case UIStateModelSuccess() when success != null:
        return success(_that);
      case UIStateModelEmpty() when empty != null:
        return empty(_that);
      case UIStateModelLoading() when loading != null:
        return loading(_that);
      case UIStateModelError() when error != null:
        return error(_that);
      case UIStateModelIdle() when idle != null:
        return idle(_that);
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
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(T data)? success,
    TResult Function(String message)? empty,
    TResult Function()? loading,
    TResult Function(String message)? error,
    TResult Function()? idle,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case UIStateModelSuccess() when success != null:
        return success(_that.data);
      case UIStateModelEmpty() when empty != null:
        return empty(_that.message);
      case UIStateModelLoading() when loading != null:
        return loading();
      case UIStateModelError() when error != null:
        return error(_that.message);
      case UIStateModelIdle() when idle != null:
        return idle();
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
  TResult when<TResult extends Object?>({
    required TResult Function(T data) success,
    required TResult Function(String message) empty,
    required TResult Function() loading,
    required TResult Function(String message) error,
    required TResult Function() idle,
  }) {
    final _that = this;
    switch (_that) {
      case UIStateModelSuccess():
        return success(_that.data);
      case UIStateModelEmpty():
        return empty(_that.message);
      case UIStateModelLoading():
        return loading();
      case UIStateModelError():
        return error(_that.message);
      case UIStateModelIdle():
        return idle();
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
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(T data)? success,
    TResult? Function(String message)? empty,
    TResult? Function()? loading,
    TResult? Function(String message)? error,
    TResult? Function()? idle,
  }) {
    final _that = this;
    switch (_that) {
      case UIStateModelSuccess() when success != null:
        return success(_that.data);
      case UIStateModelEmpty() when empty != null:
        return empty(_that.message);
      case UIStateModelLoading() when loading != null:
        return loading();
      case UIStateModelError() when error != null:
        return error(_that.message);
      case UIStateModelIdle() when idle != null:
        return idle();
      case _:
        return null;
    }
  }
}

/// @nodoc

class UIStateModelSuccess<T> implements UIStateModel<T> {
  const UIStateModelSuccess({required this.data});

  final T data;

  /// Create a copy of UIStateModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $UIStateModelSuccessCopyWith<T, UIStateModelSuccess<T>> get copyWith =>
      _$UIStateModelSuccessCopyWithImpl<T, UIStateModelSuccess<T>>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is UIStateModelSuccess<T> &&
            const DeepCollectionEquality().equals(other.data, data));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(data));

  @override
  String toString() {
    return 'UIStateModel<$T>.success(data: $data)';
  }
}

/// @nodoc
abstract mixin class $UIStateModelSuccessCopyWith<T, $Res>
    implements $UIStateModelCopyWith<T, $Res> {
  factory $UIStateModelSuccessCopyWith(UIStateModelSuccess<T> value,
          $Res Function(UIStateModelSuccess<T>) _then) =
      _$UIStateModelSuccessCopyWithImpl;
  @useResult
  $Res call({T data});
}

/// @nodoc
class _$UIStateModelSuccessCopyWithImpl<T, $Res>
    implements $UIStateModelSuccessCopyWith<T, $Res> {
  _$UIStateModelSuccessCopyWithImpl(this._self, this._then);

  final UIStateModelSuccess<T> _self;
  final $Res Function(UIStateModelSuccess<T>) _then;

  /// Create a copy of UIStateModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? data = freezed,
  }) {
    return _then(UIStateModelSuccess<T>(
      data: freezed == data
          ? _self.data
          : data // ignore: cast_nullable_to_non_nullable
              as T,
    ));
  }
}

/// @nodoc

class UIStateModelEmpty<T> implements UIStateModel<T> {
  const UIStateModelEmpty(
      {this.message = 'Maaf, saat ini data kamu tidak tersedia'});

  @JsonKey()
  final String message;

  /// Create a copy of UIStateModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $UIStateModelEmptyCopyWith<T, UIStateModelEmpty<T>> get copyWith =>
      _$UIStateModelEmptyCopyWithImpl<T, UIStateModelEmpty<T>>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is UIStateModelEmpty<T> &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @override
  String toString() {
    return 'UIStateModel<$T>.empty(message: $message)';
  }
}

/// @nodoc
abstract mixin class $UIStateModelEmptyCopyWith<T, $Res>
    implements $UIStateModelCopyWith<T, $Res> {
  factory $UIStateModelEmptyCopyWith(UIStateModelEmpty<T> value,
          $Res Function(UIStateModelEmpty<T>) _then) =
      _$UIStateModelEmptyCopyWithImpl;
  @useResult
  $Res call({String message});
}

/// @nodoc
class _$UIStateModelEmptyCopyWithImpl<T, $Res>
    implements $UIStateModelEmptyCopyWith<T, $Res> {
  _$UIStateModelEmptyCopyWithImpl(this._self, this._then);

  final UIStateModelEmpty<T> _self;
  final $Res Function(UIStateModelEmpty<T>) _then;

  /// Create a copy of UIStateModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? message = null,
  }) {
    return _then(UIStateModelEmpty<T>(
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class UIStateModelLoading<T> implements UIStateModel<T> {
  const UIStateModelLoading();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is UIStateModelLoading<T>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'UIStateModel<$T>.loading()';
  }
}

/// @nodoc

class UIStateModelError<T> implements UIStateModel<T> {
  const UIStateModelError(
      {this.message = 'Terjadi Kesalahan, Silakan Coba Lagi'});

  @JsonKey()
  final String message;

  /// Create a copy of UIStateModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $UIStateModelErrorCopyWith<T, UIStateModelError<T>> get copyWith =>
      _$UIStateModelErrorCopyWithImpl<T, UIStateModelError<T>>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is UIStateModelError<T> &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @override
  String toString() {
    return 'UIStateModel<$T>.error(message: $message)';
  }
}

/// @nodoc
abstract mixin class $UIStateModelErrorCopyWith<T, $Res>
    implements $UIStateModelCopyWith<T, $Res> {
  factory $UIStateModelErrorCopyWith(UIStateModelError<T> value,
          $Res Function(UIStateModelError<T>) _then) =
      _$UIStateModelErrorCopyWithImpl;
  @useResult
  $Res call({String message});
}

/// @nodoc
class _$UIStateModelErrorCopyWithImpl<T, $Res>
    implements $UIStateModelErrorCopyWith<T, $Res> {
  _$UIStateModelErrorCopyWithImpl(this._self, this._then);

  final UIStateModelError<T> _self;
  final $Res Function(UIStateModelError<T>) _then;

  /// Create a copy of UIStateModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? message = null,
  }) {
    return _then(UIStateModelError<T>(
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class UIStateModelIdle<T> implements UIStateModel<T> {
  const UIStateModelIdle();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is UIStateModelIdle<T>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'UIStateModel<$T>.idle()';
  }
}

// dart format on
