// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'service_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ServiceModel {
  @JsonKey(name: "id")
  String get id;
  @JsonKey(name: "name")
  String get name;
  @JsonKey(name: "description")
  String get description;
  @JsonKey(name: "price")
  int get price;
  @JsonKey(name: "imageUrl")
  String get imageUrl;
  @JsonKey(name: "isDefault")
  bool get isDefault;
  @JsonKey(name: "isFavorite")
  bool get isFavorite;
  @JsonKey(name: "type")
  String get type;
  @JsonKey(name: "isActive")
  bool get isActive;

  /// Create a copy of ServiceModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ServiceModelCopyWith<ServiceModel> get copyWith =>
      _$ServiceModelCopyWithImpl<ServiceModel>(
          this as ServiceModel, _$identity);

  /// Serializes this ServiceModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ServiceModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.isDefault, isDefault) ||
                other.isDefault == isDefault) &&
            (identical(other.isFavorite, isFavorite) ||
                other.isFavorite == isFavorite) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, description, price,
      imageUrl, isDefault, isFavorite, type, isActive);

  @override
  String toString() {
    return 'ServiceModel(id: $id, name: $name, description: $description, price: $price, imageUrl: $imageUrl, isDefault: $isDefault, isFavorite: $isFavorite, type: $type, isActive: $isActive)';
  }
}

/// @nodoc
abstract mixin class $ServiceModelCopyWith<$Res> {
  factory $ServiceModelCopyWith(
          ServiceModel value, $Res Function(ServiceModel) _then) =
      _$ServiceModelCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: "id") String id,
      @JsonKey(name: "name") String name,
      @JsonKey(name: "description") String description,
      @JsonKey(name: "price") int price,
      @JsonKey(name: "imageUrl") String imageUrl,
      @JsonKey(name: "isDefault") bool isDefault,
      @JsonKey(name: "isFavorite") bool isFavorite,
      @JsonKey(name: "type") String type,
      @JsonKey(name: "isActive") bool isActive});
}

/// @nodoc
class _$ServiceModelCopyWithImpl<$Res> implements $ServiceModelCopyWith<$Res> {
  _$ServiceModelCopyWithImpl(this._self, this._then);

  final ServiceModel _self;
  final $Res Function(ServiceModel) _then;

