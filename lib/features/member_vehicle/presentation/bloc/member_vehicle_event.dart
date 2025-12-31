import 'package:equatable/equatable.dart';
import '../../domain/entities/member_vehicle.dart';

/// Base class for member vehicle events.
abstract class MemberVehicleEvent extends Equatable {
  const MemberVehicleEvent();

  @override
  List<Object?> get props => [];
}

/// Event to load all member vehicles.
class LoadMemberVehicles extends MemberVehicleEvent {}

/// Event to create a new member vehicle.
class CreateMemberVehicleEvent extends MemberVehicleEvent {
  final MemberVehicle vehicle;

  const CreateMemberVehicleEvent(this.vehicle);

  @override
  List<Object?> get props => [vehicle];
}

/// Event to update an existing member vehicle.
class UpdateMemberVehicleEvent extends MemberVehicleEvent {
  final MemberVehicle vehicle;

  const UpdateMemberVehicleEvent(this.vehicle);

  @override
  List<Object?> get props => [vehicle];
}

/// Event to delete a member vehicle.
class DeleteMemberVehicleEvent extends MemberVehicleEvent {
  final String id;

  const DeleteMemberVehicleEvent(this.id);

  @override
  List<Object?> get props => [id];
}
