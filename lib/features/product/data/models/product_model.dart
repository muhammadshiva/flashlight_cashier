// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/product.dart';
import 'dart:convert';

part 'product_model.freezed.dart';
part 'product_model.g.dart';

ProductModel productModelFromJson(String str) =>
    ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

@freezed
abstract class ProductModel with _$ProductModel {
  const ProductModel._();

  const factory ProductModel({
    @JsonKey(name: "id") required String id,
    @JsonKey(name: "name") required String name,
    @JsonKey(name: "description") required String description,
    @JsonKey(name: "price") required int price,
    @JsonKey(name: "imageUrl") required String imageUrl,
    @JsonKey(name: "type") required String type,
    @JsonKey(name: "stock") required int stock,
    @JsonKey(name: "isAvailable") required bool isAvailable,
  }) = _ProductModel;

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  Product toEntity() => Product(
        id: id,
        name: name,
        description: description,
        price: price,
        imageUrl: imageUrl,
        type: type,
        stock: stock,
        isAvailable: isAvailable,
      );
}
