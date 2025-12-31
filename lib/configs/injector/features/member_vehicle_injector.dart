import 'package:get_it/get_it.dart';

import '../../../core/network/dio_client.dart';
import '../../../features/member_vehicle/data/datasources/member_vehicle_remote_data_source.dart';
import '../../../features/member_vehicle/data/repositories/member_vehicle_repository_impl.dart';
import '../../../features/member_vehicle/domain/repositories/member_vehicle_repository.dart';
import '../../../features/member_vehicle/domain/usecases/member_vehicle_usecases.dart';
import '../../../features/member_vehicle/presentation/bloc/member_vehicle_bloc.dart';

final _sl = GetIt.instance;

/// Dependency injection configuration for the Member Vehicle feature.
///
/// Registers:
/// - BLoCs (Factory)
/// - Use Cases (Lazy Singleton)
/// - Repository (Lazy Singleton)
/// - Data Sources (Lazy Singleton)
class MemberVehicleInjector {
  static void init() {
    // ============================================
    // BLoCs - Register as Factory
    // ============================================
    _sl.registerFactory<MemberVehicleBloc>(
      () => MemberVehicleBloc(
        getMemberVehicles: _sl(),
        createMemberVehicle: _sl(),
        updateMemberVehicle: _sl(),
        deleteMemberVehicle: _sl(),
      ),
    );

    // ============================================
    // Use Cases - Register as Lazy Singleton
    // ============================================
    _sl.registerLazySingleton<GetMemberVehicles>(
      () => GetMemberVehicles(_sl()),
    );

    _sl.registerLazySingleton<CreateMemberVehicle>(
      () => CreateMemberVehicle(_sl()),
    );

    _sl.registerLazySingleton<UpdateMemberVehicle>(
      () => UpdateMemberVehicle(_sl()),
    );

    _sl.registerLazySingleton<DeleteMemberVehicle>(
      () => DeleteMemberVehicle(_sl()),
    );

    // ============================================
    // Repository - Register as Lazy Singleton
    // ============================================
    _sl.registerLazySingleton<MemberVehicleRepository>(
      () => MemberVehicleRepositoryImpl(remoteDataSource: _sl()),
    );

    // ============================================
    // Data Sources - Register as Lazy Singleton
    // ============================================
    _sl.registerLazySingleton<MemberVehicleRemoteDataSource>(
      () => MemberVehicleRemoteDataSourceImpl(dio: _sl<DioClient>().dio),
    );
  }
}
