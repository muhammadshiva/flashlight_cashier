import 'package:flashlight_pos/features/profile/data/datasources/profile_remote_datasource.dart';
import 'package:flashlight_pos/features/profile/data/models/get_profile_params.dart';
import 'package:flashlight_pos/features/settings/data/models/store_info_model.dart';

/// Implementasi Remote Data Source untuk Profile
/// Menangani API call dan dummy data berdasarkan parameter isPrototype
class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  @override
  Future<StoreInfoModel> getProfile(GetProfileParams params) async {
    // Jika isPrototype true, return dummy data
    if (params.isPrototype) {
      await Future.delayed(const Duration(milliseconds: 500)); // Simulate network delay
      return StoreInfoModel.dummy();
    }

    // TODO: Implementasi API call sebenarnya
    // final response = await dioClient.get('/profile');
    // return StoreInfoModel.fromJson(response.data);

    // Untuk sekarang, return dummy data juga
    await Future.delayed(const Duration(milliseconds: 500));
    return StoreInfoModel.dummy();
  }

  @override
  Future<StoreInfoModel> updateProfile(UpdateProfileParams params) async {
    // Jika isPrototype true, return updated dummy data
    // Note: UpdateProfileParams tidak punya isPrototype, jadi kita asumsikan
    // update selalu mengembalikan data yang diupdate

    // TODO: Implementasi API call sebenarnya
    // final response = await dioClient.put('/profile', data: params.toJson());
    // return StoreInfoModel.fromJson(response.data);

    // Untuk sekarang, return dummy data yang diupdate
    await Future.delayed(const Duration(milliseconds: 500));

    return StoreInfoModel(
      id: params.id,
      storeName: params.storeName,
      storeAddress: params.storeAddress,
      storePhone: params.storePhone,
      storeEmail: params.storeEmail,
      storeLogo: params.storeLogo,
      storeWebsite: params.storeWebsite,
      taxId: params.taxId,
      businessLicense: params.businessLicense,
      createdAt: DateTime.now().subtract(const Duration(days: 30)),
      updatedAt: DateTime.now(),
    );
  }
}
