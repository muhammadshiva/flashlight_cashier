// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'receipt_settings_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ReceiptSettingsModel {
  @JsonKey(name: "showLogo")
  bool get showLogo;
  @JsonKey(name: "showTaxDetails")
  bool get showTaxDetails;
  @JsonKey(name: "showDiscount")
  bool get showDiscount;
  @JsonKey(name: "showPaymentMethod")
  bool get showPaymentMethod;
  @JsonKey(name: "showFooterMessage")
  bool get showFooterMessage;
  @JsonKey(name: "footerMessage")
  String get footerMessage;
  @JsonKey(name: "receiptHeader")
  String get receiptHeader;

  /// Create a copy of ReceiptSettingsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ReceiptSettingsModelCopyWith<ReceiptSettingsModel> get copyWith =>
      _$ReceiptSettingsModelCopyWithImpl<ReceiptSettingsModel>(
          this as ReceiptSettingsModel, _$identity);

  /// Serializes this ReceiptSettingsModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ReceiptSettingsModel &&
            (identical(other.showLogo, showLogo) || other.showLogo == showLogo) &&
            (identical(other.showTaxDetails, showTaxDetails) ||
                other.showTaxDetails == showTaxDetails) &&
            (identical(other.showDiscount, showDiscount) || other.showDiscount == showDiscount) &&
            (identical(other.showPaymentMethod, showPaymentMethod) ||
                other.showPaymentMethod == showPaymentMethod) &&
            (identical(other.showFooterMessage, showFooterMessage) ||
                other.showFooterMessage == showFooterMessage) &&
            (identical(other.footerMessage, footerMessage) ||
                other.footerMessage == footerMessage) &&
            (identical(other.receiptHeader, receiptHeader) ||
                other.receiptHeader == receiptHeader));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, showLogo, showTaxDetails, showDiscount,
      showPaymentMethod, showFooterMessage, footerMessage, receiptHeader);

  @override
  String toString() {
    return 'ReceiptSettingsModel(showLogo: $showLogo, showTaxDetails: $showTaxDetails, showDiscount: $showDiscount, showPaymentMethod: $showPaymentMethod, showFooterMessage: $showFooterMessage, footerMessage: $footerMessage, receiptHeader: $receiptHeader)';
  }
}

/// @nodoc
abstract mixin class $ReceiptSettingsModelCopyWith<$Res> {
  factory $ReceiptSettingsModelCopyWith(
          ReceiptSettingsModel value, $Res Function(ReceiptSettingsModel) _then) =
      _$ReceiptSettingsModelCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: "showLogo") bool showLogo,
      @JsonKey(name: "showTaxDetails") bool showTaxDetails,
      @JsonKey(name: "showDiscount") bool showDiscount,
      @JsonKey(name: "showPaymentMethod") bool showPaymentMethod,
      @JsonKey(name: "showFooterMessage") bool showFooterMessage,
      @JsonKey(name: "footerMessage") String footerMessage,
      @JsonKey(name: "receiptHeader") String receiptHeader});
}

/// @nodoc
class _$ReceiptSettingsModelCopyWithImpl<$Res> implements $ReceiptSettingsModelCopyWith<$Res> {
  _$ReceiptSettingsModelCopyWithImpl(this._self, this._then);

  final ReceiptSettingsModel _self;
  final $Res Function(ReceiptSettingsModel) _then;

