import 'package:get_it/get_it.dart';

import '../../../core/network/dio_client.dart';
import '../../../features/user/data/datasources/user_remote_data_source.dart';
import '../../../features/user/data/repositories/user_repository_impl.dart';
import '../../../features/user/domain/repositories/user_repository.dart';
import '../../../features/user/domain/usecases/user_usecases.dart';
import '../../../features/user/presentation/bloc/user_bloc.dart';

final _sl = GetIt.instance;

/// Dependency injection configuration for the User feature.
class UserInjector {
  static void init() {
    // ============================================
    // BLoCs - Register as Factory
    // ============================================
    _sl.registerFactory<UserBloc>(
      () => UserBloc(
        getUsers: _sl(),
        createUser: _sl(),
        updateUser: _sl(),
        deleteUser: _sl(),
      ),
    );

    // ============================================
    // Use Cases - Register as Lazy Singleton
    // ============================================
    _sl.registerLazySingleton<GetUsers>(
      () => GetUsers(_sl()),
    );

    _sl.registerLazySingleton<CreateUser>(
      () => CreateUser(_sl()),
    );

    _sl.registerLazySingleton<UpdateUser>(
      () => UpdateUser(_sl()),
    );

    _sl.registerLazySingleton<DeleteUser>(
      () => DeleteUser(_sl()),
    );

    // ============================================
    // Repository - Register as Lazy Singleton
    // ============================================
    _sl.registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(remoteDataSource: _sl()),
    );

    // ============================================
    // Data Sources - Register as Lazy Singleton
    // ============================================
    _sl.registerLazySingleton<UserRemoteDataSource>(
      () => UserRemoteDataSourceImpl(dio: _sl<DioClient>().dio),
    );
  }
}
