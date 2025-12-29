import 'package:dio/dio.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/pagination/pagination_params.dart';
import '../../../../core/pagination/paginated_response_model.dart';
import '../models/service_model.dart';

abstract class ServiceRemoteDataSource {
  Future<PaginatedResponseModel<ServiceModel>> getServices({
    bool isPrototype = false,
    String? type,
    PaginationParams? pagination,
  });
  Future<ServiceModel> createService(ServiceModel service);
  Future<ServiceModel> updateService(String id, ServiceModel service);
  Future<void> deleteService(String id);
}

class ServiceRemoteDataSourceImpl implements ServiceRemoteDataSource {
  final Dio dio;

  ServiceRemoteDataSourceImpl({required this.dio});

  @override
  Future<PaginatedResponseModel<ServiceModel>> getServices({
    bool isPrototype = false,
    String? type,
    PaginationParams? pagination,
  }) async {
    try {
      // Handle prototype data with pagination
      if (isPrototype) {
        final allServices = ServiceResponseModel.getPrototypeDataServices;
        final page = pagination?.page ?? 1;
        final limit = pagination?.limit ?? 10;
        final offset = pagination?.offset ?? 0;

        final total = allServices.length;
        final totalPages = (total / limit).ceil();
        final startIndex = ((page - 1) * limit) + offset;
        final endIndex = (startIndex + limit).clamp(0, total);

        final paginatedData = allServices.sublist(
          startIndex.clamp(0, total),
          endIndex,
        );

        return PaginatedResponseModel<ServiceModel>(
          data: paginatedData,
          total: total,
          page: page,
          limit: limit,
          totalPages: totalPages,
        );
      }

      // API call with pagination
      final queryParams = <String, dynamic>{};
      if (type != null) queryParams['type'] = type;
      if (pagination != null) queryParams.addAll(pagination.toQueryParams());

      final response = await dio.get(
        '/services',
        queryParameters: queryParams,
      );

      final result = response.data;
      if (result is Map<String, dynamic> && result.containsKey('data')) {
        return PaginatedResponseModel<ServiceModel>.fromJson(
          result,
          (json) => ServiceModel.fromJson(json as Map<String, dynamic>),
        );
      }

      throw ServerFailure('Invalid response format');
    } on DioException catch (e) {
      throw ServerFailure(e.message ?? 'Unknown Error');
    }
  }

  @override
  Future<ServiceModel> createService(ServiceModel service) async {
    try {
      final response = await dio.post('/services', data: service.toJson());
      return ServiceModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerFailure(e.message ?? 'Unknown Error');
    }
  }

  @override
  Future<ServiceModel> updateService(String id, ServiceModel service) async {
    try {
      final response = await dio.put('/api/services/$id', data: service.toJson());

      // Handle response - might be wrapped or direct
      final result = response.data;
      if (result is Map<String, dynamic> && result.containsKey('data')) {
        return ServiceModel.fromJson(result['data']);
      }
      return ServiceModel.fromJson(result);
    } on DioException catch (e) {
      throw ServerFailure(e.message ?? 'Unknown Error');
    }
  }

  @override
  Future<void> deleteService(String id) async {
    try {
      await dio.delete('/services/$id');
    } on DioException catch (e) {
      throw ServerFailure(e.message ?? 'Unknown Error');
    }
  }
}
