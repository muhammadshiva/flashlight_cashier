// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_settings_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AppSettingsModel {
  @JsonKey(name: "storeName")
  String get storeName;
  @JsonKey(name: "storeAddress")
  String get storeAddress;
  @JsonKey(name: "storePhone")
  String get storePhone;
  @JsonKey(name: "storeEmail")
  String get storeEmail;
  @JsonKey(name: "taxRate")
  double get taxRate;
  @JsonKey(name: "autoCalculateTax")
  bool get autoCalculateTax;
  @JsonKey(name: "language")
  String get language;
  @JsonKey(name: "region")
  String get region;
  @JsonKey(name: "currencySymbol")
  String get currencySymbol;
  @JsonKey(name: "theme")
  String get theme;
  @JsonKey(name: "fontSize")
  double get fontSize;

  /// Create a copy of AppSettingsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AppSettingsModelCopyWith<AppSettingsModel> get copyWith =>
      _$AppSettingsModelCopyWithImpl<AppSettingsModel>(this as AppSettingsModel, _$identity);

  /// Serializes this AppSettingsModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AppSettingsModel &&
            (identical(other.storeName, storeName) || other.storeName == storeName) &&
            (identical(other.storeAddress, storeAddress) || other.storeAddress == storeAddress) &&
            (identical(other.storePhone, storePhone) || other.storePhone == storePhone) &&
            (identical(other.storeEmail, storeEmail) || other.storeEmail == storeEmail) &&
            (identical(other.taxRate, taxRate) || other.taxRate == taxRate) &&
            (identical(other.autoCalculateTax, autoCalculateTax) ||
                other.autoCalculateTax == autoCalculateTax) &&
            (identical(other.language, language) || other.language == language) &&
            (identical(other.region, region) || other.region == region) &&
            (identical(other.currencySymbol, currencySymbol) ||
                other.currencySymbol == currencySymbol) &&
            (identical(other.theme, theme) || other.theme == theme) &&
            (identical(other.fontSize, fontSize) || other.fontSize == fontSize));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, storeName, storeAddress, storePhone, storeEmail,
      taxRate, autoCalculateTax, language, region, currencySymbol, theme, fontSize);

  @override
  String toString() {
    return 'AppSettingsModel(storeName: $storeName, storeAddress: $storeAddress, storePhone: $storePhone, storeEmail: $storeEmail, taxRate: $taxRate, autoCalculateTax: $autoCalculateTax, language: $language, region: $region, currencySymbol: $currencySymbol, theme: $theme, fontSize: $fontSize)';
  }
}

/// @nodoc
abstract mixin class $AppSettingsModelCopyWith<$Res> {
  factory $AppSettingsModelCopyWith(AppSettingsModel value, $Res Function(AppSettingsModel) _then) =
      _$AppSettingsModelCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: "storeName") String storeName,
      @JsonKey(name: "storeAddress") String storeAddress,
      @JsonKey(name: "storePhone") String storePhone,
      @JsonKey(name: "storeEmail") String storeEmail,
      @JsonKey(name: "taxRate") double taxRate,
      @JsonKey(name: "autoCalculateTax") bool autoCalculateTax,
      @JsonKey(name: "language") String language,
      @JsonKey(name: "region") String region,
      @JsonKey(name: "currencySymbol") String currencySymbol,
      @JsonKey(name: "theme") String theme,
      @JsonKey(name: "fontSize") double fontSize});
}

/// @nodoc
class _$AppSettingsModelCopyWithImpl<$Res> implements $AppSettingsModelCopyWith<$Res> {
  _$AppSettingsModelCopyWithImpl(this._self, this._then);

  final AppSettingsModel _self;
  final $Res Function(AppSettingsModel) _then;

