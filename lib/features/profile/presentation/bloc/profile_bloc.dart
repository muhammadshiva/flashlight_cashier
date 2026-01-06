import 'package:flashlight_pos/features/profile/data/models/get_profile_params.dart';
import 'package:flashlight_pos/features/profile/domain/usecases/get_profile.dart';
import 'package:flashlight_pos/features/profile/domain/usecases/update_profile.dart';
import 'package:flashlight_pos/features/profile/presentation/bloc/profile_event.dart';
import 'package:flashlight_pos/features/profile/presentation/bloc/profile_state.dart';
import 'package:flashlight_pos/features/settings/domain/entities/store_info.dart';
import 'package:flashlight_pos/shared/models/ui_state_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Profile Bloc untuk mengelola state profile
/// Menggunakan pattern Bloc dengan events dan states terpisah
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetProfile getProfile;
  final UpdateProfile updateProfile;

  ProfileBloc({
    required this.getProfile,
    required this.updateProfile,
  }) : super(const ProfileState(profileState: UIStateModel<StoreInfo>.idle())) {
    on<FetchProfileEvent>(_onFetchProfile);
    on<UpdateProfileEvent>(_onUpdateProfile);
  }

  Future<void> _onFetchProfile(FetchProfileEvent event, Emitter<ProfileState> emit) async {
    emit(const ProfileState(profileState: UIStateModel<StoreInfo>.loading()));

    final result = await getProfile(GetProfileParams(isPrototype: event.isPrototype));

    result.fold(
      (failure) => emit(ProfileState(
        profileState: UIStateModel<StoreInfo>.error(message: failure.toString()),
      )),
      (storeInfo) => emit(ProfileState(
        profileState: UIStateModel<StoreInfo>.success(data: storeInfo),
      )),
    );
  }

  Future<void> _onUpdateProfile(UpdateProfileEvent event, Emitter<ProfileState> emit) async {
    emit(const ProfileState(profileState: UIStateModel<StoreInfo>.loading()));

    final result = await updateProfile(event.params);

    result.fold(
      (failure) => emit(ProfileState(
        profileState: UIStateModel<StoreInfo>.error(message: failure.toString()),
      )),
      (storeInfo) => emit(ProfileState(
        profileState: UIStateModel<StoreInfo>.success(data: storeInfo),
      )),
    );
  }
}
