// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'settings_ui_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SettingsUIState {
  String get selectedMenu;
  bool get isDialogExpanded;
  String? get searchQuery;
  bool get isDirty;

  /// Create a copy of SettingsUIState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SettingsUIStateCopyWith<SettingsUIState> get copyWith =>
      _$SettingsUIStateCopyWithImpl<SettingsUIState>(
          this as SettingsUIState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SettingsUIState &&
            (identical(other.selectedMenu, selectedMenu) ||
                other.selectedMenu == selectedMenu) &&
            (identical(other.isDialogExpanded, isDialogExpanded) ||
                other.isDialogExpanded == isDialogExpanded) &&
            (identical(other.searchQuery, searchQuery) ||
                other.searchQuery == searchQuery) &&
            (identical(other.isDirty, isDirty) || other.isDirty == isDirty));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, selectedMenu, isDialogExpanded, searchQuery, isDirty);

  @override
  String toString() {
    return 'SettingsUIState(selectedMenu: $selectedMenu, isDialogExpanded: $isDialogExpanded, searchQuery: $searchQuery, isDirty: $isDirty)';
  }
}

/// @nodoc
abstract mixin class $SettingsUIStateCopyWith<$Res> {
  factory $SettingsUIStateCopyWith(
          SettingsUIState value, $Res Function(SettingsUIState) _then) =
      _$SettingsUIStateCopyWithImpl;
  @useResult
  $Res call(
      {String selectedMenu,
      bool isDialogExpanded,
      String? searchQuery,
      bool isDirty});
}

/// @nodoc
class _$SettingsUIStateCopyWithImpl<$Res>
    implements $SettingsUIStateCopyWith<$Res> {
  _$SettingsUIStateCopyWithImpl(this._self, this._then);

  final SettingsUIState _self;
  final $Res Function(SettingsUIState) _then;

  /// Create a copy of SettingsUIState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedMenu = null,
    Object? isDialogExpanded = null,
    Object? searchQuery = freezed,
    Object? isDirty = null,
  }) {
    return _then(_self.copyWith(
      selectedMenu: null == selectedMenu
          ? _self.selectedMenu
          : selectedMenu // ignore: cast_nullable_to_non_nullable
              as String,
      isDialogExpanded: null == isDialogExpanded
          ? _self.isDialogExpanded
          : isDialogExpanded // ignore: cast_nullable_to_non_nullable
              as bool,
      searchQuery: freezed == searchQuery
          ? _self.searchQuery
          : searchQuery // ignore: cast_nullable_to_non_nullable
              as String?,
      isDirty: null == isDirty
          ? _self.isDirty
          : isDirty // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// Adds pattern-matching-related methods to [SettingsUIState].
extension SettingsUIStatePatterns on SettingsUIState {
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
    TResult Function(_SettingsUIState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SettingsUIState() when $default != null:
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
    TResult Function(_SettingsUIState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SettingsUIState():
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
    TResult? Function(_SettingsUIState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SettingsUIState() when $default != null:
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
    TResult Function(String selectedMenu, bool isDialogExpanded,
            String? searchQuery, bool isDirty)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SettingsUIState() when $default != null:
        return $default(_that.selectedMenu, _that.isDialogExpanded,
            _that.searchQuery, _that.isDirty);
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
    TResult Function(String selectedMenu, bool isDialogExpanded,
            String? searchQuery, bool isDirty)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SettingsUIState():
        return $default(_that.selectedMenu, _that.isDialogExpanded,
            _that.searchQuery, _that.isDirty);
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
    TResult? Function(String selectedMenu, bool isDialogExpanded,
            String? searchQuery, bool isDirty)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SettingsUIState() when $default != null:
        return $default(_that.selectedMenu, _that.isDialogExpanded,
            _that.searchQuery, _that.isDirty);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _SettingsUIState implements SettingsUIState {
  const _SettingsUIState(
      {this.selectedMenu = 'store_info',
      this.isDialogExpanded = false,
      this.searchQuery,
      this.isDirty = false});

  @override
  @JsonKey()
  final String selectedMenu;
  @override
  @JsonKey()
  final bool isDialogExpanded;
  @override
  final String? searchQuery;
  @override
  @JsonKey()
  final bool isDirty;

  /// Create a copy of SettingsUIState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SettingsUIStateCopyWith<_SettingsUIState> get copyWith =>
      __$SettingsUIStateCopyWithImpl<_SettingsUIState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SettingsUIState &&
            (identical(other.selectedMenu, selectedMenu) ||
                other.selectedMenu == selectedMenu) &&
            (identical(other.isDialogExpanded, isDialogExpanded) ||
                other.isDialogExpanded == isDialogExpanded) &&
            (identical(other.searchQuery, searchQuery) ||
                other.searchQuery == searchQuery) &&
            (identical(other.isDirty, isDirty) || other.isDirty == isDirty));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, selectedMenu, isDialogExpanded, searchQuery, isDirty);

  @override
  String toString() {
    return 'SettingsUIState(selectedMenu: $selectedMenu, isDialogExpanded: $isDialogExpanded, searchQuery: $searchQuery, isDirty: $isDirty)';
  }
}

/// @nodoc
abstract mixin class _$SettingsUIStateCopyWith<$Res>
    implements $SettingsUIStateCopyWith<$Res> {
  factory _$SettingsUIStateCopyWith(
          _SettingsUIState value, $Res Function(_SettingsUIState) _then) =
      __$SettingsUIStateCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String selectedMenu,
      bool isDialogExpanded,
      String? searchQuery,
      bool isDirty});
}

/// @nodoc
class __$SettingsUIStateCopyWithImpl<$Res>
    implements _$SettingsUIStateCopyWith<$Res> {
  __$SettingsUIStateCopyWithImpl(this._self, this._then);

  final _SettingsUIState _self;
  final $Res Function(_SettingsUIState) _then;

  /// Create a copy of SettingsUIState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? selectedMenu = null,
    Object? isDialogExpanded = null,
    Object? searchQuery = freezed,
    Object? isDirty = null,
  }) {
    return _then(_SettingsUIState(
      selectedMenu: null == selectedMenu
          ? _self.selectedMenu
          : selectedMenu // ignore: cast_nullable_to_non_nullable
              as String,
      isDialogExpanded: null == isDialogExpanded
          ? _self.isDialogExpanded
          : isDialogExpanded // ignore: cast_nullable_to_non_nullable
              as bool,
      searchQuery: freezed == searchQuery
          ? _self.searchQuery
          : searchQuery // ignore: cast_nullable_to_non_nullable
              as String?,
      isDirty: null == isDirty
          ? _self.isDirty
          : isDirty // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
