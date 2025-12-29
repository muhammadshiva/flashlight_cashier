import 'package:bloc/bloc.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/entities/customer.dart';
import '../../domain/usecases/create_customer.dart';
import '../../domain/usecases/delete_customer.dart';
import '../../domain/usecases/get_customers.dart';
import '../../domain/usecases/update_customer.dart';
import 'customer_event.dart';
import 'customer_state.dart';

class CustomerBloc extends Bloc<CustomerEvent, CustomerState> {
  final GetCustomers getCustomers;
  final CreateCustomer createCustomer;
  final UpdateCustomer updateCustomer;
  final DeleteCustomer deleteCustomer;

  CustomerBloc({
    required this.getCustomers,
    required this.createCustomer,
    required this.updateCustomer,
    required this.deleteCustomer,
  }) : super(CustomerInitial()) {
    on<LoadCustomers>((event, emit) async {
      emit(CustomerLoading());
      final result = await getCustomers(NoParams());
      result.fold(
        (failure) => emit(CustomerError(failure.message)),
        (customers) {
          emit(CustomerLoaded(
            customers: _paginate(customers, 1),
            allCustomers: customers,
            sourceCustomers: customers,
            currentPage: 1,
            totalItems: customers.length,
          ));
        },
      );
    });

    on<SearchCustomersEvent>((event, emit) async {
      final currentState = state;
      if (currentState is CustomerLoaded) {
        final query = event.query.toLowerCase();
        final filtered = currentState.allCustomers.where((customer) {
          return customer.name.toLowerCase().contains(query) ||
              customer.phoneNumber.contains(query) ||
              customer.email.toLowerCase().contains(query);
        }).toList();

        emit(CustomerLoaded(
          customers: _paginate(filtered, 1),
          allCustomers: currentState.allCustomers,
          sourceCustomers: filtered,
          currentPage: 1,
          totalItems: filtered.length,
        ));
      }
    });

    on<ChangePageEvent>((event, emit) async {
      final currentState = state;
      if (currentState is CustomerLoaded) {
        emit(CustomerLoaded(
          customers: _paginate(currentState.sourceCustomers, event.page),
          allCustomers: currentState.allCustomers,
          sourceCustomers: currentState.sourceCustomers,
          currentPage: event.page,
          totalItems: currentState.totalItems,
        ));
      }
    });

    on<CreateCustomerEvent>((event, emit) async {
      // emit(CustomerLoading()); // Skip loading to avoid flickering whole table if possible, but standard is loading
      // For now we do full reload as simplistic approach
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
          add(LoadCustomers());
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
          add(LoadCustomers());
        },
      );
    });

    on<UpdateCustomerEvent>((event, emit) async {
      emit(CustomerLoading());
      final result = await updateCustomer(event.customer);
      result.fold(
        (failure) => emit(CustomerError(failure.message)),
        (_) {
          emit(const CustomerOperationSuccess("Customer updated successfully"));
          add(LoadCustomers());
        },
      );
    });
  }

  List<Customer> _paginate(List<Customer> customers, int page,
      {int limit = 10}) {
    final startIndex = (page - 1) * limit;
    if (startIndex >= customers.length) return [];
    final endIndex = startIndex + limit;
    return customers.sublist(
        startIndex, endIndex > customers.length ? customers.length : endIndex);
  }
}
