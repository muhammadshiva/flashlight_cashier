import 'package:dio/dio.dart';
import '../../../../core/error/failures.dart';
import '../models/work_order_model.dart';

abstract class WorkOrderRemoteDataSource {
  Future<WorkOrderModel> createWorkOrder(WorkOrderModel workOrder);
  Future<List<WorkOrderModel>> getWorkOrders();
  Future<WorkOrderModel> updateWorkOrder(WorkOrderModel workOrder);
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
  Future<List<WorkOrderModel>> getWorkOrders() async {
    try {
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
      final response = await dio.put('/work-orders/${workOrder.id}',
          data: workOrder.toJson());
      return WorkOrderModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerFailure(e.message ?? 'Unknown Error');
    }
  }
}
