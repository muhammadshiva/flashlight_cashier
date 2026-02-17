import 'dart:async';

import 'package:bloc/bloc.dart';

import '../../../../core/pagination/pagination_params.dart';
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
      final result = await getCustomers(const GetCustomersParams(
        pagination: PaginationParams(page: 1, limit: 10),
        isPrototype: true,
      ));
      result.fold(
        (failure) => emit(CustomerError(failure.message)),
        (paginatedCustomers) {
          emit(CustomerLoaded(
            customers: paginatedCustomers.data,
            currentPage: paginatedCustomers.page,
            totalItems: paginatedCustomers.total,
            itemsPerPage: paginatedCustomers.limit,
          ));
        },
      );
    });

    on<SearchCustomersEvent>((event, emit) async {
      final query = event.query.trim();

      // Below minimum characters → reload all customers
      if (query.length < _minSearchLength) {
        add(LoadCustomers());
        return;
      }

      // Meets minimum → search via API
      emit(CustomerLoading());
      final result = await getCustomers(GetCustomersParams(
        pagination: const PaginationParams(page: 1, limit: 10),
        query: query,
        isPrototype: true,
      ));
      result.fold(
        (failure) => emit(CustomerError(failure.message)),
        (paginatedCustomers) {
          emit(CustomerLoaded(
            customers: paginatedCustomers.data,
            currentPage: paginatedCustomers.page,
            totalItems: paginatedCustomers.total,
            itemsPerPage: paginatedCustomers.limit,
          ));
        },
      );
    }, transformer: _debounce(const Duration(seconds: 1)));

    on<ChangePageEvent>((event, emit) async {
      emit(CustomerLoading());
      final result = await getCustomers(GetCustomersParams(
        pagination: PaginationParams(page: event.page, limit: 10),
        isPrototype: true,
      ));
      result.fold(
        (failure) => emit(CustomerError(failure.message)),
        (paginatedCustomers) {
          emit(CustomerLoaded(
            customers: paginatedCustomers.data,
            currentPage: paginatedCustomers.page,
            totalItems: paginatedCustomers.total,
            itemsPerPage: paginatedCustomers.limit,
          ));
        },
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

  /// Minimum characters required to trigger API search
  static const int _minSearchLength = 3;

  /// Pure-Dart debounce EventTransformer.
  /// Debounces the event stream so only the last event after [duration] is processed.
  EventTransformer<E> _debounce<E>(Duration duration) {
    return (events, mapper) {
      final controller = StreamController<E>();
      Timer? timer;

      events.listen(
        (event) {
          timer?.cancel();
          timer = Timer(duration, () => controller.add(event));
        },
        onDone: () {
          timer?.cancel();
          controller.close();
        },
      );

      return controller.stream.asyncExpand(mapper);
    };
  }
}
