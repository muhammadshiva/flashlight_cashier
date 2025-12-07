import 'package:equatable/equatable.dart';

abstract class CustomerEvent extends Equatable {
  const CustomerEvent();

  @override
  List<Object> get props => [];
}

class LoadCustomers extends CustomerEvent {}

class CreateCustomerEvent extends CustomerEvent {
  final String name;
  final String phoneNumber;
  final String email;

  const CreateCustomerEvent({
    required this.name,
    required this.phoneNumber,
    required this.email,
  });

  @override
  List<Object> get props => [name, phoneNumber, email];
}

class DeleteCustomerEvent extends CustomerEvent {
  final String id;

  const DeleteCustomerEvent(this.id);

  @override
  List<Object> get props => [id];
}
