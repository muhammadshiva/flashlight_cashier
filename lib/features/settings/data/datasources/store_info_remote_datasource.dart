import 'package:dio/dio.dart';
import 'package:flashlight_pos/features/settings/data/models/get_store_info_params.dart';
import 'package:flashlight_pos/features/settings/data/models/store_info_model.dart';

/// Remote data source for store information
abstract class StoreInfoRemoteDataSource {
  /// Get store information
  /// If isPrototype is true, returns dummy data
  Future<StoreInfoModel> getStoreInfo(GetStoreInfoParams params);
}

class StoreInfoRemoteDataSourceImpl implements StoreInfoRemoteDataSource {
  final Dio dio;

  StoreInfoRemoteDataSourceImpl({required this.dio});

  @override
  Future<StoreInfoModel> getStoreInfo(GetStoreInfoParams params) async {
    // Return dummy data if in prototype mode
    if (params.isPrototype) {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 500));
      return StoreInfoModel.dummy();
    }

    // Real API call (when backend is ready)
    try {
      final response = await dio.get('/store/info');

      if (response.statusCode == 200) {
        final data = response.data['data'];
        return StoreInfoModel.fromJson(data);
      } else {
        throw Exception('Failed to load store information');
      }
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
    }
  }
}
