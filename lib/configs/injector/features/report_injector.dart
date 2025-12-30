import 'package:get_it/get_it.dart';

import '../../../core/network/dio_client.dart';
import '../../../features/report/data/datasources/report_remote_data_source.dart';
import '../../../features/report/data/repositories/report_repository_impl.dart';
import '../../../features/report/domain/repositories/report_repository.dart';
import '../../../features/report/domain/usecases/generate_report.dart';
import '../../../features/report/presentation/bloc/reports_bloc.dart';

final _sl = GetIt.instance;

/// Dependency injection configuration for the Report feature.
class ReportInjector {
  static void init() {
    // ============================================
    // BLoCs - Register as Factory
    // ============================================
    _sl.registerFactory<ReportsBloc>(
      () => ReportsBloc(
        getWorkOrders: _sl(),
        getServices: _sl(),
      ),
    );

    // ============================================
    // Use Cases - Register as Lazy Singleton
    // ============================================
    _sl.registerLazySingleton<GenerateReport>(
      () => GenerateReport(_sl()),
    );

    // ============================================
    // Repository - Register as Lazy Singleton
    // ============================================
    _sl.registerLazySingleton<ReportRepository>(
      () => ReportRepositoryImpl(remoteDataSource: _sl()),
    );

    // ============================================
    // Data Sources - Register as Lazy Singleton
    // ============================================
    _sl.registerLazySingleton<ReportRemoteDataSource>(
      () => ReportRemoteDataSourceImpl(dio: _sl<DioClient>().dio),
    );
  }
}
