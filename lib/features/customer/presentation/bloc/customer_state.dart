import 'package:equatable/equatable.dart';
import '../../domain/entities/customer.dart';

abstract class CustomerState extends Equatable {
  const CustomerState();

  @override
  List<Object> get props => [];
}

class CustomerInitial extends CustomerState {}

class CustomerLoading extends CustomerState {}

class CustomerLoaded extends CustomerState {
  final List<Customer> customers;
  final List<Customer> allCustomers;
  final List<Customer> sourceCustomers;
  final int currentPage;
  final int totalItems;
  final int itemsPerPage;

  const CustomerLoaded({
    required this.customers,
    required this.allCustomers,
    required this.sourceCustomers,
    this.currentPage = 1,
    this.totalItems = 0,
    this.itemsPerPage = 10,
  });

  @override
  List<Object> get props => [
        customers,
        allCustomers,
        sourceCustomers,
        currentPage,
        totalItems,
        itemsPerPage
      ];
}

class CustomerOperationSuccess extends CustomerState {
  final String message;

  const CustomerOperationSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class CustomerError extends CustomerState {
  final String message;

  const CustomerError(this.message);

  @override
  List<Object> get props => [message];
}
