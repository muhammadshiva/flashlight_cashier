import 'package:dartz/dartz.dart';
import 'package:flashlight_pos/core/error/failures.dart';
import 'package:flashlight_pos/core/usecase/usecase.dart';
import 'package:flashlight_pos/features/profile/data/models/get_profile_params.dart';
import 'package:flashlight_pos/features/profile/domain/repositories/profile_repository.dart';
import 'package:flashlight_pos/features/settings/domain/entities/store_info.dart';

/// Use case untuk mendapatkan profile
class GetProfile implements UseCase<StoreInfo, GetProfileParams> {
  final ProfileRepository repository;

  GetProfile(this.repository);

  @override
  Future<Either<Failure, StoreInfo>> call(GetProfileParams params) async {
    return await repository.getProfile(params);
  }
}
