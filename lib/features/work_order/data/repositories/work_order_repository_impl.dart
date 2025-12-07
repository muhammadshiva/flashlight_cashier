import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/work_order.dart';
import '../../domain/repositories/work_order_repository.dart';
import '../datasources/work_order_remote_data_source.dart';
import '../models/work_order_model.dart';
import '../models/work_order_service_model.dart';
import '../models/work_order_product_model.dart';

class WorkOrderRepositoryImpl implements WorkOrderRepository {
  final WorkOrderRemoteDataSource remoteDataSource;

  WorkOrderRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, WorkOrder>> createWorkOrder(
      WorkOrder workOrder) async {
    try {
      // Map entity to model manually to ensure deep conversion
      final model = WorkOrderModel(
        id: workOrder.id,
        workOrderCode: workOrder.workOrderCode,
        customerId: workOrder.customerId,
        vehicleDataId: workOrder.vehicleDataId,
        queueNumber: workOrder.queueNumber,
        estimatedTime: workOrder.estimatedTime,
        status: workOrder.status,
        paymentStatus: workOrder.paymentStatus,
        paymentMethod: workOrder.paymentMethod,
        paidAmount: workOrder.paidAmount,
        totalPrice: workOrder.totalPrice,
        serviceModels: workOrder.services
            .map((s) => WorkOrderServiceModel(
                  id: s.id,
                  workOrderId: s.workOrderId,
                  serviceId: s.serviceId,
                  quantity: s.quantity,
                  priceAtOrder: s.priceAtOrder,
                  subtotal: s.subtotal,
                  /* serviceModel: null, // Don't need to send full object on creation usually */
                ))
            .toList(),
        productModels: workOrder.products
            .map((p) => WorkOrderProductModel(
                  id: p.id,
                  workOrderId: p.workOrderId,
                  productId: p.productId,
                  quantity: p.quantity,
                  priceAtOrder: p.priceAtOrder,
                  subtotal: p.subtotal,
                ))
            .toList(),
        createdAt: workOrder.createdAt,
        updatedAt: workOrder.updatedAt,
        completedAt: workOrder.completedAt,
      );

      final result = await remoteDataSource.createWorkOrder(model);
      return Right(result.toEntity());
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, List<WorkOrder>>> getWorkOrders() async {
    try {
      final result = await remoteDataSource.getWorkOrders();
      return Right(result.map((e) => e.toEntity()).toList());
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, WorkOrder>> updateWorkOrder(
      WorkOrder workOrder) async {
    try {
      // For update, we might not need to send full nested objects if backend handles it,
      // but let's assume standard PUT replaces resource or PATCH updates fields.
      // Using same conversion as create for consistency for now.
      final model = WorkOrderModel(
        id: workOrder.id,
        workOrderCode: workOrder.workOrderCode,
        customerId: workOrder.customerId,
        vehicleDataId: workOrder.vehicleDataId,
        queueNumber: workOrder.queueNumber,
        estimatedTime: workOrder.estimatedTime,
        status: workOrder.status,
        paymentStatus: workOrder.paymentStatus,
        paymentMethod: workOrder.paymentMethod,
        paidAmount: workOrder.paidAmount,
        totalPrice: workOrder.totalPrice,
        serviceModels: workOrder.services
            .map((s) => WorkOrderServiceModel(
                  id: s.id,
                  workOrderId: s.workOrderId,
                  serviceId: s.serviceId,
                  quantity: s.quantity,
                  priceAtOrder: s.priceAtOrder,
                  subtotal: s.subtotal,
                ))
            .toList(),
        productModels: workOrder.products
            .map((p) => WorkOrderProductModel(
                  id: p.id,
                  workOrderId: p.workOrderId,
                  productId: p.productId,
                  quantity: p.quantity,
                  priceAtOrder: p.priceAtOrder,
                  subtotal: p.subtotal,
                ))
            .toList(),
        createdAt: workOrder.createdAt,
        updatedAt: workOrder.updatedAt,
        completedAt: workOrder.completedAt,
      );

      final result = await remoteDataSource.updateWorkOrder(model);
      return Right(result.toEntity());
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, WorkOrder>> getWorkOrderById(String id) async {
    try {
      final result = await remoteDataSource.getWorkOrderById(id);
      return Right(result.toEntity());
    } on Failure catch (e) {
      return Left(e);
    }
  }
}
