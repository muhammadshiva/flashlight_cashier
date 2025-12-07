// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ServiceModel _$ServiceModelFromJson(Map<String, dynamic> json) =>
    _ServiceModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toInt(),
      imageUrl: json['imageUrl'] as String,
      isDefault: json['isDefault'] as bool,
      isFavorite: json['isFavorite'] as bool,
      type: json['type'] as String,
      isActive: json['isActive'] as bool,
    );

Map<String, dynamic> _$ServiceModelToJson(_ServiceModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'price': instance.price,
      'imageUrl': instance.imageUrl,
      'isDefault': instance.isDefault,
      'isFavorite': instance.isFavorite,
      'type': instance.type,
      'isActive': instance.isActive,
    };
