import 'package:equatable/equatable.dart';

/// Store Information Entity
///
/// Contains all business information about the store
class StoreInfo extends Equatable {
  final String id;
  final String storeName;
  final String storeAddress;
  final String storePhone;
  final String storeEmail;
  final String? storeLogo;
  final String? storeWebsite;
  final String taxId; // NPWP or Tax ID
  final String businessLicense;
  final DateTime createdAt;
  final DateTime updatedAt;

  const StoreInfo({
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

  @override
  List<Object?> get props => [
        id,
        storeName,
        storeAddress,
        storePhone,
        storeEmail,
        storeLogo,
        storeWebsite,
        taxId,
        businessLicense,
        createdAt,
        updatedAt,
      ];
}
