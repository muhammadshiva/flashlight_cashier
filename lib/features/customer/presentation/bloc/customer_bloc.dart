import 'package:bloc/bloc.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/usecases/create_customer.dart';
import '../../domain/usecases/delete_customer.dart';
import '../../domain/usecases/get_customers.dart';
import 'customer_event.dart';
import 'customer_state.dart';

class CustomerBloc extends Bloc<CustomerEvent, CustomerState> {
  final GetCustomers getCustomers;
  final CreateCustomer createCustomer;
  final DeleteCustomer deleteCustomer;

  CustomerBloc({
    required this.getCustomers,
    required this.createCustomer,
    required this.deleteCustomer,
  }) : super(CustomerInitial()) {
    on<LoadCustomers>((event, emit) async {
      emit(CustomerLoading());
      final result = await getCustomers(NoParams());
      result.fold(
        (failure) => emit(CustomerError(failure.message)),
        (customers) => emit(CustomerLoaded(customers)),
      );
    });

    on<CreateCustomerEvent>((event, emit) async {
      emit(CustomerLoading());
      final result = await createCustomer(CreateCustomerParams(
        name: event.name,
        phoneNumber: event.phoneNumber,
        email: event.email,
      ));
      result.fold(
        (failure) => emit(CustomerError(failure.message)),
        (_) {
          emit(const CustomerOperationSuccess("Customer created successfully"));
          add(LoadCustomers()); // Reload list
        },
      );
    });

    on<DeleteCustomerEvent>((event, emit) async {
      emit(CustomerLoading());
      final result = await deleteCustomer(DeleteCustomerParams(id: event.id));
      result.fold(
        (failure) => emit(CustomerError(failure.message)),
        (_) {
          emit(const CustomerOperationSuccess("Customer deleted successfully"));
          add(LoadCustomers()); // Reload list
        },
      );
    });
  }
}
