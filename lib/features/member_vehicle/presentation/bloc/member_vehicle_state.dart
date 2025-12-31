import 'package:equatable/equatable.dart';
import '../../domain/entities/member_vehicle.dart';

/// Base class for member vehicle states.
abstract class MemberVehicleState extends Equatable {
  const MemberVehicleState();

  @override
  List<Object?> get props => [];
}

/// Initial state when the BLoC is created.
class MemberVehicleInitial extends MemberVehicleState {}

/// State when member vehicles are being loaded.
class MemberVehicleLoading extends MemberVehicleState {}

/// State when member vehicles have been successfully loaded.
class MemberVehicleLoaded extends MemberVehicleState {
  final List<MemberVehicle> vehicles;

  const MemberVehicleLoaded(this.vehicles);

  @override
  List<Object?> get props => [vehicles];
}

/// State when an error occurs.
class MemberVehicleError extends MemberVehicleState {
  final String message;

  const MemberVehicleError(this.message);

  @override
  List<Object?> get props => [message];
}

/// State when an operation (create, update, delete) is successful.
class MemberVehicleOperationSuccess extends MemberVehicleState {
  final String message;

  const MemberVehicleOperationSuccess(this.message);

  @override
  List<Object?> get props => [message];
}
