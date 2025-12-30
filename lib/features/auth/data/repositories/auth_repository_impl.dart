import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/utils/repository_helper.dart';
import '../../domain/entities/auth_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_data_source.dart';
import '../datasources/auth_remote_data_source.dart';

/// Implementation of [AuthRepository] that handles authentication operations
/// with offline support.
///
/// Uses:
/// - [NetworkInfo] to check connectivity before making API calls
/// - [AuthLocalDataSource] for secure token storage and user caching
/// - [AuthRemoteDataSource] for API calls
/// - [RepositoryHelper] for consistent error handling
///
/// Strategy:
/// - Login: Always requires network (security)
/// - Get Profile: Cache-first with network fallback when cache expired
/// - Logout: Always works (clears local data)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, AuthEntity>> login(
    String username,
    String password,
  ) async {
    return RepositoryHelper.safeApiCallWithNetworkCheck(
      networkInfo,
      () async {
        final remoteAuth = await remoteDataSource.login(username, password);

        // Cache tokens securely
        await localDataSource.saveTokens(
          accessToken: remoteAuth.data.accessToken,
          refreshToken: remoteAuth.data.refreshToken,
        );

        // Cache user profile
        final authEntity = remoteAuth.toEntity();
        await localDataSource.cacheUser(authEntity.user);

        return authEntity;
      },
    );
  }

  @override
  Future<Either<Failure, AuthEntity>> refreshToken(String refreshToken) async {
    return RepositoryHelper.safeApiCallWithNetworkCheck(
      networkInfo,
      () async {
        final remoteAuth = await remoteDataSource.refreshToken(refreshToken);

        // Update cached tokens securely
        await localDataSource.saveTokens(
          accessToken: remoteAuth.data.accessToken,
          refreshToken: remoteAuth.data.refreshToken,
        );

        // Update cached user profile
        final authEntity = remoteAuth.toEntity();
        await localDataSource.cacheUser(authEntity.user);

        return authEntity;
      },
    );
  }

  @override
  Future<Either<Failure, UserEntity>> getProfile() async {
    // Try to get from cache first if cache is valid
    if (await localDataSource.isUserCacheValid()) {
      final cachedUser = await localDataSource.getCachedUser();
      if (cachedUser != null) {
        return Right(cachedUser);
      }
    }

    // Check network connectivity
    if (!await networkInfo.isConnected) {
      // If offline, try to return cached user even if expired
      final cachedUser = await localDataSource.getCachedUser();
      if (cachedUser != null) {
        return Right(cachedUser);
      }
      return const Left(NetworkFailure());
    }

    // Fetch from remote and cache
    return RepositoryHelper.safeApiCall(
      () async {
        final userModel = await remoteDataSource.getProfile();
        final userEntity = userModel.toEntity();

        // Cache the user
        await localDataSource.cacheUser(userEntity);

        return userEntity;
      },
    );
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      // Clear all cached auth data
      await localDataSource.clearAll();
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  /// Gets the cached auth token if available.
  Future<String?> getCachedToken() async {
    return await localDataSource.getToken();
  }

  /// Gets the cached refresh token if available.
  Future<String?> getCachedRefreshToken() async {
    return await localDataSource.getRefreshToken();
  }

  /// Checks if user is authenticated (has a valid token cached).
  Future<bool> isAuthenticated() async {
    return await localDataSource.isAuthenticated();
  }
}
