import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/get_work_order.dart';
import '../../../domain/usecases/update_work_order_status.dart';
import '../../../domain/entities/work_order.dart';
import 'work_order_detail_event.dart';
import 'work_order_detail_state.dart';

class WorkOrderDetailBloc
    extends Bloc<WorkOrderDetailEvent, WorkOrderDetailState> {
  final GetWorkOrder getWorkOrder;
  final UpdateWorkOrderStatus updateWorkOrderStatus;

  WorkOrderDetailBloc({
    required this.getWorkOrder,
    required this.updateWorkOrderStatus,
  }) : super(WorkOrderDetailInitial()) {
    on<LoadWorkOrderDetail>((event, emit) async {
      emit(WorkOrderDetailLoading());
      final result = await getWorkOrder(event.id);
      result.fold(
        (failure) => emit(WorkOrderDetailError(failure.message)),
        (workOrder) => emit(WorkOrderDetailLoaded(workOrder)),
      );
    });

    on<UpdateWorkOrderStatusEvent>((event, emit) async {
      if (state is WorkOrderDetailLoaded) {
        final currentOrder = (state as WorkOrderDetailLoaded).workOrder;

        emit(WorkOrderDetailLoading());

        final updatedOrder = WorkOrder(
          id: currentOrder.id,
          workOrderCode: currentOrder.workOrderCode,
          customerId: currentOrder.customerId,
          vehicleDataId: currentOrder.vehicleDataId,
          queueNumber: currentOrder.queueNumber,
          estimatedTime: currentOrder.estimatedTime,
          status: event.status,
          paymentStatus:
              event.status == 'completed' ? 'paid' : currentOrder.paymentStatus,
          paymentMethod: currentOrder.paymentMethod,
          paidAmount: currentOrder.paidAmount,
          totalPrice: currentOrder.totalPrice,
          services: currentOrder.services,
          products: currentOrder.products,
          createdAt: currentOrder.createdAt,
          updatedAt: DateTime.now(),
          completedAt: event.status == 'completed'
              ? DateTime.now()
              : currentOrder.completedAt,
        );

        final result = await updateWorkOrderStatus(updatedOrder);
        result.fold(
          (failure) => emit(WorkOrderDetailError(failure.message)),
          (success) {
            add(LoadWorkOrderDetail(event.id));
          },
        );
      }
    });
  }
}
