part of 'vehicle_bloc.dart';

abstract class VehicleEvent extends Equatable {
  const VehicleEvent();
  @override
  List<Object> get props => [];
}

class LoadVehicles extends VehicleEvent {}

class CreateVehicleEvent extends VehicleEvent {
  final Vehicle vehicle;
  const CreateVehicleEvent(this.vehicle);
  @override
  List<Object> get props => [vehicle];
}

class UpdateVehicleEvent extends VehicleEvent {
  final Vehicle vehicle;
  const UpdateVehicleEvent(this.vehicle);
  @override
  List<Object> get props => [vehicle];
}

class DeleteVehicleEvent extends VehicleEvent {
  final String id;
  const DeleteVehicleEvent(this.id);
  @override
  List<Object> get props => [id];
}

class ChangePageEvent extends VehicleEvent {
  final int page;
  const ChangePageEvent(this.page);
  @override
  List<Object> get props => [page];
}

class SearchVehiclesEvent extends VehicleEvent {
  final String query;
  const SearchVehiclesEvent(this.query);
  @override
  List<Object> get props => [query];
}
