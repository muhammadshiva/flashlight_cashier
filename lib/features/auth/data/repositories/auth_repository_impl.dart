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
  Future<Either<Failure, AuthEntity>> login(String username, String password) async {
    try {
      final remoteAuth = await remoteDataSource.login(username, password);
      // Cache token
      await sharedPreferences.setString('auth_token', remoteAuth.data.accessToken);
      return Right(remoteAuth.toEntity());
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, AuthEntity>> signUp(
    String username,
    String fullName,
    String email,
    String password,
  ) async {
    try {
      final remoteAuth = await remoteDataSource.signUp(
        username,
        fullName,
        email,
        password,
      );
      // Cache token
      await sharedPreferences.setString('auth_token', remoteAuth.data.accessToken);
      return Right(remoteAuth.toEntity());
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
