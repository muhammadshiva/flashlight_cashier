import 'package:dartz/dartz.dart';
import 'package:flashlight_pos/core/error/failures.dart';
import 'package:flashlight_pos/features/profile/data/datasources/profile_remote_datasource.dart';
import 'package:flashlight_pos/features/profile/data/models/get_profile_params.dart';
import 'package:flashlight_pos/features/profile/domain/repositories/profile_repository.dart';
import 'package:flashlight_pos/features/settings/domain/entities/store_info.dart';

/// Implementasi Repository untuk Profile
class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;

  ProfileRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, StoreInfo>> getProfile(GetProfileParams params) async {
    try {
      final result = await remoteDataSource.getProfile(params);
      return Right(result.toEntity());
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, StoreInfo>> updateProfile(UpdateProfileParams params) async {
    try {
      final result = await remoteDataSource.updateProfile(params);
      return Right(result.toEntity());
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
