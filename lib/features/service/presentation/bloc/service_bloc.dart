import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/service_entity.dart';
import '../../domain/usecases/service_usecases.dart';

part 'service_event.dart';
part 'service_state.dart';

class ServiceBloc extends Bloc<ServiceEvent, ServiceState> {
  final GetServices getServices;
  final CreateService createService;
  final DeleteService deleteService;

  ServiceBloc({
    required this.getServices,
    required this.createService,
    required this.deleteService,
  }) : super(ServiceInitial()) {
    on<LoadServices>((event, emit) async {
      emit(ServiceLoading());
      final result = await getServices(const GetServicesParams());
      result.fold(
        (failure) => emit(ServiceError(failure.message)),
        (paginatedServices) => emit(ServiceLoaded(paginatedServices.data)),
      );
    });

    on<CreateServiceEvent>((event, emit) async {
      emit(ServiceLoading());
      final result = await createService(event.service);
      result.fold(
        (failure) => emit(ServiceError(failure.message)),
        (_) {
          emit(const ServiceOperationSuccess("Service created"));
          add(LoadServices());
        },
      );
    });

    on<DeleteServiceEvent>((event, emit) async {
      emit(ServiceLoading());
      final result = await deleteService(event.id);
      result.fold(
        (failure) => emit(ServiceError(failure.message)),
        (_) {
          emit(const ServiceOperationSuccess("Service deleted"));
          add(LoadServices());
        },
      );
    });
  }
}
