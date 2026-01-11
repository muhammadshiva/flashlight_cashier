import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/vehicle.dart';
import '../../domain/usecases/vehicle_usecases.dart';

part 'vehicle_event.dart';
part 'vehicle_state.dart';

class VehicleBloc extends Bloc<VehicleEvent, VehicleState> {
  final GetVehicles getVehicles;
  final CreateVehicle createVehicle;
  final UpdateVehicle updateVehicle;
  final DeleteVehicle deleteVehicle;

  VehicleBloc({
    required this.getVehicles,
    required this.createVehicle,
    required this.updateVehicle,
    required this.deleteVehicle,
  }) : super(VehicleInitial()) {
    on<LoadVehicles>((event, emit) async {
      emit(VehicleLoading());
      final result = await getVehicles(const GetVehicleParams(isPrototype: true));
      result.fold(
        (failure) => emit(VehicleError(failure.message)),
        (vehicles) {
          const itemsPerPage = 10;
          final totalItems = vehicles.length;
          final paginatedVehicles = vehicles.take(itemsPerPage).toList();

          emit(VehicleLoaded(
            vehicles: paginatedVehicles,
            allVehicles: vehicles, // Initial list is full list
            sourceVehicles: vehicles, // Master source
            currentPage: 1,
            totalItems: totalItems,
            itemsPerPage: itemsPerPage,
          ));
        },
      );
    });

    on<ChangePageEvent>((event, emit) {
      if (state is VehicleLoaded) {
        final currentState = state as VehicleLoaded;
        final allVehicles = currentState.allVehicles;
        final itemsPerPage = currentState.itemsPerPage;

        final startIndex = (event.page - 1) * itemsPerPage;
        if (startIndex >= allVehicles.length) return;

        final endIndex = (startIndex + itemsPerPage) > allVehicles.length
            ? allVehicles.length
            : startIndex + itemsPerPage;

        final paginatedVehicles = allVehicles.sublist(startIndex, endIndex);

        emit(VehicleLoaded(
          vehicles: paginatedVehicles,
          allVehicles: allVehicles,
          sourceVehicles: currentState.sourceVehicles,
          currentPage: event.page,
          totalItems: allVehicles.length,
          itemsPerPage: itemsPerPage,
        ));
      }
    });

    on<SearchVehiclesEvent>((event, emit) {
      if (state is VehicleLoaded) {
        final currentState = state as VehicleLoaded;
        final source = currentState.sourceVehicles;

        final query = event.query.toLowerCase();
        final filtered = query.isEmpty
            ? source
            : source
                .where((v) =>
                    v.licensePlate.toLowerCase().contains(query) ||
                    v.vehicleBrand.toLowerCase().contains(query) ||
                    v.vehicleCategory.toLowerCase().contains(query) ||
                    v.id.toLowerCase().contains(query))
                .toList();

        const itemsPerPage = 10;
        final totalItems = filtered.length;
        // Reset to page 1
        final paginatedVehicles = filtered.take(itemsPerPage).toList();

        emit(VehicleLoaded(
          vehicles: paginatedVehicles,
          allVehicles: filtered, // Working set is now filtered
          sourceVehicles: source, // Keep master source
          currentPage: 1,
          totalItems: totalItems,
          itemsPerPage: itemsPerPage,
        ));
      }
    });

    on<CreateVehicleEvent>((event, emit) async {
      emit(VehicleLoading());
      final result = await createVehicle(event.vehicle);
      result.fold(
        (failure) => emit(VehicleError(failure.message)),
        (_) {
          emit(const VehicleOperationSuccess("Vehicle created"));
          add(LoadVehicles());
        },
      );
    });

    on<UpdateVehicleEvent>((event, emit) async {
      emit(VehicleLoading());
      final result = await updateVehicle(event.vehicle);
      result.fold(
        (failure) => emit(VehicleError(failure.message)),
        (_) {
          emit(const VehicleOperationSuccess("Vehicle updated"));
          add(LoadVehicles());
        },
      );
    });

    on<DeleteVehicleEvent>((event, emit) async {
      emit(VehicleLoading());
      final result = await deleteVehicle(event.id);
      result.fold(
        (failure) => emit(VehicleError(failure.message)),
        (_) {
          emit(const VehicleOperationSuccess("Vehicle deleted"));
          add(LoadVehicles());
        },
      );
    });
  }
}
