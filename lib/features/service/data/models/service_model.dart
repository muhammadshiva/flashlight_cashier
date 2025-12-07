// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/service_entity.dart';
import 'dart:convert';

part 'service_model.freezed.dart';
part 'service_model.g.dart';

ServiceModel serviceModelFromJson(String str) =>
    ServiceModel.fromJson(json.decode(str));

String serviceModelToJson(ServiceModel data) => json.encode(data.toJson());

@freezed
abstract class ServiceModel with _$ServiceModel {
  const ServiceModel._();

  const factory ServiceModel({
    @JsonKey(name: "id") required String id,
    @JsonKey(name: "name") required String name,
    @JsonKey(name: "description") required String description,
    @JsonKey(name: "price") required int price,
    @JsonKey(name: "imageUrl") required String imageUrl,
    @JsonKey(name: "isDefault") required bool isDefault,
    @JsonKey(name: "isFavorite") required bool isFavorite,
    @JsonKey(name: "type") required String type,
    @JsonKey(name: "isActive") required bool isActive,
  }) = _ServiceModel;

  factory ServiceModel.fromJson(Map<String, dynamic> json) =>
      _$ServiceModelFromJson(json);

  ServiceEntity toEntity() => ServiceEntity(
        id: id,
        name: name,
        description: description,
        price: price,
        imageUrl: imageUrl,
        isDefault: isDefault,
        isFavorite: isFavorite,
        type: type,
        isActive: isActive,
      );
}
