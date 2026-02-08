import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/get_work_order.dart';
import '../../../domain/usecases/update_work_order_status.dart';
import '../../../domain/usecases/work_order_usecases.dart';
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
      final result = await getWorkOrder(
        GetWorkOrderByIdParams(id: event.id, isPrototype: true),
      );
      result.fold(
        (failure) => emit(WorkOrderDetailError(failure.message)),
        (workOrder) => emit(WorkOrderDetailLoaded(workOrder)),
      );
    });

    on<UpdateWorkOrderStatusEvent>((event, emit) async {
      if (state is WorkOrderDetailLoaded) {
        emit(WorkOrderDetailLoading());

        final result = await updateWorkOrderStatus(
          UpdateWorkOrderStatusParams(
            id: event.id,
            status: event.status,
          ),
        );

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