  /// Create a copy of AppSettingsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? storeName = null,
    Object? storeAddress = null,
    Object? storePhone = null,
    Object? storeEmail = null,
    Object? taxRate = null,
    Object? autoCalculateTax = null,
    Object? language = null,
    Object? region = null,
    Object? currencySymbol = null,
    Object? theme = null,
    Object? fontSize = null,
  }) {
    return _then(_self.copyWith(
      storeName: null == storeName
          ? _self.storeName
          : storeName // ignore: cast_nullable_to_non_nullable
              as String,
      storeAddress: null == storeAddress
          ? _self.storeAddress
          : storeAddress // ignore: cast_nullable_to_non_nullable
              as String,
      storePhone: null == storePhone
          ? _self.storePhone
          : storePhone // ignore: cast_nullable_to_non_nullable
              as String,
      storeEmail: null == storeEmail
          ? _self.storeEmail
          : storeEmail // ignore: cast_nullable_to_non_nullable
              as String,
      taxRate: null == taxRate
          ? _self.taxRate
          : taxRate // ignore: cast_nullable_to_non_nullable
              as double,
      autoCalculateTax: null == autoCalculateTax
          ? _self.autoCalculateTax
          : autoCalculateTax // ignore: cast_nullable_to_non_nullable
              as bool,
      language: null == language
          ? _self.language
          : language // ignore: cast_nullable_to_non_nullable
              as String,
      region: null == region
          ? _self.region
          : region // ignore: cast_nullable_to_non_nullable
              as String,
      currencySymbol: null == currencySymbol
          ? _self.currencySymbol
          : currencySymbol // ignore: cast_nullable_to_non_nullable
              as String,
      theme: null == theme
          ? _self.theme
          : theme // ignore: cast_nullable_to_non_nullable
              as String,
      fontSize: null == fontSize
          ? _self.fontSize
          : fontSize // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// Adds pattern-matching-related methods to [AppSettingsModel].
extension AppSettingsModelPatterns on AppSettingsModel {
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
    TResult Function(_AppSettingsModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AppSettingsModel() when $default != null:
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
    TResult Function(_AppSettingsModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AppSettingsModel():
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
    TResult? Function(_AppSettingsModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AppSettingsModel() when $default != null:
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
            @JsonKey(name: "storeName") String storeName,
            @JsonKey(name: "storeAddress") String storeAddress,
            @JsonKey(name: "storePhone") String storePhone,
            @JsonKey(name: "storeEmail") String storeEmail,
            @JsonKey(name: "taxRate") double taxRate,
            @JsonKey(name: "autoCalculateTax") bool autoCalculateTax,
            @JsonKey(name: "language") String language,
            @JsonKey(name: "region") String region,
            @JsonKey(name: "currencySymbol") String currencySymbol,
            @JsonKey(name: "theme") String theme,
            @JsonKey(name: "fontSize") double fontSize)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AppSettingsModel() when $default != null:
        return $default(
            _that.storeName,
            _that.storeAddress,
            _that.storePhone,
            _that.storeEmail,
            _that.taxRate,
            _that.autoCalculateTax,
            _that.language,
            _that.region,
            _that.currencySymbol,
            _that.theme,
            _that.fontSize);
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
            @JsonKey(name: "storeName") String storeName,
            @JsonKey(name: "storeAddress") String storeAddress,
            @JsonKey(name: "storePhone") String storePhone,
            @JsonKey(name: "storeEmail") String storeEmail,
            @JsonKey(name: "taxRate") double taxRate,
            @JsonKey(name: "autoCalculateTax") bool autoCalculateTax,
            @JsonKey(name: "language") String language,
            @JsonKey(name: "region") String region,
            @JsonKey(name: "currencySymbol") String currencySymbol,
            @JsonKey(name: "theme") String theme,
            @JsonKey(name: "fontSize") double fontSize)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AppSettingsModel():
        return $default(
            _that.storeName,
            _that.storeAddress,
            _that.storePhone,
            _that.storeEmail,
            _that.taxRate,
            _that.autoCalculateTax,
            _that.language,
            _that.region,
            _that.currencySymbol,
            _that.theme,
            _that.fontSize);
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
            @JsonKey(name: "storeName") String storeName,
            @JsonKey(name: "storeAddress") String storeAddress,
            @JsonKey(name: "storePhone") String storePhone,
            @JsonKey(name: "storeEmail") String storeEmail,
            @JsonKey(name: "taxRate") double taxRate,
            @JsonKey(name: "autoCalculateTax") bool autoCalculateTax,
            @JsonKey(name: "language") String language,
            @JsonKey(name: "region") String region,
            @JsonKey(name: "currencySymbol") String currencySymbol,
            @JsonKey(name: "theme") String theme,
            @JsonKey(name: "fontSize") double fontSize)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AppSettingsModel() when $default != null:
        return $default(
            _that.storeName,
            _that.storeAddress,
            _that.storePhone,
            _that.storeEmail,
            _that.taxRate,
            _that.autoCalculateTax,
            _that.language,
            _that.region,
            _that.currencySymbol,
            _that.theme,
            _that.fontSize);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _AppSettingsModel implements AppSettingsModel {
  const _AppSettingsModel(
      {@JsonKey(name: "storeName") required this.storeName,
      @JsonKey(name: "storeAddress") required this.storeAddress,
      @JsonKey(name: "storePhone") required this.storePhone,
      @JsonKey(name: "storeEmail") required this.storeEmail,
      @JsonKey(name: "taxRate") required this.taxRate,
      @JsonKey(name: "autoCalculateTax") required this.autoCalculateTax,
      @JsonKey(name: "language") required this.language,
      @JsonKey(name: "region") required this.region,
      @JsonKey(name: "currencySymbol") required this.currencySymbol,
      @JsonKey(name: "theme") required this.theme,
      @JsonKey(name: "fontSize") required this.fontSize});
  factory _AppSettingsModel.fromJson(Map<String, dynamic> json) => _$AppSettingsModelFromJson(json);

  @override
  @JsonKey(name: "storeName")
  final String storeName;
  @override
  @JsonKey(name: "storeAddress")
  final String storeAddress;
  @override
  @JsonKey(name: "storePhone")
  final String storePhone;
  @override
  @JsonKey(name: "storeEmail")
  final String storeEmail;
  @override
  @JsonKey(name: "taxRate")
  final double taxRate;
  @override
  @JsonKey(name: "autoCalculateTax")
  final bool autoCalculateTax;
  @override
  @JsonKey(name: "language")
  final String language;
  @override
  @JsonKey(name: "region")
  final String region;
  @override
  @JsonKey(name: "currencySymbol")
  final String currencySymbol;
  @override
  @JsonKey(name: "theme")
  final String theme;
  @override
  @JsonKey(name: "fontSize")
  final double fontSize;

  /// Create a copy of AppSettingsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AppSettingsModelCopyWith<_AppSettingsModel> get copyWith =>
      __$AppSettingsModelCopyWithImpl<_AppSettingsModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$AppSettingsModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AppSettingsModel &&
            (identical(other.storeName, storeName) || other.storeName == storeName) &&
            (identical(other.storeAddress, storeAddress) || other.storeAddress == storeAddress) &&
            (identical(other.storePhone, storePhone) || other.storePhone == storePhone) &&
            (identical(other.storeEmail, storeEmail) || other.storeEmail == storeEmail) &&
            (identical(other.taxRate, taxRate) || other.taxRate == taxRate) &&
            (identical(other.autoCalculateTax, autoCalculateTax) ||
                other.autoCalculateTax == autoCalculateTax) &&
            (identical(other.language, language) || other.language == language) &&
            (identical(other.region, region) || other.region == region) &&
            (identical(other.currencySymbol, currencySymbol) ||
                other.currencySymbol == currencySymbol) &&
            (identical(other.theme, theme) || other.theme == theme) &&
            (identical(other.fontSize, fontSize) || other.fontSize == fontSize));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, storeName, storeAddress, storePhone, storeEmail,
      taxRate, autoCalculateTax, language, region, currencySymbol, theme, fontSize);

  @override
  String toString() {
    return 'AppSettingsModel(storeName: $storeName, storeAddress: $storeAddress, storePhone: $storePhone, storeEmail: $storeEmail, taxRate: $taxRate, autoCalculateTax: $autoCalculateTax, language: $language, region: $region, currencySymbol: $currencySymbol, theme: $theme, fontSize: $fontSize)';
  }

  @override
  AppSettings toEntity() {
    throw UnimplementedError();
  }
}

/// @nodoc
abstract mixin class _$AppSettingsModelCopyWith<$Res> implements $AppSettingsModelCopyWith<$Res> {
  factory _$AppSettingsModelCopyWith(
          _AppSettingsModel value, $Res Function(_AppSettingsModel) _then) =
      __$AppSettingsModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "storeName") String storeName,
      @JsonKey(name: "storeAddress") String storeAddress,
      @JsonKey(name: "storePhone") String storePhone,
      @JsonKey(name: "storeEmail") String storeEmail,
      @JsonKey(name: "taxRate") double taxRate,
      @JsonKey(name: "autoCalculateTax") bool autoCalculateTax,
      @JsonKey(name: "language") String language,
      @JsonKey(name: "region") String region,
      @JsonKey(name: "currencySymbol") String currencySymbol,
      @JsonKey(name: "theme") String theme,
      @JsonKey(name: "fontSize") double fontSize});
}

