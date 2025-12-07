// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ProductModel {
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
  @JsonKey(name: "type")
  String get type;
  @JsonKey(name: "stock")
  int get stock;
  @JsonKey(name: "isAvailable")
  bool get isAvailable;

  /// Create a copy of ProductModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ProductModelCopyWith<ProductModel> get copyWith =>
      _$ProductModelCopyWithImpl<ProductModel>(
          this as ProductModel, _$identity);

  /// Serializes this ProductModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ProductModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.stock, stock) || other.stock == stock) &&
            (identical(other.isAvailable, isAvailable) ||
                other.isAvailable == isAvailable));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, description, price,
      imageUrl, type, stock, isAvailable);

  @override
  String toString() {
    return 'ProductModel(id: $id, name: $name, description: $description, price: $price, imageUrl: $imageUrl, type: $type, stock: $stock, isAvailable: $isAvailable)';
  }
}

/// @nodoc
abstract mixin class $ProductModelCopyWith<$Res> {
  factory $ProductModelCopyWith(
          ProductModel value, $Res Function(ProductModel) _then) =
      _$ProductModelCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: "id") String id,
      @JsonKey(name: "name") String name,
      @JsonKey(name: "description") String description,
      @JsonKey(name: "price") int price,
      @JsonKey(name: "imageUrl") String imageUrl,
      @JsonKey(name: "type") String type,
      @JsonKey(name: "stock") int stock,
      @JsonKey(name: "isAvailable") bool isAvailable});
}

/// @nodoc
class _$ProductModelCopyWithImpl<$Res> implements $ProductModelCopyWith<$Res> {
  _$ProductModelCopyWithImpl(this._self, this._then);

  final ProductModel _self;
  final $Res Function(ProductModel) _then;

  /// Create a copy of ProductModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? price = null,
    Object? imageUrl = null,
    Object? type = null,
    Object? stock = null,
    Object? isAvailable = null,
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
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      stock: null == stock
          ? _self.stock
          : stock // ignore: cast_nullable_to_non_nullable
              as int,
      isAvailable: null == isAvailable
          ? _self.isAvailable
          : isAvailable // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// Adds pattern-matching-related methods to [ProductModel].
extension ProductModelPatterns on ProductModel {
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
    TResult Function(_ProductModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ProductModel() when $default != null:
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
    TResult Function(_ProductModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ProductModel():
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
    TResult? Function(_ProductModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ProductModel() when $default != null:
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
            @JsonKey(name: "type") String type,
            @JsonKey(name: "stock") int stock,
            @JsonKey(name: "isAvailable") bool isAvailable)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ProductModel() when $default != null:
        return $default(_that.id, _that.name, _that.description, _that.price,
            _that.imageUrl, _that.type, _that.stock, _that.isAvailable);
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
            @JsonKey(name: "type") String type,
            @JsonKey(name: "stock") int stock,
            @JsonKey(name: "isAvailable") bool isAvailable)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ProductModel():
        return $default(_that.id, _that.name, _that.description, _that.price,
            _that.imageUrl, _that.type, _that.stock, _that.isAvailable);
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
            @JsonKey(name: "type") String type,
            @JsonKey(name: "stock") int stock,
            @JsonKey(name: "isAvailable") bool isAvailable)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ProductModel() when $default != null:
        return $default(_that.id, _that.name, _that.description, _that.price,
            _that.imageUrl, _that.type, _that.stock, _that.isAvailable);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ProductModel extends ProductModel {
  const _ProductModel(
      {@JsonKey(name: "id") required this.id,
      @JsonKey(name: "name") required this.name,
      @JsonKey(name: "description") required this.description,
      @JsonKey(name: "price") required this.price,
      @JsonKey(name: "imageUrl") required this.imageUrl,
      @JsonKey(name: "type") required this.type,
      @JsonKey(name: "stock") required this.stock,
      @JsonKey(name: "isAvailable") required this.isAvailable})
      : super._();
  factory _ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

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
  @JsonKey(name: "type")
  final String type;
  @override
  @JsonKey(name: "stock")
  final int stock;
  @override
  @JsonKey(name: "isAvailable")
  final bool isAvailable;

  /// Create a copy of ProductModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ProductModelCopyWith<_ProductModel> get copyWith =>
      __$ProductModelCopyWithImpl<_ProductModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ProductModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ProductModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.stock, stock) || other.stock == stock) &&
            (identical(other.isAvailable, isAvailable) ||
                other.isAvailable == isAvailable));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, description, price,
      imageUrl, type, stock, isAvailable);

  @override
  String toString() {
    return 'ProductModel(id: $id, name: $name, description: $description, price: $price, imageUrl: $imageUrl, type: $type, stock: $stock, isAvailable: $isAvailable)';
  }
}

/// @nodoc
abstract mixin class _$ProductModelCopyWith<$Res>
    implements $ProductModelCopyWith<$Res> {
  factory _$ProductModelCopyWith(
          _ProductModel value, $Res Function(_ProductModel) _then) =
      __$ProductModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "id") String id,
      @JsonKey(name: "name") String name,
      @JsonKey(name: "description") String description,
      @JsonKey(name: "price") int price,
      @JsonKey(name: "imageUrl") String imageUrl,
      @JsonKey(name: "type") String type,
      @JsonKey(name: "stock") int stock,
      @JsonKey(name: "isAvailable") bool isAvailable});
}

/// @nodoc
class __$ProductModelCopyWithImpl<$Res>
    implements _$ProductModelCopyWith<$Res> {
  __$ProductModelCopyWithImpl(this._self, this._then);

  final _ProductModel _self;
  final $Res Function(_ProductModel) _then;

  /// Create a copy of ProductModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? price = null,
    Object? imageUrl = null,
    Object? type = null,
    Object? stock = null,
    Object? isAvailable = null,
  }) {
    return _then(_ProductModel(
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
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      stock: null == stock
          ? _self.stock
          : stock // ignore: cast_nullable_to_non_nullable
              as int,
      isAvailable: null == isAvailable
          ? _self.isAvailable
          : isAvailable // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
