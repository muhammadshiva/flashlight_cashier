import 'package:flashlight_pos/features/profile/data/models/get_profile_params.dart';
import 'package:flashlight_pos/features/settings/data/models/store_info_model.dart';

/// Remote Data Source untuk Profile
abstract class ProfileRemoteDataSource {
  /// Mendapatkan profile/store info
  Future<StoreInfoModel> getProfile(GetProfileParams params);

  /// Update profile/store info
  Future<StoreInfoModel> updateProfile(UpdateProfileParams params);
}
