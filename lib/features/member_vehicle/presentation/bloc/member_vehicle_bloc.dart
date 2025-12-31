import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/usecases/member_vehicle_usecases.dart';
import 'member_vehicle_event.dart';
import 'member_vehicle_state.dart';

/// BLoC for managing member vehicle state.
class MemberVehicleBloc extends Bloc<MemberVehicleEvent, MemberVehicleState> {
  final GetMemberVehicles getMemberVehicles;
  final CreateMemberVehicle createMemberVehicle;
  final UpdateMemberVehicle updateMemberVehicle;
  final DeleteMemberVehicle deleteMemberVehicle;

  MemberVehicleBloc({
    required this.getMemberVehicles,
    required this.createMemberVehicle,
    required this.updateMemberVehicle,
    required this.deleteMemberVehicle,
  }) : super(MemberVehicleInitial()) {
    on<LoadMemberVehicles>(_onLoadMemberVehicles);
    on<CreateMemberVehicleEvent>(_onCreateMemberVehicle);
    on<UpdateMemberVehicleEvent>(_onUpdateMemberVehicle);
    on<DeleteMemberVehicleEvent>(_onDeleteMemberVehicle);
  }

  Future<void> _onLoadMemberVehicles(
    LoadMemberVehicles event,
    Emitter<MemberVehicleState> emit,
  ) async {
    emit(MemberVehicleLoading());
    final result = await getMemberVehicles(NoParams());
    result.fold(
      (failure) => emit(MemberVehicleError(failure.message)),
      (vehicles) => emit(MemberVehicleLoaded(vehicles)),
    );
  }

  Future<void> _onCreateMemberVehicle(
    CreateMemberVehicleEvent event,
    Emitter<MemberVehicleState> emit,
  ) async {
    emit(MemberVehicleLoading());
    final result = await createMemberVehicle(event.vehicle);
    result.fold(
      (failure) => emit(MemberVehicleError(failure.message)),
      (vehicle) {
        emit(const MemberVehicleOperationSuccess(
            "Member vehicle created successfully"));
        add(LoadMemberVehicles());
      },
    );
  }

  Future<void> _onUpdateMemberVehicle(
    UpdateMemberVehicleEvent event,
    Emitter<MemberVehicleState> emit,
  ) async {
    emit(MemberVehicleLoading());
    final result = await updateMemberVehicle(event.vehicle);
    result.fold(
      (failure) => emit(MemberVehicleError(failure.message)),
      (vehicle) {
        emit(const MemberVehicleOperationSuccess(
            "Member vehicle updated successfully"));
        add(LoadMemberVehicles());
      },
    );
  }

  Future<void> _onDeleteMemberVehicle(
    DeleteMemberVehicleEvent event,
    Emitter<MemberVehicleState> emit,
  ) async {
    emit(MemberVehicleLoading());
    final result = await deleteMemberVehicle(event.id);
    result.fold(
      (failure) => emit(MemberVehicleError(failure.message)),
      (_) {
        emit(const MemberVehicleOperationSuccess(
            "Member vehicle deleted successfully"));
        add(LoadMemberVehicles());
      },
    );
  }
}
