import 'package:dio/dio.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/pagination/paginated_response_model.dart';
import '../../../../core/pagination/pagination_params.dart';
import '../models/customer_model.dart';

/// Abstract interface for customer remote data operations.
abstract class CustomerRemoteDataSource {
  /// Gets paginated list of customers from the API.
  /// Supports optional [pagination] params and [query] for search.
  Future<PaginatedResponseModel<CustomerModel>> getCustomers({
    PaginationParams? pagination,
    String? query,
    bool? isPrototype,
  });

  /// Gets a single customer by [id] from the API.
  Future<CustomerModel> getCustomer(String id);

  /// Creates a new customer via the API.
  Future<CustomerModel> createCustomer(CustomerModel customer);

  /// Updates an existing customer via the API.
  Future<CustomerModel> updateCustomer(CustomerModel customer);

  /// Deletes a customer by [id] via the API.
  Future<void> deleteCustomer(String id);
}

/// Implementation of [CustomerRemoteDataSource] using Dio.
class CustomerRemoteDataSourceImpl implements CustomerRemoteDataSource {
  final Dio dio;

  CustomerRemoteDataSourceImpl({required this.dio});

  @override
  Future<PaginatedResponseModel<CustomerModel>> getCustomers({
    PaginationParams? pagination,
    String? query,
    bool? isPrototype,
  }) async {
    try {
      if (isPrototype ?? false) {
        // Return prototype dummy data with pagination
        await Future.delayed(const Duration(milliseconds: 500)); // Simulate network delay

        return CustomerModel.getPaginatedPrototypeData(
          page: pagination?.page ?? 1,
          limit: pagination?.limit ?? 10,
          query: query,
        );
      }
      // Build query parameters
      final queryParams = <String, dynamic>{};
      if (pagination != null) {
        queryParams.addAll(pagination.toQueryParams());
      }
      if (query != null && query.isNotEmpty) {
        queryParams['query'] = query;
      }

      final response = await dio.get(
        '/customers',
        queryParameters: queryParams,
      );

      // Handle API envelope: { success, message, data: { customers: [...], total }, error_code }
      final result = response.data;
      if (result is Map<String, dynamic>) {
        if (result['success'] == true && result['data'] != null) {
          final data = result['data'];
          final customersList = data['customers'] as List;
          final total = data['total'] as int? ?? customersList.length;

          // Calculate pagination info
          final page = pagination?.page ?? 1;
          final limit = pagination?.limit ?? 10;
          final totalPages = (total / limit).ceil();

          final customers =
              customersList.map((e) => CustomerModel.fromJson(e as Map<String, dynamic>)).toList();

          return PaginatedResponseModel<CustomerModel>(
            data: customers,
            total: total,
            page: page,
            limit: limit,
            totalPages: totalPages > 0 ? totalPages : 1,
          );
        }
        throw ServerFailure(result['message'] ?? 'Failed to fetch customers');
      }

      throw const ServerFailure('Invalid response format');
    } on DioException catch (e) {
      throw ServerFailure(
        e.response?.data?['message'] ?? e.message ?? 'Unknown Error',
      );
    }
  }

  @override
  Future<CustomerModel> getCustomer(String id) async {
    try {
      final response = await dio.get('/customers/$id');

      // Handle API envelope: { success, message, data: {...}, error_code }
      final result = response.data;
      if (result is Map<String, dynamic>) {
        if (result['success'] == true && result['data'] != null) {
          return CustomerModel.fromJson(result['data'] as Map<String, dynamic>);
        }
        throw ServerFailure(result['message'] ?? 'Customer not found');
      }

      throw const ServerFailure('Invalid response format');
    } on DioException catch (e) {
      throw ServerFailure(
        e.response?.data?['message'] ?? e.message ?? 'Unknown Error',
      );
    }
  }

  @override
  Future<CustomerModel> createCustomer(CustomerModel customer) async {
    try {
      final response = await dio.post(
        '/customers',
        data: {
          'name': customer.name,
          'phoneNumber': customer.phoneNumber,
          'email': customer.email,
        },
      );

      // Handle API envelope: { success, message, data: {...}, error_code }
      final result = response.data;
      if (result is Map<String, dynamic>) {
        if (result['success'] == true && result['data'] != null) {
          return CustomerModel.fromJson(result['data'] as Map<String, dynamic>);
        }
        // If no data key but has id, assume result itself is the customer
        if (result.containsKey('id')) {
          return CustomerModel.fromJson(result);
        }
        throw ServerFailure(result['message'] ?? 'Failed to create customer');
      }

      throw const ServerFailure('Invalid response format');
    } on DioException catch (e) {
      throw ServerFailure(
        e.response?.data?['message'] ?? e.message ?? 'Unknown Error',
      );
    }
  }

  @override
  Future<CustomerModel> updateCustomer(CustomerModel customer) async {
    try {
      final response = await dio.put(
        '/customers/${customer.id}',
        data: {
          'name': customer.name,
          'phoneNumber': customer.phoneNumber,
          'email': customer.email,
        },
      );

      // Handle API envelope: { success, message, data: {...}, error_code }
      final result = response.data;
      if (result is Map<String, dynamic>) {
        if (result['success'] == true && result['data'] != null) {
          return CustomerModel.fromJson(result['data'] as Map<String, dynamic>);
        }
        // If no data key but has id, assume result itself is the customer
        if (result.containsKey('id')) {
          return CustomerModel.fromJson(result);
        }
        throw ServerFailure(result['message'] ?? 'Failed to update customer');
      }

      throw const ServerFailure('Invalid response format');
    } on DioException catch (e) {
      throw ServerFailure(
        e.response?.data?['message'] ?? e.message ?? 'Unknown Error',
      );
    }
  }

  @override
  Future<void> deleteCustomer(String id) async {
    try {
      final response = await dio.delete('/customers/$id');

      // Handle API envelope: { success, message, data: null, error_code }
      final result = response.data;
      if (result is Map<String, dynamic>) {
        if (result['success'] != true) {
          throw ServerFailure(result['message'] ?? 'Failed to delete customer');
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
