import 'package:dio/dio.dart';
import 'package:flashlight_pos/core/constants/api_constans.dart';

import '../../../../core/error/failures.dart';
import '../models/dashboard_stats_model.dart';

abstract class DashboardRemoteDataSource {
  Future<DashboardStatsModel> getDashboardStats({bool isPrototype = false});
}

class DashboardRemoteDataSourceImpl implements DashboardRemoteDataSource {
  final Dio dio;

  DashboardRemoteDataSourceImpl({required this.dio});

  @override
  Future<DashboardStatsModel> getDashboardStats({bool isPrototype = false}) async {
    try {
      if (isPrototype) {
        return DashboardStatsModel.prototypeData;
      }

      final response = await dio.get(ApiConst.dashboardStats);

      // Response envelope: { success, message, data: {...}, error_code }
      final result = response.data;
      if (result is Map<String, dynamic>) {
        if (result['success'] == true && result['data'] != null) {
          final data = result['data'];
          if (data is Map<String, dynamic>) {
            return DashboardStatsModel.fromJson(data);
          }
        }
        throw ServerFailure(result['message'] ?? 'Failed to fetch dashboard stats');
      }

      throw const ServerFailure('Invalid response format');
    } on DioException catch (e) {
      throw ServerFailure(
        e.response?.data?['message'] ?? e.message ?? 'Unknown Error',
      );
    } catch (e) {
      throw ServerFailure('Failed to parse dashboard stats: ${e.toString()}');
    }
  }
}
