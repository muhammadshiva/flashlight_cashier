part of 'vehicle_bloc.dart';

abstract class VehicleState extends Equatable {
  const VehicleState();
  @override
  List<Object> get props => [];
}

class VehicleInitial extends VehicleState {}

class VehicleLoading extends VehicleState {}

class VehicleLoaded extends VehicleState {
  final List<Vehicle> vehicles; // Current page items
  final List<Vehicle> allVehicles; // Filtered results
  final List<Vehicle> sourceVehicles; // Master list
  final int currentPage;
  final int totalItems;
  final int itemsPerPage;

  const VehicleLoaded({
    required this.vehicles,
    required this.allVehicles,
    required this.sourceVehicles,
    required this.currentPage,
    required this.totalItems,
    required this.itemsPerPage,
  });

  @override
  List<Object> get props => [
        vehicles,
        allVehicles,
        sourceVehicles,
        currentPage,
        totalItems,
        itemsPerPage
      ];
}

class VehicleError extends VehicleState {
  final String message;
  const VehicleError(this.message);
  @override
  List<Object> get props => [message];
}

class VehicleOperationSuccess extends VehicleState {
  final String message;
  const VehicleOperationSuccess(this.message);
  @override
  List<Object> get props => [message];
}
