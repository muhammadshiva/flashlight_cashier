import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/cache/secure_local_storage.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:talker_bloc_logger/talker_bloc_logger.dart';
import '../../core/network/dio_client.dart';
import '../../core/network/network_info.dart';
import 'features/auth_injector.dart';
import 'features/customer_injector.dart';
import 'features/membership_injector.dart';
import 'features/vehicle_injector.dart';
import 'features/member_vehicle_injector.dart';
import 'features/service_injector.dart';
import 'features/product_injector.dart';
import 'features/work_order_injector.dart';
import 'features/dashboard_injector.dart';
import 'features/user_injector.dart';
import 'features/report_injector.dart';

/// Global service locator instance.
final sl = GetIt.instance;

/// Initializes all dependencies in the application.
///
/// This should be called once at app startup, before runApp().
///
/// Registration order:
/// 1. External (SharedPreferences)
/// 2. Core services (SecureStorage, DioClient, NetworkInfo, BlocObserver)
/// 3. Feature dependencies (in any order)
Future<void> configureDependencies() async {
  // ============================================
  // External Dependencies
  // ============================================
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  // ============================================
  // Core Services
  // ============================================

  // Secure Storage (for sensitive data like tokens)
  sl.registerLazySingleton<SecureLocalStorage>(
    () => SecureLocalStorageImpl(),
  );

  // Network
  sl.registerLazySingleton<DioClient>(() => DioClient(sl(), sl()));
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());

  // Utilities
  final talker = TalkerFlutter.init();
  sl.registerLazySingleton<Talker>(() => talker);
  sl.registerLazySingleton<BlocObserver>(
      () => TalkerBlocObserver(talker: sl()));

  // ============================================
  // Feature Dependencies
  // ============================================
  AuthInjector.init();
  CustomerInjector.init();
  MembershipInjector.init();
  VehicleInjector.init();
  MemberVehicleInjector.init();
  ServiceInjector.init();
  ProductInjector.init();
  WorkOrderInjector.init();
  DashboardInjector.init();
  UserInjector.init();
  ReportInjector.init();
}

/// Resets all registrations - useful for testing.
Future<void> resetDependencies() async {
  await sl.reset();
}
