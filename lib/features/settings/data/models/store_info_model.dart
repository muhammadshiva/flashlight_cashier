import 'package:flashlight_pos/features/settings/domain/entities/store_info.dart';

/// Store Information Model for data layer
class StoreInfoModel {
  final String id;
  final String storeName;
  final String storeAddress;
  final String storePhone;
  final String storeEmail;
  final String? storeLogo;
  final String? storeWebsite;
  final String taxId;
  final String businessLicense;
  final DateTime createdAt;
  final DateTime updatedAt;

  const StoreInfoModel({
    required this.id,
    required this.storeName,
    required this.storeAddress,
    required this.storePhone,
    required this.storeEmail,
    this.storeLogo,
    this.storeWebsite,
    required this.taxId,
    required this.businessLicense,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Create model from JSON
  factory StoreInfoModel.fromJson(Map<String, dynamic> json) {
    return StoreInfoModel(
      id: json['id'] as String,
      storeName: json['store_name'] as String,
      storeAddress: json['store_address'] as String,
      storePhone: json['store_phone'] as String,
      storeEmail: json['store_email'] as String,
      storeLogo: json['store_logo'] as String?,
      storeWebsite: json['store_website'] as String?,
      taxId: json['tax_id'] as String,
      businessLicense: json['business_license'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  /// Convert model to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'store_name': storeName,
      'store_address': storeAddress,
      'store_phone': storePhone,
      'store_email': storeEmail,
      'store_logo': storeLogo,
      'store_website': storeWebsite,
      'tax_id': taxId,
      'business_license': businessLicense,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  /// Convert model to domain entity
  StoreInfo toEntity() {
    return StoreInfo(
      id: id,
      storeName: storeName,
      storeAddress: storeAddress,
      storePhone: storePhone,
      storeEmail: storeEmail,
      storeLogo: storeLogo,
      storeWebsite: storeWebsite,
      taxId: taxId,
      businessLicense: businessLicense,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  /// Dummy data for prototype
  factory StoreInfoModel.dummy() {
    return StoreInfoModel(
      id: 'store-001',
      storeName: 'Flashlight Auto Service',
      storeAddress: 'Jl. Raya Automotive No. 123, Jakarta Selatan 12345',
      storePhone: '+62 21 1234 5678',
      storeEmail: 'info@flashlightauto.com',
      storeLogo: null,
      storeWebsite: 'www.flashlightauto.com',
      taxId: '01.234.567.8-901.000',
      businessLicense: 'NIB-1234567890',
      createdAt: DateTime(2024, 1, 1),
      updatedAt: DateTime.now(),
    );
  }
}
