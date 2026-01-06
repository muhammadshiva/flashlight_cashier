import 'package:dartz/dartz.dart';
import 'package:flashlight_pos/core/error/failures.dart';
import 'package:flashlight_pos/core/usecase/usecase.dart';
import 'package:flashlight_pos/features/profile/data/models/get_profile_params.dart';
import 'package:flashlight_pos/features/profile/domain/repositories/profile_repository.dart';
import 'package:flashlight_pos/features/settings/domain/entities/store_info.dart';

/// Use case untuk update profile
class UpdateProfile implements UseCase<StoreInfo, UpdateProfileParams> {
  final ProfileRepository repository;

  UpdateProfile(this.repository);

  @override
  Future<Either<Failure, StoreInfo>> call(UpdateProfileParams params) async {
    return await repository.updateProfile(params);
  }
}
