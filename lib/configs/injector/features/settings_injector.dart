import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../features/settings/data/datasources/printer_datasource.dart';
import '../../../features/settings/data/datasources/settings_local_datasource.dart';
import '../../../features/settings/data/repositories/settings_repository_impl.dart';
import '../../../features/settings/domain/repositories/settings_repository.dart';
import '../../../features/settings/domain/usecases/connect_printer.dart';
import '../../../features/settings/domain/usecases/disconnect_printer.dart';
import '../../../features/settings/domain/usecases/get_app_settings.dart';
import '../../../features/settings/domain/usecases/scan_printers.dart';
import '../../../features/settings/domain/usecases/update_app_settings.dart';
import '../../../features/settings/domain/usecases/update_printer_settings.dart';
import '../../../features/settings/presentation/bloc/settings_bloc.dart';

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
    // Use Cases - Register as Lazy Singleton
    // ============================================
    _sl.registerLazySingleton<GetAppSettings>(
      () => GetAppSettings(_sl()),
    );

    _sl.registerLazySingleton<UpdateAppSettings>(
      () => UpdateAppSettings(_sl()),
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
  }
}
