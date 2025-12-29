import 'dart:developer';

import 'package:dio/dio.dart';

import '../../../../core/error/failures.dart';
import '../models/work_order_model.dart';

abstract class WorkOrderRemoteDataSource {
  Future<WorkOrderModel> createWorkOrder(WorkOrderModel workOrder);
  Future<List<WorkOrderModel>> getWorkOrders({required bool isPrototype});
  Future<WorkOrderModel> updateWorkOrder(WorkOrderModel workOrder);
  Future<WorkOrderModel> updateWorkOrderStatus(String id, String status);
  Future<WorkOrderModel> getWorkOrderById(String id);
}

class WorkOrderRemoteDataSourceImpl implements WorkOrderRemoteDataSource {
  final Dio dio;

  WorkOrderRemoteDataSourceImpl({required this.dio});

  @override
  Future<WorkOrderModel> createWorkOrder(WorkOrderModel workOrder) async {
    try {
      final response = await dio.post('/work-orders', data: workOrder.toJson());
      return WorkOrderModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerFailure(e.message ?? 'Unknown Error');
    }
  }

  @override
  Future<List<WorkOrderModel>> getWorkOrders({bool isPrototype = false}) async {
    try {
      log("Check isPrototype: $isPrototype", name: "WorkOrderRemoteDataSourceImpl");
      if (isPrototype) {
        return WorkOrderResponseModel.getPrototypeDataWorkOrders;
      }

      final response = await dio.get('/work-orders');
      final result = WorkOrderResponseModel.fromJson(response.data);
      if (result.success) {
        return result.data.workOrders;
      } else {
        throw ServerFailure(result.message);
      }
    } on DioException catch (e) {
      throw ServerFailure(e.message ?? 'Unknown Error');
    }
  }

  @override
  Future<WorkOrderModel> updateWorkOrder(WorkOrderModel workOrder) async {
    try {
      final response = await dio.put('/work-orders/${workOrder.id}', data: workOrder.toJson());
      return WorkOrderModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerFailure(e.message ?? 'Unknown Error');
    }
  }

  @override
  Future<WorkOrderModel> updateWorkOrderStatus(String id, String status) async {
    try {
      final response = await dio.put(
        '/api/work-orders/$id/status',
        data: {'status': status},
      );

      // Handle response - might be wrapped or direct
      final result = response.data;
      if (result is Map<String, dynamic> && result.containsKey('data')) {
        return WorkOrderModel.fromJson(result['data']);
      }
      return WorkOrderModel.fromJson(result);
    } on DioException catch (e) {
      throw ServerFailure(e.message ?? 'Unknown Error');
    }
  }

  @override
  Future<WorkOrderModel> getWorkOrderById(String id) async {
    try {
      final response = await dio.get('/work-orders/$id');
      // Assuming the response structure for single item is wrapped in standard response
      // But based on create/update, it might return the object directly inside 'data'.
      // Let's verify standard response structure from API_CONTRACT.
      // API_CONTRACT says: Response Data (`data`): `WorkOrder Object`
      // So it should be `response.data['data']` if we follow standard wrapper,
      // OR `WorkOrderModel.fromJson(response.data)` if the interceptor handles unwrapping?
      // Looking at `getWorkOrders` implementation: `WorkOrderResponseModel.fromJson(response.data)`
      // Looking at `createWorkOrder`: `WorkOrderModel.fromJson(response.data)`
      // This implies `response.data` IS the object for Create/Update?
      // Wait, `WorkOrderResponseModel.fromJson(response.data)` implies `response.data` is the whole JSON { success:..., data: ... }
      // `createWorkOrder` calls `WorkOrderModel.fromJson(response.data)`.
      // If `response.data` is `{ success: true, data: { ... } }`, then `WorkOrderModel.fromJson` would fail if it expects fields at root.
      // Most Likely: There is an Interceptor that unwraps `data`? Or `WorkOrderModel.fromJson` handles the wrapper?
      // Let's assume the API returns standard wrapper.
      // If `createWorkOrder` works, then `WorkOrderModel.fromJson` might be parsing the inner data?
      // Or `dio` response.data is already just the data payload?

      // Let's assume consistent behavior.
      // For `getWorkOrderById`, I'll use:
      // final result = response.data;
      // return WorkOrderModel.fromJson(result['data']);
      // But let's check `WorkOrderModel` to be sure. I can't check it right now without tool call.
      // But based on `getWorkOrders`: `WorkOrderResponseModel.fromJson(response.data)`
      // That model likely parses `{ data: { workOrders: [] } }`

      // For create: `WorkOrderModel.fromJson(response.data)`.
      // If response is `{ success: true, data: {...workorder...} }`
      // Standard `fromJson` usually maps fields directly.
      // I suspect `response.data` might be the RAW json object.

      // Let's look at `createWorkOrder` again.
      // `WorkOrderModel.fromJson(response.data)`
      // If `response.data` has `data` field, `WorkOrderModel` probably doesn't have `data` field.
      // Maybe the interceptor unwraps it?
      // If I look at `lib/core/network/dio_client.dart` or similar I might know.
      // But for now, assuming `createWorkOrder` code is correct...
      // `response.data` seems to be passed directly.
      // BUT `getWorkOrders` uses `WorkOrderResponseModel`.

      // Let's write safe code.
      final result = response.data;
      if (result is Map<String, dynamic> && result.containsKey('data')) {
        return WorkOrderModel.fromJson(result['data']);
      }
      return WorkOrderModel.fromJson(result);
    } on DioException catch (e) {
      throw ServerFailure(e.message ?? 'Unknown Error');
    }
  }
}
