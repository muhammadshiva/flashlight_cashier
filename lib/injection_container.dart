import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/network/dio_client.dart';
import 'features/auth/data/datasources/auth_remote_data_source.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/auth/domain/usecases/login_usecase.dart';
import 'features/auth/domain/usecases/refresh_token_usecase.dart';
import 'features/auth/domain/usecases/get_profile_usecase.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/customer/data/datasources/customer_remote_data_source.dart';
import 'features/customer/data/repositories/customer_repository_impl.dart';
import 'features/customer/domain/repositories/customer_repository.dart';
import 'features/customer/domain/usecases/create_customer.dart';
import 'features/customer/domain/usecases/delete_customer.dart';
import 'features/customer/domain/usecases/get_customers.dart';
import 'features/customer/domain/usecases/get_customer.dart';
import 'features/customer/domain/usecases/update_customer.dart';
import 'features/customer/presentation/bloc/customer_bloc.dart';
import 'features/membership/data/datasources/membership_remote_data_source.dart';
import 'features/membership/data/repositories/membership_repository_impl.dart';
import 'features/membership/domain/repositories/membership_repository.dart';
import 'features/membership/domain/usecases/membership_usecases.dart';
import 'features/membership/presentation/bloc/membership_bloc.dart';
import 'features/vehicle/data/datasources/vehicle_remote_data_source.dart';
import 'features/vehicle/data/repositories/vehicle_repository_impl.dart';
import 'features/vehicle/domain/repositories/vehicle_repository.dart';
import 'features/vehicle/domain/usecases/vehicle_usecases.dart';
import 'features/service/data/datasources/service_remote_data_source.dart';
import 'features/service/data/repositories/service_repository_impl.dart';
import 'features/service/domain/repositories/service_repository.dart';
import 'features/service/domain/usecases/service_usecases.dart';
import 'features/service/presentation/bloc/service_bloc.dart';
import 'features/product/data/datasources/product_remote_data_source.dart';
import 'features/product/data/repositories/product_repository_impl.dart';
import 'features/product/domain/repositories/product_repository.dart';
import 'features/product/domain/usecases/product_usecases.dart';
import 'features/product/domain/usecases/update_product.dart';
import 'features/product/presentation/bloc/product_bloc.dart';

import 'features/vehicle/presentation/bloc/vehicle_bloc.dart';
import 'features/work_order/data/datasources/work_order_remote_data_source.dart';
import 'features/work_order/data/repositories/work_order_repository_impl.dart';
import 'features/work_order/domain/repositories/work_order_repository.dart';

