import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../injection_container.dart';
import '../bloc/service_bloc.dart';

class ServiceListPage extends StatelessWidget {
  const ServiceListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ServiceBloc>()..add(LoadServices()),
      child: const ServiceListView(),
    );
  }
}

class ServiceListView extends StatelessWidget {
  const ServiceListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Services'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push('/services/new'),
          ),
        ],
      ),
      body: BlocConsumer<ServiceBloc, ServiceState>(
        listener: (context, state) {
          if (state is ServiceError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          if (state is ServiceLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ServiceLoaded) {
            return ListView.builder(
              itemCount: state.services.length,
              itemBuilder: (context, index) {
                final service = state.services[index];
                return ListTile(
                  title: Text(service.name),
                  subtitle: Text('${service.type} - \$${service.price}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      context
                          .read<ServiceBloc>()
                          .add(DeleteServiceEvent(service.id));
                    },
                  ),
                );
              },
            );
          }
          return const Center(child: Text('No services found'));
        },
      ),
    );
  }
}
