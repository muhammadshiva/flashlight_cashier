import 'package:get_it/get_it.dart';

import '../../../features/profile/data/datasources/profile_remote_datasource.dart';
import '../../../features/profile/data/datasources/profile_remote_datasource_impl.dart';
import '../../../features/profile/data/repositories/profile_repository_impl.dart';
import '../../../features/profile/domain/repositories/profile_repository.dart';
import '../../../features/profile/domain/usecases/get_profile.dart';
import '../../../features/profile/domain/usecases/update_profile.dart';
import '../../../features/profile/presentation/cubit/profile_cubit.dart';

final _sl = GetIt.instance;

/// Dependency injection configuration for the Profile feature.
class ProfileInjector {
  static void init() {
    // ============================================
    // Cubits - Register as Factory
    // ============================================
    _sl.registerFactory<ProfileCubit>(
      () => ProfileCubit(
        getProfile: _sl(),
        updateProfile: _sl(),
      ),
    );

    // ============================================
    // Use Cases - Register as Lazy Singleton
    // ============================================
    _sl.registerLazySingleton<GetProfile>(
      () => GetProfile(_sl()),
    );

    _sl.registerLazySingleton<UpdateProfile>(
      () => UpdateProfile(_sl()),
    );

    // ============================================
    // Repository - Register as Lazy Singleton
    // ============================================
    _sl.registerLazySingleton<ProfileRepository>(
      () => ProfileRepositoryImpl(remoteDataSource: _sl()),
    );

    // ============================================
    // Data Sources - Register as Lazy Singleton
    // ============================================
    _sl.registerLazySingleton<ProfileRemoteDataSource>(
      () => ProfileRemoteDataSourceImpl(),
    );
  }
}
