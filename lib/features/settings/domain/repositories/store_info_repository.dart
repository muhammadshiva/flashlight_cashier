import 'package:dartz/dartz.dart';
import 'package:flashlight_pos/core/error/failures.dart';
import 'package:flashlight_pos/features/settings/data/models/get_store_info_params.dart';
import 'package:flashlight_pos/features/settings/domain/entities/store_info.dart';

/// Repository interface for store information
abstract class StoreInfoRepository {
  Future<Either<Failure, StoreInfo>> getStoreInfo(GetStoreInfoParams params);
}