  /// Create a copy of ReceiptSettingsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? showLogo = null,
    Object? showTaxDetails = null,
    Object? showDiscount = null,
    Object? showPaymentMethod = null,
    Object? showFooterMessage = null,
    Object? footerMessage = null,
    Object? receiptHeader = null,
  }) {
    return _then(_self.copyWith(
      showLogo: null == showLogo
          ? _self.showLogo
          : showLogo // ignore: cast_nullable_to_non_nullable
              as bool,
      showTaxDetails: null == showTaxDetails
          ? _self.showTaxDetails
          : showTaxDetails // ignore: cast_nullable_to_non_nullable
              as bool,
      showDiscount: null == showDiscount
          ? _self.showDiscount
          : showDiscount // ignore: cast_nullable_to_non_nullable
              as bool,
      showPaymentMethod: null == showPaymentMethod
          ? _self.showPaymentMethod
          : showPaymentMethod // ignore: cast_nullable_to_non_nullable
              as bool,
      showFooterMessage: null == showFooterMessage
          ? _self.showFooterMessage
          : showFooterMessage // ignore: cast_nullable_to_non_nullable
              as bool,
      footerMessage: null == footerMessage
          ? _self.footerMessage
          : footerMessage // ignore: cast_nullable_to_non_nullable
              as String,
      receiptHeader: null == receiptHeader
          ? _self.receiptHeader
          : receiptHeader // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [ReceiptSettingsModel].
extension ReceiptSettingsModelPatterns on ReceiptSettingsModel {
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
    TResult Function(_ReceiptSettingsModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ReceiptSettingsModel() when $default != null:
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
    TResult Function(_ReceiptSettingsModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ReceiptSettingsModel():
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
    TResult? Function(_ReceiptSettingsModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ReceiptSettingsModel() when $default != null:
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
            @JsonKey(name: "showLogo") bool showLogo,
            @JsonKey(name: "showTaxDetails") bool showTaxDetails,
            @JsonKey(name: "showDiscount") bool showDiscount,
            @JsonKey(name: "showPaymentMethod") bool showPaymentMethod,
            @JsonKey(name: "showFooterMessage") bool showFooterMessage,
            @JsonKey(name: "footerMessage") String footerMessage,
            @JsonKey(name: "receiptHeader") String receiptHeader)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ReceiptSettingsModel() when $default != null:
        return $default(
            _that.showLogo,
            _that.showTaxDetails,
            _that.showDiscount,
            _that.showPaymentMethod,
            _that.showFooterMessage,
            _that.footerMessage,
            _that.receiptHeader);
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
            @JsonKey(name: "showLogo") bool showLogo,
            @JsonKey(name: "showTaxDetails") bool showTaxDetails,
            @JsonKey(name: "showDiscount") bool showDiscount,
            @JsonKey(name: "showPaymentMethod") bool showPaymentMethod,
            @JsonKey(name: "showFooterMessage") bool showFooterMessage,
            @JsonKey(name: "footerMessage") String footerMessage,
            @JsonKey(name: "receiptHeader") String receiptHeader)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ReceiptSettingsModel():
        return $default(
            _that.showLogo,
            _that.showTaxDetails,
            _that.showDiscount,
            _that.showPaymentMethod,
            _that.showFooterMessage,
            _that.footerMessage,
            _that.receiptHeader);
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
            @JsonKey(name: "showLogo") bool showLogo,
            @JsonKey(name: "showTaxDetails") bool showTaxDetails,
            @JsonKey(name: "showDiscount") bool showDiscount,
            @JsonKey(name: "showPaymentMethod") bool showPaymentMethod,
            @JsonKey(name: "showFooterMessage") bool showFooterMessage,
            @JsonKey(name: "footerMessage") String footerMessage,
            @JsonKey(name: "receiptHeader") String receiptHeader)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ReceiptSettingsModel() when $default != null:
        return $default(
            _that.showLogo,
            _that.showTaxDetails,
            _that.showDiscount,
            _that.showPaymentMethod,
            _that.showFooterMessage,
            _that.footerMessage,
            _that.receiptHeader);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ReceiptSettingsModel implements ReceiptSettingsModel {
  const _ReceiptSettingsModel(
      {@JsonKey(name: "showLogo") required this.showLogo,
      @JsonKey(name: "showTaxDetails") required this.showTaxDetails,
      @JsonKey(name: "showDiscount") required this.showDiscount,
      @JsonKey(name: "showPaymentMethod") required this.showPaymentMethod,
      @JsonKey(name: "showFooterMessage") required this.showFooterMessage,
      @JsonKey(name: "footerMessage") required this.footerMessage,
      @JsonKey(name: "receiptHeader") required this.receiptHeader});
  factory _ReceiptSettingsModel.fromJson(Map<String, dynamic> json) =>
      _$ReceiptSettingsModelFromJson(json);

  @override
  @JsonKey(name: "showLogo")
  final bool showLogo;
  @override
  @JsonKey(name: "showTaxDetails")
  final bool showTaxDetails;
  @override
  @JsonKey(name: "showDiscount")
  final bool showDiscount;
  @override
  @JsonKey(name: "showPaymentMethod")
  final bool showPaymentMethod;
  @override
  @JsonKey(name: "showFooterMessage")
  final bool showFooterMessage;
  @override
  @JsonKey(name: "footerMessage")
  final String footerMessage;
  @override
  @JsonKey(name: "receiptHeader")
  final String receiptHeader;

  /// Create a copy of ReceiptSettingsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ReceiptSettingsModelCopyWith<_ReceiptSettingsModel> get copyWith =>
      __$ReceiptSettingsModelCopyWithImpl<_ReceiptSettingsModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ReceiptSettingsModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ReceiptSettingsModel &&
            (identical(other.showLogo, showLogo) || other.showLogo == showLogo) &&
            (identical(other.showTaxDetails, showTaxDetails) ||
                other.showTaxDetails == showTaxDetails) &&
            (identical(other.showDiscount, showDiscount) || other.showDiscount == showDiscount) &&
            (identical(other.showPaymentMethod, showPaymentMethod) ||
                other.showPaymentMethod == showPaymentMethod) &&
            (identical(other.showFooterMessage, showFooterMessage) ||
                other.showFooterMessage == showFooterMessage) &&
            (identical(other.footerMessage, footerMessage) ||
                other.footerMessage == footerMessage) &&
            (identical(other.receiptHeader, receiptHeader) ||
                other.receiptHeader == receiptHeader));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, showLogo, showTaxDetails, showDiscount,
      showPaymentMethod, showFooterMessage, footerMessage, receiptHeader);

  @override
  String toString() {
    return 'ReceiptSettingsModel(showLogo: $showLogo, showTaxDetails: $showTaxDetails, showDiscount: $showDiscount, showPaymentMethod: $showPaymentMethod, showFooterMessage: $showFooterMessage, footerMessage: $footerMessage, receiptHeader: $receiptHeader)';
  }

  @override
  ReceiptSettings toEntity() {
    // TODO: implement toEntity
    throw UnimplementedError();
  }
}

/// @nodoc
abstract mixin class _$ReceiptSettingsModelCopyWith<$Res>
    implements $ReceiptSettingsModelCopyWith<$Res> {
  factory _$ReceiptSettingsModelCopyWith(
          _ReceiptSettingsModel value, $Res Function(_ReceiptSettingsModel) _then) =
      __$ReceiptSettingsModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "showLogo") bool showLogo,
      @JsonKey(name: "showTaxDetails") bool showTaxDetails,
      @JsonKey(name: "showDiscount") bool showDiscount,
      @JsonKey(name: "showPaymentMethod") bool showPaymentMethod,
      @JsonKey(name: "showFooterMessage") bool showFooterMessage,
      @JsonKey(name: "footerMessage") String footerMessage,
      @JsonKey(name: "receiptHeader") String receiptHeader});
}