  /// Create a copy of ServiceModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? price = null,
    Object? imageUrl = null,
    Object? isDefault = null,
    Object? isFavorite = null,
    Object? type = null,
    Object? isActive = null,
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
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _self.price
          : price // ignore: cast_nullable_to_non_nullable
              as int,
      imageUrl: null == imageUrl
          ? _self.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      isDefault: null == isDefault
          ? _self.isDefault
          : isDefault // ignore: cast_nullable_to_non_nullable
              as bool,
      isFavorite: null == isFavorite
          ? _self.isFavorite
          : isFavorite // ignore: cast_nullable_to_non_nullable
              as bool,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      isActive: null == isActive
          ? _self.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// Adds pattern-matching-related methods to [ServiceModel].
extension ServiceModelPatterns on ServiceModel {
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
    TResult Function(_ServiceModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ServiceModel() when $default != null:
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
    TResult Function(_ServiceModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ServiceModel():
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
    TResult? Function(_ServiceModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ServiceModel() when $default != null:
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
            @JsonKey(name: "description") String description,
            @JsonKey(name: "price") int price,
            @JsonKey(name: "imageUrl") String imageUrl,
            @JsonKey(name: "isDefault") bool isDefault,
            @JsonKey(name: "isFavorite") bool isFavorite,
            @JsonKey(name: "type") String type,
            @JsonKey(name: "isActive") bool isActive)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ServiceModel() when $default != null:
        return $default(
            _that.id,
            _that.name,
            _that.description,
            _that.price,
            _that.imageUrl,
            _that.isDefault,
            _that.isFavorite,
            _that.type,
            _that.isActive);
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
            @JsonKey(name: "description") String description,
            @JsonKey(name: "price") int price,
            @JsonKey(name: "imageUrl") String imageUrl,
            @JsonKey(name: "isDefault") bool isDefault,
            @JsonKey(name: "isFavorite") bool isFavorite,
            @JsonKey(name: "type") String type,
            @JsonKey(name: "isActive") bool isActive)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ServiceModel():
        return $default(
            _that.id,
            _that.name,
            _that.description,
            _that.price,
            _that.imageUrl,
            _that.isDefault,
            _that.isFavorite,
            _that.type,
            _that.isActive);
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
            @JsonKey(name: "description") String description,
            @JsonKey(name: "price") int price,
            @JsonKey(name: "imageUrl") String imageUrl,
            @JsonKey(name: "isDefault") bool isDefault,
            @JsonKey(name: "isFavorite") bool isFavorite,
            @JsonKey(name: "type") String type,
            @JsonKey(name: "isActive") bool isActive)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ServiceModel() when $default != null:
        return $default(
            _that.id,
            _that.name,
            _that.description,
            _that.price,
            _that.imageUrl,
            _that.isDefault,
            _that.isFavorite,
            _that.type,
            _that.isActive);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ServiceModel extends ServiceModel {
  const _ServiceModel(
      {@JsonKey(name: "id") required this.id,
      @JsonKey(name: "name") required this.name,
      @JsonKey(name: "description") required this.description,
      @JsonKey(name: "price") required this.price,
      @JsonKey(name: "imageUrl") required this.imageUrl,
      @JsonKey(name: "isDefault") required this.isDefault,
      @JsonKey(name: "isFavorite") required this.isFavorite,
      @JsonKey(name: "type") required this.type,
      @JsonKey(name: "isActive") required this.isActive})
      : super._();
  factory _ServiceModel.fromJson(Map<String, dynamic> json) =>
      _$ServiceModelFromJson(json);

  @override
  @JsonKey(name: "id")
  final String id;
  @override
  @JsonKey(name: "name")
  final String name;
  @override
  @JsonKey(name: "description")
  final String description;
  @override
  @JsonKey(name: "price")
  final int price;
  @override
  @JsonKey(name: "imageUrl")
  final String imageUrl;
  @override
  @JsonKey(name: "isDefault")
  final bool isDefault;
  @override
  @JsonKey(name: "isFavorite")
  final bool isFavorite;
  @override
  @JsonKey(name: "type")
  final String type;
  @override
  @JsonKey(name: "isActive")
  final bool isActive;

  /// Create a copy of ServiceModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ServiceModelCopyWith<_ServiceModel> get copyWith =>
      __$ServiceModelCopyWithImpl<_ServiceModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ServiceModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ServiceModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.isDefault, isDefault) ||
                other.isDefault == isDefault) &&
            (identical(other.isFavorite, isFavorite) ||
                other.isFavorite == isFavorite) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, description, price,
      imageUrl, isDefault, isFavorite, type, isActive);

  @override
  String toString() {
    return 'ServiceModel(id: $id, name: $name, description: $description, price: $price, imageUrl: $imageUrl, isDefault: $isDefault, isFavorite: $isFavorite, type: $type, isActive: $isActive)';
  }
}

/// @nodoc
abstract mixin class _$ServiceModelCopyWith<$Res>
    implements $ServiceModelCopyWith<$Res> {
  factory _$ServiceModelCopyWith(
          _ServiceModel value, $Res Function(_ServiceModel) _then) =
      __$ServiceModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "id") String id,
      @JsonKey(name: "name") String name,
      @JsonKey(name: "description") String description,
      @JsonKey(name: "price") int price,
      @JsonKey(name: "imageUrl") String imageUrl,
      @JsonKey(name: "isDefault") bool isDefault,
      @JsonKey(name: "isFavorite") bool isFavorite,
      @JsonKey(name: "type") String type,
      @JsonKey(name: "isActive") bool isActive});
}

/// @nodoc
class __$ServiceModelCopyWithImpl<$Res>
    implements _$ServiceModelCopyWith<$Res> {
  __$ServiceModelCopyWithImpl(this._self, this._then);

  final _ServiceModel _self;
  final $Res Function(_ServiceModel) _then;

  /// Create a copy of ServiceModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? price = null,
    Object? imageUrl = null,
    Object? isDefault = null,
    Object? isFavorite = null,
    Object? type = null,
    Object? isActive = null,
  }) {
    return _then(_ServiceModel(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _self.price
          : price // ignore: cast_nullable_to_non_nullable
              as int,
      imageUrl: null == imageUrl
          ? _self.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      isDefault: null == isDefault
          ? _self.isDefault
          : isDefault // ignore: cast_nullable_to_non_nullable
              as bool,
      isFavorite: null == isFavorite
          ? _self.isFavorite
          : isFavorite // ignore: cast_nullable_to_non_nullable
              as bool,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      isActive: null == isActive
          ? _self.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
