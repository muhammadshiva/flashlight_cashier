import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/entities/vehicle.dart';
import '../../domain/usecases/vehicle_usecases.dart';

part 'vehicle_event.dart';
part 'vehicle_state.dart';

class VehicleBloc extends Bloc<VehicleEvent, VehicleState> {
  final GetVehicles getVehicles;
  final CreateVehicle createVehicle;
  final DeleteVehicle deleteVehicle;

  VehicleBloc({
    required this.getVehicles,
    required this.createVehicle,
    required this.deleteVehicle,
  }) : super(VehicleInitial()) {
    on<LoadVehicles>((event, emit) async {
      emit(VehicleLoading());
      final result = await getVehicles(NoParams());
      result.fold(
        (failure) => emit(VehicleError(failure.message)),
        (vehicles) => emit(VehicleLoaded(vehicles)),
      );
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
