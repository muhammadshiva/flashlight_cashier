import 'package:get_it/get_it.dart';

import '../../../core/network/dio_client.dart';
import '../../../features/service/data/datasources/service_remote_data_source.dart';
import '../../../features/service/data/repositories/service_repository_impl.dart';
import '../../../features/service/domain/repositories/service_repository.dart';
import '../../../features/service/domain/usecases/service_usecases.dart';
import '../../../features/service/presentation/bloc/service_bloc.dart';

final _sl = GetIt.instance;

/// Dependency injection configuration for the Service feature.
class ServiceInjector {
  static void init() {
    // ============================================
    // BLoCs - Register as Factory
    // ============================================
    _sl.registerFactory<ServiceBloc>(
      () => ServiceBloc(
        getServices: _sl(),
        createService: _sl(),
        deleteService: _sl(),
      ),
    );

    // ============================================
    // Use Cases - Register as Lazy Singleton
    // ============================================
    _sl.registerLazySingleton<GetServices>(
      () => GetServices(_sl()),
    );

    _sl.registerLazySingleton<CreateService>(
      () => CreateService(_sl()),
    );

    _sl.registerLazySingleton<UpdateService>(
      () => UpdateService(_sl()),
    );

    _sl.registerLazySingleton<DeleteService>(
      () => DeleteService(_sl()),
    );

    // ============================================
    // Repository - Register as Lazy Singleton
    // ============================================
    _sl.registerLazySingleton<ServiceRepository>(
      () => ServiceRepositoryImpl(remoteDataSource: _sl()),
    );

    // ============================================
    // Data Sources - Register as Lazy Singleton
    // ============================================
    _sl.registerLazySingleton<ServiceRemoteDataSource>(
      () => ServiceRemoteDataSourceImpl(dio: _sl<DioClient>().dio),
    );
  }
}
