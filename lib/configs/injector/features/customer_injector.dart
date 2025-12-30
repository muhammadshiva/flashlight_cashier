import 'package:get_it/get_it.dart';

import '../../../core/network/dio_client.dart';
import '../../../features/customer/data/datasources/customer_local_data_source.dart';
import '../../../features/customer/data/datasources/customer_remote_data_source.dart';
import '../../../features/customer/data/repositories/customer_repository_impl.dart';
import '../../../features/customer/domain/repositories/customer_repository.dart';
import '../../../features/customer/domain/usecases/get_customers.dart';
import '../../../features/customer/domain/usecases/get_customer.dart';
import '../../../features/customer/domain/usecases/create_customer.dart';
import '../../../features/customer/domain/usecases/update_customer.dart';
import '../../../features/customer/domain/usecases/delete_customer.dart';
import '../../../features/customer/presentation/bloc/customer_bloc.dart';
import '../../../features/customer/presentation/bloc/form/customer_form_bloc.dart';

final _sl = GetIt.instance;

/// Dependency injection configuration for the Customer feature.
///
/// Registers:
/// - BLoCs (Factory)
/// - Use Cases (Lazy Singleton)
/// - Repository (Lazy Singleton)
/// - Data Sources (Lazy Singleton)
///   - Remote: API calls
///   - Local: Hive caching for offline support
class CustomerInjector {
  static void init() {
    // ============================================
    // BLoCs - Register as Factory (new instance each time)
    // ============================================
    _sl.registerFactory<CustomerBloc>(
      () => CustomerBloc(
        getCustomers: _sl(),
        createCustomer: _sl(),
        updateCustomer: _sl(),
        deleteCustomer: _sl(),
      ),
    );

    // Form BLoCs - for form validation (separate from business logic)
    _sl.registerFactory<CustomerFormBloc>(
      () => CustomerFormBloc(),
    );

    // ============================================
    // Use Cases - Register as Lazy Singleton
    // ============================================
    _sl.registerLazySingleton<GetCustomers>(
      () => GetCustomers(_sl()),
    );

    _sl.registerLazySingleton<GetCustomer>(
      () => GetCustomer(_sl()),
    );

    _sl.registerLazySingleton<CreateCustomer>(
      () => CreateCustomer(_sl()),
    );

    _sl.registerLazySingleton<UpdateCustomer>(
      () => UpdateCustomer(_sl()),
    );

    _sl.registerLazySingleton<DeleteCustomer>(
      () => DeleteCustomer(_sl()),
    );

    // ============================================
    // Repository - Register as Lazy Singleton
    // ============================================
    _sl.registerLazySingleton<CustomerRepository>(
      () => CustomerRepositoryImpl(
        remoteDataSource: _sl(),
        localDataSource: _sl(),
        networkInfo: _sl(),
      ),
    );

    // ============================================
    // Data Sources - Register as Lazy Singleton
    // ============================================

    // Remote Data Source - API calls
    _sl.registerLazySingleton<CustomerRemoteDataSource>(
      () => CustomerRemoteDataSourceImpl(dio: _sl<DioClient>().dio),
    );

    // Local Data Source - Hive caching for offline support
    _sl.registerLazySingleton<CustomerLocalDataSource>(
      () => CustomerLocalDataSourceImpl(),
    );
  }
}