/// @nodoc
class __$AppSettingsModelCopyWithImpl<$Res> implements _$AppSettingsModelCopyWith<$Res> {
  __$AppSettingsModelCopyWithImpl(this._self, this._then);

  final _AppSettingsModel _self;
  final $Res Function(_AppSettingsModel) _then;

  /// Create a copy of AppSettingsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? storeName = null,
    Object? storeAddress = null,
    Object? storePhone = null,
    Object? storeEmail = null,
    Object? taxRate = null,
    Object? autoCalculateTax = null,
    Object? language = null,
    Object? region = null,
    Object? currencySymbol = null,
    Object? theme = null,
    Object? fontSize = null,
  }) {
    return _then(_AppSettingsModel(
      storeName: null == storeName
          ? _self.storeName
          : storeName // ignore: cast_nullable_to_non_nullable
              as String,
      storeAddress: null == storeAddress
          ? _self.storeAddress
          : storeAddress // ignore: cast_nullable_to_non_nullable
              as String,
      storePhone: null == storePhone
          ? _self.storePhone
          : storePhone // ignore: cast_nullable_to_non_nullable
              as String,
      storeEmail: null == storeEmail
          ? _self.storeEmail
          : storeEmail // ignore: cast_nullable_to_non_nullable
              as String,
      taxRate: null == taxRate
          ? _self.taxRate
          : taxRate // ignore: cast_nullable_to_non_nullable
              as double,
      autoCalculateTax: null == autoCalculateTax
          ? _self.autoCalculateTax
          : autoCalculateTax // ignore: cast_nullable_to_non_nullable
              as bool,
      language: null == language
          ? _self.language
          : language // ignore: cast_nullable_to_non_nullable
              as String,
      region: null == region
          ? _self.region
          : region // ignore: cast_nullable_to_non_nullable
              as String,
      currencySymbol: null == currencySymbol
          ? _self.currencySymbol
          : currencySymbol // ignore: cast_nullable_to_non_nullable
              as String,
      theme: null == theme
          ? _self.theme
          : theme // ignore: cast_nullable_to_non_nullable
              as String,
      fontSize: null == fontSize
          ? _self.fontSize
          : fontSize // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

// dart format on
