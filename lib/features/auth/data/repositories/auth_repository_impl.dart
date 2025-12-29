import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/utils/repository_helper.dart';
import '../../domain/entities/auth_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final SharedPreferences sharedPreferences;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.sharedPreferences,
  });

  @override
  Future<Either<Failure, AuthEntity>> login(
      String username, String password) async {
    return RepositoryHelper.safeApiCall(() async {
      final remoteAuth = await remoteDataSource.login(username, password);
      // Cache tokens
      await sharedPreferences.setString(
          AppConstants.authTokenKey, remoteAuth.data.accessToken);
      await sharedPreferences.setString(
          AppConstants.refreshTokenKey, remoteAuth.data.refreshToken);
      return remoteAuth.toEntity();
    });
  }

  @override
  Future<Either<Failure, AuthEntity>> refreshToken(String refreshToken) async {
    return RepositoryHelper.safeApiCall(() async {
      final remoteAuth = await remoteDataSource.refreshToken(refreshToken);
      // Update cached tokens
      await sharedPreferences.setString(
          AppConstants.authTokenKey, remoteAuth.data.accessToken);
      await sharedPreferences.setString(
          AppConstants.refreshTokenKey, remoteAuth.data.refreshToken);
      return remoteAuth.toEntity();
    });
  }

  @override
  Future<Either<Failure, UserEntity>> getProfile() async {
    return RepositoryHelper.safeApiCall(() async {
      final userModel = await remoteDataSource.getProfile();
      return userModel.toEntity();
    });
  }
}
