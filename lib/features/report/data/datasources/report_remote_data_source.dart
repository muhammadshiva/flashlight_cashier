import 'package:dio/dio.dart';

import '../../../../core/constants/api_constans.dart';
import '../../../../core/error/failures.dart';
import '../models/report_model.dart';

abstract class ReportRemoteDataSource {
  Future<ReportModel> generateReport({
    required String reportType,
    required DateTime startDate,
    required DateTime endDate,
    String? status,
    String? customerId,
  });
}

class ReportRemoteDataSourceImpl implements ReportRemoteDataSource {
  final Dio dio;

  ReportRemoteDataSourceImpl({required this.dio});

  @override
  Future<ReportModel> generateReport({
    required String reportType,
    required DateTime startDate,
    required DateTime endDate,
    String? status,
    String? customerId,
  }) async {
    try {
      final requestBody = {
        'reportType': reportType,
        'startDate': startDate.toIso8601String(),
        'endDate': endDate.toIso8601String(),
        'filters': {
          if (status != null) 'status': status,
          if (customerId != null) 'customerId': customerId,
        },
      };

      final response = await dio.post(
        ApiConst.reportGenerate,
        data: requestBody,
      );

      final result = response.data;
      if (result is Map<String, dynamic> && result.containsKey('data')) {
        return ReportModel.fromJson(result['data']);
      }

      return ReportModel.fromJson(result);
    } on DioException catch (e) {
      throw ServerFailure(e.message ?? 'Unknown Error');
    }
  }
}
