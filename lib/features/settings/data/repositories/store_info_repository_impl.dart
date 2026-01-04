import 'package:dartz/dartz.dart';
import 'package:flashlight_pos/core/error/failures.dart';
import 'package:flashlight_pos/features/settings/data/datasources/store_info_remote_datasource.dart';
import 'package:flashlight_pos/features/settings/data/models/get_store_info_params.dart';
import 'package:flashlight_pos/features/settings/domain/entities/store_info.dart';
import 'package:flashlight_pos/features/settings/domain/repositories/store_info_repository.dart';

class StoreInfoRepositoryImpl implements StoreInfoRepository {
  final StoreInfoRemoteDataSource remoteDataSource;

  StoreInfoRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, StoreInfo>> getStoreInfo(
      GetStoreInfoParams params) async {
    try {
      final result = await remoteDataSource.getStoreInfo(params);
      return Right(result.toEntity());
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
