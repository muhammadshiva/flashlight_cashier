import 'package:dio/dio.dart';

import '../../../../core/constants/api_constans.dart';
import '../../../../core/error/failures.dart';
import '../../../../features/settings/data/models/store_info_model.dart';
import '../../data/datasources/profile_remote_datasource.dart';
import '../../data/models/get_profile_params.dart';

/// Implementasi Remote Data Source untuk Profile
/// Menangani API call dan dummy data berdasarkan parameter isPrototype
class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final Dio dio;

  ProfileRemoteDataSourceImpl({required this.dio});
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
    if (params.isPrototype ?? false) {
      await Future.delayed(const Duration(milliseconds: 500)); // Simulate network delay
      return StoreInfoModel.dummy();
    }

    try {
      final response = await dio.put(
        ApiConst.profile,
        data: params.toJson(),
      );

      // Handle API envelope: { success, message, data: {...}, error_code }
      final result = response.data;
      if (result is Map<String, dynamic>) {
        if (result['success'] == true && result['data'] != null) {
          return StoreInfoModel.fromJson(result['data'] as Map<String, dynamic>);
        }
        // If no data key but has id, assume result itself is the store info
        if (result.containsKey('id')) {
          return StoreInfoModel.fromJson(result);
        }
        throw ServerFailure(result['message'] ?? 'Failed to update profile');
      }

      throw const ServerFailure('Invalid response format');
    } on DioException catch (e) {
      throw ServerFailure(
        e.response?.data?['message'] ?? e.message ?? 'Unknown Error',
      );
    }
  }
}
