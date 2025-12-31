import 'package:dio/dio.dart';
import '../../../../core/error/failures.dart';
import '../models/dashboard_stats_model.dart';

abstract class DashboardRemoteDataSource {
  Future<DashboardStatsModel> getDashboardStats();
}

class DashboardRemoteDataSourceImpl implements DashboardRemoteDataSource {
  final Dio dio;

  DashboardRemoteDataSourceImpl({required this.dio});

  @override
  Future<DashboardStatsModel> getDashboardStats() async {
    try {
      final response = await dio.get('/dashboard/stats');

      // Response envelope: { success, message, data: {...}, error_code }
      final data = response.data['data'];
      return DashboardStatsModel.fromJson(data);
    } on DioException catch (e) {
      throw ServerFailure(e.message ?? 'Unknown Error');
    }
  }
}
