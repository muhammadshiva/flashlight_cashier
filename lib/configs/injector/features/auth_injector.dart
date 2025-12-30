import 'package:get_it/get_it.dart';

import '../../../core/cache/secure_local_storage.dart';
import '../../../core/network/dio_client.dart';
import '../../../features/auth/data/datasources/auth_local_data_source.dart';
import '../../../features/auth/data/datasources/auth_remote_data_source.dart';
import '../../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../../features/auth/domain/repositories/auth_repository.dart';
import '../../../features/auth/domain/usecases/login_usecase.dart';
import '../../../features/auth/domain/usecases/refresh_token_usecase.dart';
import '../../../features/auth/domain/usecases/get_profile_usecase.dart';
import '../../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../../features/auth/presentation/bloc/form/login_form_bloc.dart';

final _sl = GetIt.instance;

/// Dependency injection configuration for the Auth feature.
///
/// Registers:
/// - BLoCs (Factory)
/// - Use Cases (Lazy Singleton)
/// - Repository (Lazy Singleton)
/// - Data Sources (Lazy Singleton)
///   - Remote: API calls
///   - Local: Secure token storage and user caching
class AuthInjector {
  static void init() {
    // ============================================
    // BLoCs - Register as Factory (new instance each time)
    // ============================================
    _sl.registerFactory<AuthBloc>(
      () => AuthBloc(
        loginUseCase: _sl(),
        networkInfo: _sl(),
      ),
    );

    // Form BLoCs - for form validation (separate from business logic)
    _sl.registerFactory<LoginFormBloc>(
      () => LoginFormBloc(),
    );

    // ============================================
    // Use Cases - Register as Lazy Singleton
    // ============================================
    _sl.registerLazySingleton<LoginUseCase>(
      () => LoginUseCase(_sl()),
    );

    _sl.registerLazySingleton<RefreshTokenUseCase>(
      () => RefreshTokenUseCase(_sl()),
    );

    _sl.registerLazySingleton<GetProfileUseCase>(
      () => GetProfileUseCase(_sl()),
    );

    // ============================================
    // Repository - Register as Lazy Singleton
    // ============================================
    _sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(
        remoteDataSource: _sl(),
        localDataSource: _sl(),
        networkInfo: _sl(),
      ),
    );

    // ============================================
    // Data Sources - Register as Lazy Singleton
    // ============================================

    // Remote Data Source - API calls
    _sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(dio: _sl<DioClient>().dio),
    );

    // Local Data Source - Secure storage and Hive caching
    _sl.registerLazySingleton<AuthLocalDataSource>(
      () => AuthLocalDataSourceImpl(
        secureStorage: _sl<SecureLocalStorage>(),
      ),
    );
  }
}
