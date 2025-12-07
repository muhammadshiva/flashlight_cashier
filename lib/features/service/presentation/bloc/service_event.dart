part of 'service_bloc.dart';

abstract class ServiceEvent extends Equatable {
  const ServiceEvent();
  @override
  List<Object> get props => [];
}

class LoadServices extends ServiceEvent {}

class CreateServiceEvent extends ServiceEvent {
  final ServiceEntity service;
  const CreateServiceEvent(this.service);
  @override
  List<Object> get props => [service];
}

class DeleteServiceEvent extends ServiceEvent {
  final String id;
  const DeleteServiceEvent(this.id);
  @override
  List<Object> get props => [id];
}