import 'features/work_order/domain/usecases/work_order_usecases.dart';
import 'features/work_order/domain/usecases/update_work_order_status.dart';
import 'features/work_order/presentation/bloc/pos_bloc.dart';
import 'features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'features/history/presentation/bloc/history_bloc.dart';
import 'features/work_order/domain/usecases/get_work_order.dart';
import 'features/work_order/presentation/bloc/detail/work_order_detail_bloc.dart';
import 'features/user/data/datasources/user_remote_data_source.dart';
import 'features/user/data/repositories/user_repository_impl.dart';
import 'features/user/domain/repositories/user_repository.dart';
import 'features/user/domain/usecases/user_usecases.dart';
import 'features/user/presentation/bloc/user_bloc.dart';
import 'features/report/presentation/bloc/reports_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => DioClient(sl()));

  //! Core
  // Network, etc.

  //! Features - Auth
  // Bloc
  sl.registerFactory(() => AuthBloc(loginUseCase: sl()));

  // Use cases
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => RefreshTokenUseCase(sl()));
  sl.registerLazySingleton(() => GetProfileUseCase(sl()));

  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: sl(), sharedPreferences: sl()),
  );

  // Data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(dio: sl<DioClient>().dio),
  );

  //! Features - Customer
  // Bloc
  sl.registerFactory(
    () => CustomerBloc(
      getCustomers: sl(),
      createCustomer: sl(),
      updateCustomer: sl(),
      deleteCustomer: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetCustomers(sl()));
  sl.registerLazySingleton(() => GetCustomer(sl()));
  sl.registerLazySingleton(() => CreateCustomer(sl()));
  sl.registerLazySingleton(() => UpdateCustomer(sl()));
  sl.registerLazySingleton(() => DeleteCustomer(sl()));

  // Repository
  sl.registerLazySingleton<CustomerRepository>(
    () => CustomerRepositoryImpl(remoteDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<CustomerRemoteDataSource>(
    () => CustomerRemoteDataSourceImpl(dio: sl<DioClient>().dio),
  );

  //! Features - Membership
  // Bloc
  sl.registerFactory(
    () => MembershipBloc(
      getMemberships: sl(),
      createMembership: sl(),
      deleteMembership: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetMemberships(sl()));
  sl.registerLazySingleton(() => CreateMembership(sl()));
  sl.registerLazySingleton(() => DeleteMembership(sl()));
  sl.registerLazySingleton(() => CheckMembershipStatus(sl()));
  sl.registerLazySingleton(() => UpdateMembership(sl()));

  // Repository
  sl.registerLazySingleton<MembershipRepository>(
    () => MembershipRepositoryImpl(remoteDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<MembershipRemoteDataSource>(
    () => MembershipRemoteDataSourceImpl(dio: sl<DioClient>().dio),
  );

  //! Features - Vehicle
  // Bloc
  sl.registerFactory(
    () => VehicleBloc(
      getVehicles: sl(),
      createVehicle: sl(),
      updateVehicle: sl(),
      deleteVehicle: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetVehicles(sl()));
  sl.registerLazySingleton(() => CreateVehicle(sl()));
  sl.registerLazySingleton(() => UpdateVehicle(sl()));
  sl.registerLazySingleton(() => DeleteVehicle(sl()));

  // Repository
  sl.registerLazySingleton<VehicleRepository>(
    () => VehicleRepositoryImpl(remoteDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<VehicleRemoteDataSource>(
    () => VehicleRemoteDataSourceImpl(dio: sl<DioClient>().dio),
  );

  //! Features - Service
  // Bloc
  sl.registerFactory(
    () => ServiceBloc(
      getServices: sl(),
      createService: sl(),
      deleteService: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetServices(sl()));
  sl.registerLazySingleton(() => CreateService(sl()));
  sl.registerLazySingleton(() => DeleteService(sl()));

  // Repository
  sl.registerLazySingleton<ServiceRepository>(
    () => ServiceRepositoryImpl(remoteDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<ServiceRemoteDataSource>(
    () => ServiceRemoteDataSourceImpl(dio: sl<DioClient>().dio),
  );

  //! Features - Product
  // Bloc
  sl.registerFactory(
    () => ProductBloc(
      getProducts: sl(),
      createProduct: sl(),
      updateProduct: sl(),
      deleteProduct: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetProducts(sl()));
  sl.registerLazySingleton(() => CreateProduct(sl()));
  sl.registerLazySingleton(() => UpdateProduct(sl()));
  sl.registerLazySingleton(() => DeleteProduct(sl()));

  // Repository
  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(remoteDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<ProductRemoteDataSource>(
    () => ProductRemoteDataSourceImpl(dio: sl<DioClient>().dio),
  );

  //! Features - Work Order
  // Bloc
  sl.registerFactory(
    () => PosBloc(
      getCustomers: sl(),
      getVehicles: sl(),
      getServices: sl(),
      getProducts: sl(),
      createWorkOrder: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => CreateWorkOrder(sl()));
  sl.registerLazySingleton(() => GetWorkOrders(sl()));
  sl.registerLazySingleton(() => UpdateWorkOrderStatus(sl()));

  // Repository
  sl.registerLazySingleton<WorkOrderRepository>(
    () => WorkOrderRepositoryImpl(remoteDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<WorkOrderRemoteDataSource>(
    () => WorkOrderRemoteDataSourceImpl(dio: sl<DioClient>().dio),
  );
  // Dashboard
  sl.registerFactory(() => DashboardBloc(
        getWorkOrders: sl(),
        getCustomers: sl(),
        getVehicles: sl(),
        updateWorkOrderStatus: sl(),
      ));

  // History
  sl.registerFactory(() => HistoryBloc(
        getWorkOrders: sl(),
        getCustomers: sl(),
        getVehicles: sl(),
      ));

  sl.registerFactory(() => WorkOrderDetailBloc(
        getWorkOrder: sl(),
        updateWorkOrderStatus: sl(),
      ));
  sl.registerLazySingleton(() => GetWorkOrder(sl()));

  //! Features - User
  // Bloc
  sl.registerFactory(() => UserBloc(
        getUsers: sl(),
        createUser: sl(),
        updateUser: sl(),
        deleteUser: sl(),
      ));

  // Use cases
  sl.registerLazySingleton(() => GetUsers(sl()));
  sl.registerLazySingleton(() => CreateUser(sl()));
  sl.registerLazySingleton(() => UpdateUser(sl()));
  sl.registerLazySingleton(() => DeleteUser(sl()));

  // Repository
  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(remoteDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSourceImpl(dio: sl<DioClient>().dio),
  );

  //! Features - Reports
  sl.registerFactory(() => ReportsBloc(
        getWorkOrders: sl(),
        getServices: sl(),
      ));
}
