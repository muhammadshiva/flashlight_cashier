import 'package:dartz/dartz.dart';
import 'package:flashlight_pos/core/error/failures.dart';
import 'package:flashlight_pos/features/profile/data/models/get_profile_params.dart';
import 'package:flashlight_pos/features/settings/domain/entities/store_info.dart';

/// Repository interface untuk profile
abstract class ProfileRepository {
  /// Mendapatkan profile/store info
  Future<Either<Failure, StoreInfo>> getProfile(GetProfileParams params);

  /// Update profile/store info
  Future<Either<Failure, StoreInfo>> updateProfile(UpdateProfileParams params);
}
