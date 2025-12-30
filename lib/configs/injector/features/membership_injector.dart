import 'package:get_it/get_it.dart';

import '../../../core/network/dio_client.dart';
import '../../../features/membership/data/datasources/membership_remote_data_source.dart';
import '../../../features/membership/data/repositories/membership_repository_impl.dart';
import '../../../features/membership/domain/repositories/membership_repository.dart';
import '../../../features/membership/domain/usecases/membership_usecases.dart';
import '../../../features/membership/presentation/bloc/membership_bloc.dart';

final _sl = GetIt.instance;

/// Dependency injection configuration for the Membership feature.
class MembershipInjector {
  static void init() {
    // ============================================
    // BLoCs - Register as Factory
    // ============================================
    _sl.registerFactory<MembershipBloc>(
      () => MembershipBloc(
        getMemberships: _sl(),
        createMembership: _sl(),
        deleteMembership: _sl(),
      ),
    );

    // ============================================
    // Use Cases - Register as Lazy Singleton
    // ============================================
    _sl.registerLazySingleton<GetMemberships>(
      () => GetMemberships(_sl()),
    );

    _sl.registerLazySingleton<CreateMembership>(
      () => CreateMembership(_sl()),
    );

    _sl.registerLazySingleton<DeleteMembership>(
      () => DeleteMembership(_sl()),
    );

    _sl.registerLazySingleton<CheckMembershipStatus>(
      () => CheckMembershipStatus(_sl()),
    );

    _sl.registerLazySingleton<UpdateMembership>(
      () => UpdateMembership(_sl()),
    );

    // ============================================
    // Repository - Register as Lazy Singleton
    // ============================================
    _sl.registerLazySingleton<MembershipRepository>(
      () => MembershipRepositoryImpl(remoteDataSource: _sl()),
    );

    // ============================================
    // Data Sources - Register as Lazy Singleton
    // ============================================
    _sl.registerLazySingleton<MembershipRemoteDataSource>(
      () => MembershipRemoteDataSourceImpl(dio: _sl<DioClient>().dio),
    );
  }
}
