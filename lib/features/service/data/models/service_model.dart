// ignore_for_file: invalid_annotation_target

import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/service_entity.dart';

part 'service_model.freezed.dart';
part 'service_model.g.dart';

ServiceModel serviceModelFromJson(String str) => ServiceModel.fromJson(json.decode(str));

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

  factory ServiceModel.fromJson(Map<String, dynamic> json) => _$ServiceModelFromJson(json);

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

// Static getter for prototype data
class ServiceResponseModel {
  static List<ServiceModel> get getPrototypeDataServices {
    return [
      // Service 1 - Cuci Standar
      const ServiceModel(
        id: 'svc-001',
        name: 'Cuci Standar',
        description: 'Cuci motor standar dengan shampo berkualitas',
        price: 15000,
        imageUrl: 'https://example.com/images/cuci-standar.jpg',
        isDefault: true,
        isFavorite: true,
        type: 'washing',
        isActive: true,
      ),

      // Service 2 - Cuci Premium
      const ServiceModel(
        id: 'svc-002',
        name: 'Cuci Premium',
        description: 'Cuci motor premium dengan wax dan detailing',
        price: 25000,
        imageUrl: 'https://example.com/images/cuci-premium.jpg',
        isDefault: false,
        isFavorite: true,
        type: 'washing',
        isActive: true,
      ),

      // Service 3 - Cuci Kilat
      const ServiceModel(
        id: 'svc-003',
        name: 'Cuci Kilat',
        description: 'Cuci motor cepat tanpa detailing',
        price: 10000,
        imageUrl: 'https://example.com/images/cuci-kilat.jpg',
        isDefault: false,
        isFavorite: false,
        type: 'washing',
        isActive: true,
      ),

      // Service 4 - Cuci Detailing
      const ServiceModel(
        id: 'svc-004',
        name: 'Cuci Detailing',
        description: 'Cuci motor lengkap dengan detailing premium',
        price: 40000,
        imageUrl: 'https://example.com/images/cuci-detailing.jpg',
        isDefault: false,
        isFavorite: false,
        type: 'detailing',
        isActive: true,
      ),

      // Service 5 - Salon Motor
      const ServiceModel(
        id: 'svc-005',
        name: 'Salon Motor',
        description: 'Paket lengkap cuci, polish, dan protection',
        price: 75000,
        imageUrl: 'https://example.com/images/salon-motor.jpg',
        isDefault: false,
        isFavorite: false,
        type: 'detailing',
        isActive: true,
      ),

      // Service 6 - Cuci Mesin
      const ServiceModel(
        id: 'svc-006',
        name: 'Cuci Mesin',
        description: 'Cuci mesin motor dengan steam',
        price: 30000,
        imageUrl: 'https://example.com/images/cuci-mesin.jpg',
        isDefault: false,
        isFavorite: false,
        type: 'engine',
        isActive: true,
      ),

      // Service 7 - Coating
      const ServiceModel(
        id: 'svc-007',
        name: 'Coating',
        description: 'Aplikasi coating untuk proteksi cat motor',
        price: 150000,
        imageUrl: 'https://example.com/images/coating.jpg',
        isDefault: false,
        isFavorite: false,
        type: 'protection',
        isActive: true,
      ),

      // Service 8 - Cuci Karpet
      const ServiceModel(
        id: 'svc-008',
        name: 'Cuci Karpet',
        description: 'Cuci karpet motor secara terpisah',
        price: 5000,
        imageUrl: 'https://example.com/images/cuci-karpet.jpg',
        isDefault: false,
        isFavorite: false,
        type: 'cleaning',
        isActive: true,
      ),
    ];
  }
}
