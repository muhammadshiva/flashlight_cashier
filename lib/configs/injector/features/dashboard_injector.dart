import 'package:get_it/get_it.dart';

import '../../../core/network/dio_client.dart';
import '../../../features/dashboard/data/datasources/dashboard_remote_data_source.dart';
import '../../../features/dashboard/data/repositories/dashboard_repository_impl.dart';
import '../../../features/dashboard/domain/repositories/dashboard_repository.dart';
import '../../../features/dashboard/domain/usecases/get_dashboard_stats.dart';
import '../../../features/dashboard/presentation/bloc/dashboard_bloc.dart';

final _sl = GetIt.instance;

/// Dependency injection configuration for the Dashboard feature.
class DashboardInjector {
  static void init() {
    // ============================================
    // BLoCs - Register as Factory
    // ============================================
    _sl.registerFactory<DashboardBloc>(
      () => DashboardBloc(
        getDashboardStats: _sl(),
        getWorkOrders: _sl(),
        getCustomers: _sl(),
        getVehicles: _sl(),
        updateWorkOrderStatus: _sl(),
      ),
    );

    // ============================================
    // Use Cases - Register as Lazy Singleton
    // ============================================
    _sl.registerLazySingleton<GetDashboardStats>(
      () => GetDashboardStats(_sl()),
    );

    // ============================================
    // Repository - Register as Lazy Singleton
    // ============================================
    _sl.registerLazySingleton<DashboardRepository>(
      () => DashboardRepositoryImpl(remoteDataSource: _sl()),
    );

    // ============================================
    // Data Sources - Register as Lazy Singleton
    // ============================================
    _sl.registerLazySingleton<DashboardRemoteDataSource>(
      () => DashboardRemoteDataSourceImpl(dio: _sl<DioClient>().dio),
    );
  }
}
