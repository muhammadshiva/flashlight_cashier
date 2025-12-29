import 'package:equatable/equatable.dart';
import '../../domain/entities/customer.dart';

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

class UpdateCustomerEvent extends CustomerEvent {
  final Customer customer;

  const UpdateCustomerEvent(this.customer);

  @override
  List<Object> get props => [customer];
}

class ChangePageEvent extends CustomerEvent {
  final int page;
  const ChangePageEvent(this.page);
  @override
  List<Object> get props => [page];
}

class SearchCustomersEvent extends CustomerEvent {
  final String query;
  const SearchCustomersEvent(this.query);
  @override
  List<Object> get props => [query];
}
