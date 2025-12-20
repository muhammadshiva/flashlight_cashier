import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../injection_container.dart';
import '../../../work_order/domain/usecases/work_order_usecases.dart';
import '../../domain/entities/work_order.dart';

// Simple Bloc for List Page (Inline or separate file? Separate is better but for speed/simplicity let's use a simple FutureBuilder or a basic cubit if we had one)
// But we should stick to Clean Architecture pattern.
// Let's create a WorkOrderListBloc first? Or reuse PosBloc? No, PosBloc is for POS.
// We need WorkOrderListBloc.
// For now, I will use a simple FutureBuilder with the UseCase directly injected for the List Page to save time/space,
// as creating a full Bloc for just listing is verbose, but technically correct.
// Actually, I'll create a WorkOrderListCubit or Bloc quickly.

import 'package:equatable/equatable.dart';

import '../../../work_order/domain/usecases/update_work_order_status.dart';

// --- Events ---
abstract class WorkOrderListEvent extends Equatable {
  const WorkOrderListEvent();
  @override
  List<Object?> get props => [];
}

class LoadWorkOrders extends WorkOrderListEvent {}

class UpdateWorkOrderEvent extends WorkOrderListEvent {
  final WorkOrder workOrder;
  final String newStatus;
  const UpdateWorkOrderEvent(this.workOrder, this.newStatus);
  @override
  List<Object?> get props => [workOrder, newStatus];
}

// --- States ---
abstract class WorkOrderListState extends Equatable {
  const WorkOrderListState();
  @override
  List<Object?> get props => [];
}

class WorkOrderListInitial extends WorkOrderListState {}

class WorkOrderListLoading extends WorkOrderListState {}

class WorkOrderListLoaded extends WorkOrderListState {
  final List<WorkOrder> workOrders;
  const WorkOrderListLoaded(this.workOrders);
  @override
  List<Object?> get props => [workOrders];
}

class WorkOrderListError extends WorkOrderListState {
  final String message;
  const WorkOrderListError(this.message);
  @override
  List<Object?> get props => [message];
}

// --- Bloc ---
class WorkOrderListBloc extends Bloc<WorkOrderListEvent, WorkOrderListState> {
  final GetWorkOrders getWorkOrders;
  final UpdateWorkOrderStatus updateWorkOrderStatus;

  WorkOrderListBloc({
    required this.getWorkOrders,
    required this.updateWorkOrderStatus,
  }) : super(WorkOrderListInitial()) {
    on<LoadWorkOrders>((event, emit) async {
      emit(WorkOrderListLoading());
      final result = await getWorkOrders(NoParams()); // Fix NoParams usage
      result.fold(
        (failure) => emit(WorkOrderListError(failure.message)),
        (orders) => emit(WorkOrderListLoaded(orders)),
      );
    });

    on<UpdateWorkOrderEvent>((event, emit) async {
      // Optimistic update or reload? Let's reload for simplicity or show loading.
      // Ideally we keep the list and just update one item.
      if (state is WorkOrderListLoaded) {
        // Show loading or keep current state?
        // Let's emit Loading to block interaction for safe update
        emit(WorkOrderListLoading());

        // Create updated object
        // NOTE: WorkOrder entity assumes immutable? Yes.
        // We probably need a copyWith method on Entity usually, but I didn't create it.
        // Let's manually create copy for now or rely on backend to handle status update with just ID?
        // The usecase takes a WorkOrder params.
        // I will implement a quick copyWith-like manual construction here or ideally add copyWith to Entity.
        // Let's assume I add copyWith to Entity or just recreate it here.

        final updatedOrder = WorkOrder(
          id: event.workOrder.id,
          workOrderCode: event.workOrder.workOrderCode,
          customerId: event.workOrder.customerId,
          vehicleDataId: event.workOrder.vehicleDataId,
          queueNumber: event.workOrder.queueNumber,
          estimatedTime: event.workOrder.estimatedTime,
          status: event.newStatus, // NEW STATUS
          paymentStatus: event.newStatus == 'completed'
              ? 'paid'
              : event.workOrder
                  .paymentStatus, // Auto-mark paid? Or separate event?
          paymentMethod: event.workOrder.paymentMethod,
          paidAmount: event.workOrder.paidAmount,
          totalPrice: event.workOrder.totalPrice,
          services: event.workOrder.services,
          products: event.workOrder.products,
          createdAt: event.workOrder.createdAt,
          updatedAt: DateTime.now(),
          completedAt: event.newStatus == 'completed'
              ? DateTime.now()
              : event.workOrder.completedAt,
        );

        final result = await updateWorkOrderStatus(updatedOrder);
        result.fold(
          (failure) => emit(WorkOrderListError(failure.message)),
          (success) {
            add(LoadWorkOrders()); // Reload list
          },
        );
      }
    });
  }
}

// --- Page ---
class WorkOrderListPage extends StatelessWidget {
  const WorkOrderListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          WorkOrderListBloc(getWorkOrders: sl(), updateWorkOrderStatus: sl())
            ..add(LoadWorkOrders()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Work Orders'),
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () => context.push('/pos'), // Navigate to POS
            ),
          ],
        ),
        body: BlocBuilder<WorkOrderListBloc, WorkOrderListState>(
          builder: (context, state) {
            if (state is WorkOrderListLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is WorkOrderListError) {
              return Center(child: Text(state.message));
            } else if (state is WorkOrderListLoaded) {
              if (state.workOrders.isEmpty) {
                return const Center(child: Text('No work orders found.'));
              }
              return ListView.builder(
                itemCount: state.workOrders.length,
                itemBuilder: (context, index) {
                  final order = state.workOrders[index];
                  return Card(
                    margin: const EdgeInsets.all(8.0),
                    child: ListTile(
                      title: Text(order.workOrderCode),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Status: ${order.status}'),
                          Text('Total: \$${order.totalPrice}'),
                          Text('Date: ${order.createdAt?.toLocal()}'),
                        ],
                      ),
                      trailing: order.status != 'completed'
                          ? PopupMenuButton<String>(
                              onSelected: (value) {
                                context
                                    .read<WorkOrderListBloc>()
                                    .add(UpdateWorkOrderEvent(order, value));
                              },
                              itemBuilder: (context) => [
                                const PopupMenuItem(
                                    value: 'in_progress',
                                    child: Text('Mark In Progress')),
                                const PopupMenuItem(
                                    value: 'completed',
                                    child: Text('Mark Completed')),
                                const PopupMenuItem(
                                    value: 'cancelled', child: Text('Cancel')),
                              ],
                            )
                          : const Icon(Icons.check_circle, color: Colors.green),
                      onTap: () {
                        // Navigate to details (Todo)
                      },
                    ),
                  );
                },
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
