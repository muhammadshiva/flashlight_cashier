import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/failures.dart';
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
    try {
      final remoteAuth = await remoteDataSource.login(username, password);
      // Cache tokens
      await sharedPreferences.setString(
          'auth_token', remoteAuth.data.accessToken);
      await sharedPreferences.setString(
          'refresh_token', remoteAuth.data.refreshToken);
      return Right(remoteAuth.toEntity());
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, AuthEntity>> refreshToken(String refreshToken) async {
    try {
      final remoteAuth = await remoteDataSource.refreshToken(refreshToken);
      // Update cached tokens
      await sharedPreferences.setString(
          'auth_token', remoteAuth.data.accessToken);
      await sharedPreferences.setString(
          'refresh_token', remoteAuth.data.refreshToken);
      return Right(remoteAuth.toEntity());
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getProfile() async {
    try {
      final userModel = await remoteDataSource.getProfile();
      return Right(userModel.toEntity());
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
