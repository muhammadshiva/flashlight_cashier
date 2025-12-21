import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/usecase/usecase.dart';
import '../../../service/domain/usecases/service_usecases.dart';
import '../../../work_order/domain/usecases/work_order_usecases.dart';
import 'reports_event.dart';
import 'reports_state.dart';

class ReportsBloc extends Bloc<ReportsEvent, ReportsState> {
  final GetWorkOrders getWorkOrders;
  final GetServices getServices;

  ReportsBloc({
    required this.getWorkOrders,
    required this.getServices,
  }) : super(ReportsInitial()) {
    on<LoadReports>(_onLoadReports);
  }

  Future<void> _onLoadReports(LoadReports event, Emitter<ReportsState> emit) async {
    emit(ReportsLoading());
    try {
      final workOrdersResult = await getWorkOrders(NoParams());
      final servicesResult = await getServices(const GetServicesParams(isPrototype: true));

      workOrdersResult.fold(
        (failure) {
          log("Check workOrdersResult error : $failure", name: "ReportsBloc");
          emit(ReportsError(failure.message));
        },
        (workOrders) {
          servicesResult.fold(
            (failure) {
              log("Check servicesResult error : $failure", name: "ReportsBloc");
              emit(ReportsError(failure.message));
            },
            (services) {
              // Calculation
              final serviceMap = {for (var s in services) s.id: s.name};

              final dailyRevenue = <DateTime, int>{};
              final serviceRevenue = <String, int>{};
              int carsProcessed = 0;

              for (var wo in workOrders) {
                // Only count completed? Or all? Requirements say "Daily Sales", usually completed or paid.
                // Assuming "completed" or "paid" status.
                // For now, let's use all for revenue to match Dashboard, or maybe filtering by 'completed' is better.
                // Let's filter by status != 'cancelled'
                if (wo.status == 'cancelled') continue;

                // Daily Revenue
                final date = wo.createdAt ?? DateTime.now();
                final dayParams = DateTime(date.year, date.month, date.day);
                dailyRevenue[dayParams] = (dailyRevenue[dayParams] ?? 0) + wo.totalPrice;

                // Cars Processed
                if (wo.status == 'completed') {
                  carsProcessed++;
                }

                // Service Revenue
                for (var wos in wo.services) {
                  final serviceName = serviceMap[wos.serviceId] ?? 'Unknown';
                  serviceRevenue[serviceName] = (serviceRevenue[serviceName] ?? 0) + wos.subtotal;
                }
              }

              emit(ReportsLoaded(
                dailyRevenue: dailyRevenue,
                serviceRevenue: serviceRevenue,
                totalCarsProcessed: carsProcessed,
              ));
            },
          );
        },
      );
    } catch (e) {
      emit(ReportsError(e.toString()));
    }
  }
}
