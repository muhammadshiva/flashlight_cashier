import 'package:get_it/get_it.dart';

import '../../../core/network/dio_client.dart';
import '../../../features/vehicle/data/datasources/vehicle_remote_data_source.dart';
import '../../../features/vehicle/data/repositories/vehicle_repository_impl.dart';
import '../../../features/vehicle/domain/repositories/vehicle_repository.dart';
import '../../../features/vehicle/domain/usecases/vehicle_usecases.dart';
import '../../../features/vehicle/presentation/bloc/vehicle_bloc.dart';

final _sl = GetIt.instance;

/// Dependency injection configuration for the Vehicle feature.
class VehicleInjector {
  static void init() {
    // ============================================
    // BLoCs - Register as Factory
    // ============================================
    _sl.registerFactory<VehicleBloc>(
      () => VehicleBloc(
        getVehicles: _sl(),
        createVehicle: _sl(),
        updateVehicle: _sl(),
        deleteVehicle: _sl(),
      ),
    );

    // ============================================
    // Use Cases - Register as Lazy Singleton
    // ============================================
    _sl.registerLazySingleton<GetVehicles>(
      () => GetVehicles(_sl()),
    );

    _sl.registerLazySingleton<CreateVehicle>(
      () => CreateVehicle(_sl()),
    );

    _sl.registerLazySingleton<UpdateVehicle>(
      () => UpdateVehicle(_sl()),
    );

    _sl.registerLazySingleton<DeleteVehicle>(
      () => DeleteVehicle(_sl()),
    );

    // ============================================
    // Repository - Register as Lazy Singleton
    // ============================================
    _sl.registerLazySingleton<VehicleRepository>(
      () => VehicleRepositoryImpl(remoteDataSource: _sl()),
    );

    // ============================================
    // Data Sources - Register as Lazy Singleton
    // ============================================
    _sl.registerLazySingleton<VehicleRemoteDataSource>(
      () => VehicleRemoteDataSourceImpl(dio: _sl<DioClient>().dio),
    );
  }
}
