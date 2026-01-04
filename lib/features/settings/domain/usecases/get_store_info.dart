import 'package:dartz/dartz.dart';
import 'package:flashlight_pos/core/error/failures.dart';
import 'package:flashlight_pos/core/usecase/usecase.dart';
import 'package:flashlight_pos/features/settings/data/models/get_store_info_params.dart';
import 'package:flashlight_pos/features/settings/domain/entities/store_info.dart';
import 'package:flashlight_pos/features/settings/domain/repositories/store_info_repository.dart';

/// Use case for getting store information
class GetStoreInfo implements UseCase<StoreInfo, GetStoreInfoParams> {
  final StoreInfoRepository repository;

  GetStoreInfo(this.repository);

  @override
  Future<Either<Failure, StoreInfo>> call(GetStoreInfoParams params) async {
    return await repository.getStoreInfo(params);
  }
}