/// @nodoc
class __$ReceiptSettingsModelCopyWithImpl<$Res> implements _$ReceiptSettingsModelCopyWith<$Res> {
  __$ReceiptSettingsModelCopyWithImpl(this._self, this._then);

  final _ReceiptSettingsModel _self;
  final $Res Function(_ReceiptSettingsModel) _then;

  /// Create a copy of ReceiptSettingsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? showLogo = null,
    Object? showTaxDetails = null,
    Object? showDiscount = null,
    Object? showPaymentMethod = null,
    Object? showFooterMessage = null,
    Object? footerMessage = null,
    Object? receiptHeader = null,
  }) {
    return _then(_ReceiptSettingsModel(
      showLogo: null == showLogo
          ? _self.showLogo
          : showLogo // ignore: cast_nullable_to_non_nullable
              as bool,
      showTaxDetails: null == showTaxDetails
          ? _self.showTaxDetails
          : showTaxDetails // ignore: cast_nullable_to_non_nullable
              as bool,
      showDiscount: null == showDiscount
          ? _self.showDiscount
          : showDiscount // ignore: cast_nullable_to_non_nullable
              as bool,
      showPaymentMethod: null == showPaymentMethod
          ? _self.showPaymentMethod
          : showPaymentMethod // ignore: cast_nullable_to_non_nullable
              as bool,
      showFooterMessage: null == showFooterMessage
          ? _self.showFooterMessage
          : showFooterMessage // ignore: cast_nullable_to_non_nullable
              as bool,
      footerMessage: null == footerMessage
          ? _self.footerMessage
          : footerMessage // ignore: cast_nullable_to_non_nullable
              as String,
      receiptHeader: null == receiptHeader
          ? _self.receiptHeader
          : receiptHeader // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
