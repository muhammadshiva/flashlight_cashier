import 'package:dio/dio.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/pagination/pagination_params.dart';
import '../../../../core/pagination/paginated_response_model.dart';
import '../models/service_model.dart';

/// Abstract interface for service remote data operations.
abstract class ServiceRemoteDataSource {
  /// Gets paginated list of services from the API.
  /// Supports optional [type] filter and [pagination] params.
  Future<PaginatedResponseModel<ServiceModel>> getServices({
    String? type,
    PaginationParams? pagination,
  });

  /// Creates a new service via the API.
  Future<ServiceModel> createService(ServiceModel service);

  /// Updates an existing service via the API.
  Future<ServiceModel> updateService(String id, ServiceModel service);

  /// Deletes a service by [id] via the API.
  Future<void> deleteService(String id);
}

/// Implementation of [ServiceRemoteDataSource] using Dio.
class ServiceRemoteDataSourceImpl implements ServiceRemoteDataSource {
  final Dio dio;

  ServiceRemoteDataSourceImpl({required this.dio});

  @override
  Future<PaginatedResponseModel<ServiceModel>> getServices({
    String? type,
    PaginationParams? pagination,
  }) async {
    try {
      // Build query parameters
      final queryParams = <String, dynamic>{};
      if (type != null) queryParams['type'] = type;
      if (pagination != null) queryParams.addAll(pagination.toQueryParams());

      final response = await dio.get(
        '/services',
        queryParameters: queryParams,
      );

      // Handle API envelope: { success, message, data: { services: [...], total }, error_code }
      final result = response.data;
      if (result is Map<String, dynamic>) {
        if (result['success'] == true && result['data'] != null) {
          final data = result['data'];
          final servicesList = data['services'] as List;
          final total = data['total'] as int? ?? servicesList.length;

          // Calculate pagination info
          final page = pagination?.page ?? 1;
          final limit = pagination?.limit ?? 10;
          final totalPages = (total / limit).ceil();

          final services = servicesList
              .map((e) => ServiceModel.fromJson(e as Map<String, dynamic>))
              .toList();

          return PaginatedResponseModel<ServiceModel>(
            data: services,
            total: total,
            page: page,
            limit: limit,
            totalPages: totalPages > 0 ? totalPages : 1,
          );
        }
        throw ServerFailure(result['message'] ?? 'Failed to fetch services');
      }

      throw const ServerFailure('Invalid response format');
    } on DioException catch (e) {
      throw ServerFailure(
        e.response?.data?['message'] ?? e.message ?? 'Unknown Error',
      );
    }
  }

  @override
  Future<ServiceModel> createService(ServiceModel service) async {
    try {
      final response = await dio.post(
        '/services',
        data: {
          'name': service.name,
          'description': service.description,
          'price': service.price,
          'imageURL': service.imageUrl,
          'type': service.type,
        },
      );

      // Handle API envelope: { success, message, data: {...}, error_code }
      final result = response.data;
      if (result is Map<String, dynamic>) {
        if (result['success'] == true && result['data'] != null) {
          return ServiceModel.fromJson(result['data'] as Map<String, dynamic>);
        }
        // If no data key but has id, assume result itself is the service
        if (result.containsKey('id')) {
          return ServiceModel.fromJson(result);
        }
        throw ServerFailure(result['message'] ?? 'Failed to create service');
      }

      throw const ServerFailure('Invalid response format');
    } on DioException catch (e) {
      throw ServerFailure(
        e.response?.data?['message'] ?? e.message ?? 'Unknown Error',
      );
    }
  }

  @override
  Future<ServiceModel> updateService(String id, ServiceModel service) async {
    try {
      final response = await dio.put(
        '/services/$id',
        data: {
          'name': service.name,
          'description': service.description,
          'price': service.price,
          'imageURL': service.imageUrl,
          'type': service.type,
        },
      );

      // Handle API envelope: { success, message, data: {...}, error_code }
      final result = response.data;
      if (result is Map<String, dynamic>) {
        if (result['success'] == true && result['data'] != null) {
          return ServiceModel.fromJson(result['data'] as Map<String, dynamic>);
        }
        // If no data key but has id, assume result itself is the service
        if (result.containsKey('id')) {
          return ServiceModel.fromJson(result);
        }
        throw ServerFailure(result['message'] ?? 'Failed to update service');
      }

      throw const ServerFailure('Invalid response format');
    } on DioException catch (e) {
      throw ServerFailure(
        e.response?.data?['message'] ?? e.message ?? 'Unknown Error',
      );
    }
  }

  @override
  Future<void> deleteService(String id) async {
    try {
      final response = await dio.delete('/services/$id');

      // Handle API envelope: { success, message, data: null, error_code }
      final result = response.data;
      if (result is Map<String, dynamic>) {
        if (result['success'] != true) {
          throw ServerFailure(result['message'] ?? 'Failed to delete service');
        }
      }
      // If response is empty or success, return normally
    } on DioException catch (e) {
      throw ServerFailure(
        e.response?.data?['message'] ?? e.message ?? 'Unknown Error',
      );
    }
  }
}
