import 'package:flashlight_pos/features/profile/data/models/get_profile_params.dart';
import 'package:flashlight_pos/features/profile/domain/usecases/get_profile.dart';
import 'package:flashlight_pos/features/profile/domain/usecases/update_profile.dart';
import 'package:flashlight_pos/features/settings/domain/entities/store_info.dart';
import 'package:flashlight_pos/shared/models/ui_state_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Cubit untuk mengelola Profile
class ProfileCubit extends Cubit<UIStateModel<StoreInfo>> {
  final GetProfile getProfile;
  final UpdateProfile updateProfile;

  ProfileCubit({
    required this.getProfile,
    required this.updateProfile,
  }) : super(const UIStateModel.idle());

  /// Mendapatkan profile dari API atau dummy data
  Future<void> fetchProfile({bool isPrototype = false}) async {
    emit(const UIStateModel.loading());

    final params = GetProfileParams(isPrototype: isPrototype);
    final result = await getProfile(params);

    result.fold(
      (failure) => emit(UIStateModel.error(message: failure.toString())),
      (storeInfo) => emit(UIStateModel.success(data: storeInfo)),
    );
  }

  /// Update profile
  Future<void> updateProfileData({
    required String id,
    required String storeName,
    required String storeAddress,
    required String storePhone,
    required String storeEmail,
    String? storeLogo,
    String? storeWebsite,
    required String taxId,
    required String businessLicense,
  }) async {
    // Emit loading state
    emit(const UIStateModel.loading());

    final params = UpdateProfileParams(
      id: id,
      storeName: storeName,
      storeAddress: storeAddress,
      storePhone: storePhone,
      storeEmail: storeEmail,
      storeLogo: storeLogo,
      storeWebsite: storeWebsite,
      taxId: taxId,
      businessLicense: businessLicense,
      isPrototype: true,
    );

    final result = await updateProfile(params);

    result.fold(
      (failure) => emit(UIStateModel.error(message: failure.toString())),
      (storeInfo) => emit(UIStateModel.success(data: storeInfo)),
    );
  }
}
