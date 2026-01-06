import 'package:equatable/equatable.dart';
import 'package:flashlight_pos/features/profile/data/models/get_profile_params.dart';

/// Base class untuk semua Profile events
abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

/// Event untuk mengambil profile
class FetchProfileEvent extends ProfileEvent {
  final bool isPrototype;

  const FetchProfileEvent({this.isPrototype = false});

  @override
  List<Object?> get props => [isPrototype];
}

/// Event untuk update profile
class UpdateProfileEvent extends ProfileEvent {
  final UpdateProfileParams params;

  const UpdateProfileEvent(this.params);

  @override
  List<Object?> get props => [params];
}
