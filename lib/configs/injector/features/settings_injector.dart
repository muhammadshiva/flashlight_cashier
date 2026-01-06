import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/network/dio_client.dart';
import '../../../features/settings/data/datasources/printer_datasource.dart';
import '../../../features/settings/data/datasources/settings_local_datasource.dart';
import '../../../features/settings/data/datasources/store_info_remote_datasource.dart';
import '../../../features/settings/data/repositories/settings_repository_impl.dart';
import '../../../features/settings/data/repositories/store_info_repository_impl.dart';
import '../../../features/settings/domain/repositories/settings_repository.dart';
import '../../../features/settings/domain/repositories/store_info_repository.dart';
import '../../../features/settings/domain/usecases/connect_printer.dart';
import '../../../features/settings/domain/usecases/disconnect_printer.dart';
import '../../../features/settings/domain/usecases/get_app_settings.dart';
import '../../../features/settings/domain/usecases/get_printer_settings.dart';
import '../../../features/settings/domain/usecases/get_store_info.dart';
import '../../../features/settings/domain/usecases/scan_printers.dart';
import '../../../features/settings/domain/usecases/update_app_settings.dart';
import '../../../features/settings/domain/usecases/update_printer_settings.dart';
import '../../../features/settings/presentation/bloc/settings_bloc.dart';
import '../../../features/settings/presentation/cubit/printer_setting/printer_settings_cubit.dart';
import '../../../features/settings/presentation/cubit/store_info/store_info_cubit.dart';

final _sl = GetIt.instance;

/// Dependency injection configuration for the Settings feature.
///
/// Architecture: Opsi 3 (Hybrid BLoC + Cubit)
/// - SettingsBloc: HydratedBloc for data persistence
/// - SettingsUICubit: Cubit for UI state (created locally in dialog)
class SettingsInjector {
  static void init() {
    // ============================================
    // BLoCs - Register as Factory
    // ============================================
    _sl.registerFactory<SettingsBloc>(
      () => SettingsBloc(
        getAppSettings: _sl(),
        updateAppSettings: _sl(),
        scanPrinters: _sl(),
        connectPrinter: _sl(),
        disconnectPrinter: _sl(),
        updatePrinterSettings: _sl(),
      ),
    );

    // ============================================
    // Cubits - Register as Factory
    // ============================================
    _sl.registerFactory<PrinterSettingsCubit>(
      () => PrinterSettingsCubit(
        getPrinterSettings: _sl(),
        updatePrinterSettings: _sl(),
        scanPrinters: _sl(),
        connectPrinter: _sl(),
        disconnectPrinter: _sl(),
      ),
    );

    // ============================================
    // Use Cases - Register as Lazy Singleton
    // ============================================
    _sl.registerLazySingleton<GetAppSettings>(
      () => GetAppSettings(_sl()),
    );

    _sl.registerLazySingleton<UpdateAppSettings>(
      () => UpdateAppSettings(_sl()),
    );

    _sl.registerLazySingleton<GetPrinterSettings>(
      () => GetPrinterSettings(_sl()),
    );

    _sl.registerLazySingleton<ScanPrinters>(
      () => ScanPrinters(_sl()),
    );

    _sl.registerLazySingleton<ConnectPrinter>(
      () => ConnectPrinter(_sl()),
    );

    _sl.registerLazySingleton<DisconnectPrinter>(
      () => DisconnectPrinter(_sl()),
    );

    _sl.registerLazySingleton<UpdatePrinterSettings>(
      () => UpdatePrinterSettings(_sl()),
    );

    // ============================================
    // Repository - Register as Lazy Singleton
    // ============================================
    _sl.registerLazySingleton<SettingsRepository>(
      () => SettingsRepositoryImpl(
        localDataSource: _sl(),
        printerDataSource: _sl(),
      ),
    );

    // ============================================
    // Data Sources - Register as Lazy Singleton
    // ============================================
    _sl.registerLazySingleton<SettingsLocalDataSource>(
      () => SettingsLocalDataSourceImpl(
        sharedPreferences: _sl<SharedPreferences>(),
      ),
    );

    _sl.registerLazySingleton<PrinterDataSource>(
      () => PrinterDataSourceImpl(),
    );

    // ============================================
    // Store Info - Cubit, Use Case, Repository, Data Source
    // ============================================

    // Cubit
    _sl.registerFactory<StoreInfoCubit>(
      () => StoreInfoCubit(getStoreInfo: _sl()),
    );

    // Use Case
    _sl.registerLazySingleton<GetStoreInfo>(
      () => GetStoreInfo(_sl()),
    );

    // Repository
    _sl.registerLazySingleton<StoreInfoRepository>(
      () => StoreInfoRepositoryImpl(remoteDataSource: _sl()),
    );

    // Data Source
    _sl.registerLazySingleton<StoreInfoRemoteDataSource>(
      () => StoreInfoRemoteDataSourceImpl(dio: _sl<DioClient>().dio),
    );
  }
}
