import 'package:dio/dio.dart';
import 'package:flashlight_pos/features/work_order/domain/usecases/work_order_usecases.dart';

import '../../../../core/constants/api_constans.dart';
import '../../../../core/error/failures.dart';
import '../models/work_order_model.dart';

/// Abstract interface for work order remote data operations.
abstract class WorkOrderRemoteDataSource {
  /// Creates a new work order via the API.
  Future<WorkOrderModel> createWorkOrder(WorkOrderModel workOrder);

  /// Gets all work orders from the API.
  Future<List<WorkOrderModel>> getWorkOrders({required GetWorkOrdersParams params});

  /// Updates an existing work order via the API.
  Future<WorkOrderModel> updateWorkOrder(WorkOrderModel workOrder);

  /// Updates work order status via the API.
  Future<WorkOrderModel> updateWorkOrderStatus(String id, String status);

  /// Gets a work order by [id] from the API.
  Future<WorkOrderModel> getWorkOrderById(String id);
}

/// Implementation of [WorkOrderRemoteDataSource] using Dio.
class WorkOrderRemoteDataSourceImpl implements WorkOrderRemoteDataSource {
  final Dio dio;

  WorkOrderRemoteDataSourceImpl({required this.dio});

  @override
  Future<WorkOrderModel> createWorkOrder(WorkOrderModel workOrder) async {
    try {
      final response = await dio.post(
        ApiConst.workOrders,
        data: workOrder.toJson(),
      );

      // Handle API envelope: { success, message, data: {...}, error_code }
      final result = response.data;
      if (result is Map<String, dynamic>) {
        if (result['success'] == true && result['data'] != null) {
          return WorkOrderModel.fromJson(result['data'] as Map<String, dynamic>);
        }
        // If no data key but has id, assume result itself is the work order
        if (result.containsKey('id')) {
          return WorkOrderModel.fromJson(result);
        }
        throw ServerFailure(result['message'] ?? 'Failed to create work order');
      }

      throw const ServerFailure('Invalid response format');
    } on DioException catch (e) {
      throw ServerFailure(
        e.response?.data?['message'] ?? e.message ?? 'Unknown Error',
      );
    }
  }

  @override
  Future<List<WorkOrderModel>> getWorkOrders({required GetWorkOrdersParams params}) async {
    try {
      if (params.isPrototype) {
        // Return prototype dummy data
        await Future.delayed(const Duration(milliseconds: 500)); // Simulate network delay
        return WorkOrderResponseModel.getPrototypeDataWorkOrders;
      }

      final response = await dio.get(ApiConst.workOrders);

      // Handle API envelope: { success, message, data: { workOrders: [...], total }, error_code }
      final result = response.data;
      if (result is Map<String, dynamic>) {
        if (result['success'] == true && result['data'] != null) {
          final data = result['data'];

          // Handle both array response and object with workOrders field
          if (data is List) {
            return data.map((e) => WorkOrderModel.fromJson(e as Map<String, dynamic>)).toList();
          }

          if (data is Map<String, dynamic>) {
            final workOrdersList = data['workOrders'] ?? data['data'];
            if (workOrdersList is List) {
              return workOrdersList
                  .map((e) => WorkOrderModel.fromJson(e as Map<String, dynamic>))
                  .toList();
            }
          }

          // If data is neither List nor has workOrders field, return empty list
          return [];
        }
        throw ServerFailure(result['message'] ?? 'Failed to fetch work orders');
      }

      // If response is directly a list (fallback for different API formats)
      if (result is List) {
        return result.map((e) => WorkOrderModel.fromJson(e as Map<String, dynamic>)).toList();
      }

      throw const ServerFailure('Invalid response format');
    } on DioException catch (e) {
      throw ServerFailure(
        e.response?.data?['message'] ?? e.message ?? 'Unknown Error',
      );
    }
  }

  @override
  Future<WorkOrderModel> updateWorkOrder(WorkOrderModel workOrder) async {
    try {
      final response = await dio.put(
        '${ApiConst.workOrders}/${workOrder.id}',
        data: workOrder.toJson(),
      );

      // Handle API envelope: { success, message, data: {...}, error_code }
      final result = response.data;
      if (result is Map<String, dynamic>) {
        if (result['success'] == true && result['data'] != null) {
          return WorkOrderModel.fromJson(result['data'] as Map<String, dynamic>);
        }
        // If no data key but has id, assume result itself is the work order
        if (result.containsKey('id')) {
          return WorkOrderModel.fromJson(result);
        }
        throw ServerFailure(result['message'] ?? 'Failed to update work order');
      }

      throw const ServerFailure('Invalid response format');
    } on DioException catch (e) {
      throw ServerFailure(
        e.response?.data?['message'] ?? e.message ?? 'Unknown Error',
      );
    }
  }

  @override
  Future<WorkOrderModel> updateWorkOrderStatus(String id, String status) async {
    try {
      final response = await dio.put(
        ApiConst.updateWorkOrderStatus(id),
        data: {'status': status},
      );

      // Handle API envelope: { success, message, data: {...}, error_code }
      final result = response.data;
      if (result is Map<String, dynamic>) {
        if (result['success'] == true && result['data'] != null) {
          return WorkOrderModel.fromJson(result['data'] as Map<String, dynamic>);
        }
        // If no data key but has id, assume result itself is the work order
        if (result.containsKey('id')) {
          return WorkOrderModel.fromJson(result);
        }
        throw ServerFailure(result['message'] ?? 'Failed to update work order status');
      }

      throw const ServerFailure('Invalid response format');
    } on DioException catch (e) {
      throw ServerFailure(
        e.response?.data?['message'] ?? e.message ?? 'Unknown Error',
      );
    }
  }

  @override
  Future<WorkOrderModel> getWorkOrderById(String id) async {
    try {
      final response = await dio.get('${ApiConst.workOrders}/$id');

      // Handle API envelope: { success, message, data: {...}, error_code }
      final result = response.data;
      if (result is Map<String, dynamic>) {
        if (result['success'] == true && result['data'] != null) {
          return WorkOrderModel.fromJson(result['data'] as Map<String, dynamic>);
        }
        // If no data key but has id, assume result itself is the work order
        if (result.containsKey('id')) {
          return WorkOrderModel.fromJson(result);
        }
        throw ServerFailure(result['message'] ?? 'Work order not found');
      }

      throw const ServerFailure('Invalid response format');
    } on DioException catch (e) {
      throw ServerFailure(
        e.response?.data?['message'] ?? e.message ?? 'Unknown Error',
      );
    }
  }
}
