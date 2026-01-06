import 'package:equatable/equatable.dart';

/// Parameters untuk mendapatkan profile
///
/// isPrototype: Jika true, return dummy data instead of calling API
class GetProfileParams extends Equatable {
  final bool isPrototype;

  const GetProfileParams({
    this.isPrototype = false,
  });

  @override
  List<Object?> get props => [isPrototype];
}

/// Parameters untuk update profile
class UpdateProfileParams extends Equatable {
  final String id;
  final String storeName;
  final String storeAddress;
  final String storePhone;
  final String storeEmail;
  final String? storeLogo;
  final String? storeWebsite;
  final String taxId;
  final String businessLicense;

  const UpdateProfileParams({
    required this.id,
    required this.storeName,
    required this.storeAddress,
    required this.storePhone,
    required this.storeEmail,
    this.storeLogo,
    this.storeWebsite,
    required this.taxId,
    required this.businessLicense,
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
      ];
}
