import 'package:equatable/equatable.dart';
import 'package:flashlight_pos/features/settings/domain/entities/store_info.dart';
import 'package:flashlight_pos/shared/models/ui_state_model.dart';

/// Profile State menggunakan UIStateModel
class ProfileState extends Equatable {
  final UIStateModel<StoreInfo> profileState;

  const ProfileState({required this.profileState});

  @override
  List<Object?> get props => [profileState];

  ProfileState copyWith({UIStateModel<StoreInfo>? profileState}) {
    return ProfileState(
      profileState: profileState ?? this.profileState,
    );
  }
}
