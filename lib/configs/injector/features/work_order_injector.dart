import 'package:get_it/get_it.dart';

import '../../../core/network/dio_client.dart';
import '../../../features/work_order/data/datasources/work_order_remote_data_source.dart';
import '../../../features/work_order/data/repositories/work_order_repository_impl.dart';
import '../../../features/work_order/domain/repositories/work_order_repository.dart';
import '../../../features/work_order/domain/usecases/work_order_usecases.dart';
import '../../../features/work_order/domain/usecases/update_work_order_status.dart';
import '../../../features/work_order/domain/usecases/get_work_order.dart';
import '../../../features/work_order/presentation/bloc/pos_bloc.dart';
import '../../../features/work_order/presentation/bloc/detail/work_order_detail_bloc.dart';
import '../../../features/history/presentation/bloc/history_bloc.dart';

final _sl = GetIt.instance;

/// Dependency injection configuration for the Work Order feature.
class WorkOrderInjector {
  static void init() {
    // ============================================
    // BLoCs - Register as Factory
    // ============================================
    _sl.registerFactory<PosBloc>(
      () => PosBloc(
        getCustomers: _sl(),
        getVehicles: _sl(),
        getServices: _sl(),
        getProducts: _sl(),
        createWorkOrder: _sl(),
      ),
    );

    _sl.registerFactory<WorkOrderDetailBloc>(
      () => WorkOrderDetailBloc(
        getWorkOrder: _sl(),
        updateWorkOrderStatus: _sl(),
      ),
    );

    _sl.registerFactory<HistoryBloc>(
      () => HistoryBloc(
        getWorkOrders: _sl(),
        getCustomers: _sl(),
        getVehicles: _sl(),
      ),
    );

    // ============================================
    // Use Cases - Register as Lazy Singleton
    // ============================================
    _sl.registerLazySingleton<CreateWorkOrder>(
      () => CreateWorkOrder(_sl()),
    );

    _sl.registerLazySingleton<GetWorkOrders>(
      () => GetWorkOrders(_sl()),
    );

    _sl.registerLazySingleton<GetWorkOrder>(
      () => GetWorkOrder(_sl()),
    );

    _sl.registerLazySingleton<UpdateWorkOrderStatus>(
      () => UpdateWorkOrderStatus(_sl()),
    );

    // ============================================
    // Repository - Register as Lazy Singleton
    // ============================================
    _sl.registerLazySingleton<WorkOrderRepository>(
      () => WorkOrderRepositoryImpl(remoteDataSource: _sl()),
    );

    // ============================================
    // Data Sources - Register as Lazy Singleton
    // ============================================
    _sl.registerLazySingleton<WorkOrderRemoteDataSource>(
      () => WorkOrderRemoteDataSourceImpl(dio: _sl<DioClient>().dio),
    );
  }
}
