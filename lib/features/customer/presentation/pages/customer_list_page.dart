import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../injection_container.dart';
import '../bloc/customer_bloc.dart';
import '../bloc/customer_event.dart';
import '../bloc/customer_state.dart';

class CustomerListPage extends StatelessWidget {
  const CustomerListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<CustomerBloc>()..add(LoadCustomers()),
      child: const CustomerListView(),
    );
  }
}

class CustomerListView extends StatelessWidget {
  const CustomerListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customers'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push('/customers/new'),
          ),
        ],
      ),
      body: BlocConsumer<CustomerBloc, CustomerState>(
        listener: (context, state) {
          if (state is CustomerError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          if (state is CustomerLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CustomerLoaded) {
            return ListView.builder(
              itemCount: state.customers.length,
              itemBuilder: (context, index) {
                final customer = state.customers[index];
                return ListTile(
                  title: Text(customer.name),
                  subtitle: Text(customer.phoneNumber),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      context
                          .read<CustomerBloc>()
                          .add(DeleteCustomerEvent(customer.id));
                    },
                  ),
                  onTap: () {
                    // Navigate to edit or details
                    // context.push('/customers/${customer.id}');
                  },
                );
              },
            );
          }
          return const Center(child: Text('No customers found'));
        },
      ),
    );
  }
}
