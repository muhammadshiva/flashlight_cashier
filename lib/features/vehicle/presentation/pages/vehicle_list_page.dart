import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../injection_container.dart';
import '../bloc/vehicle_bloc.dart';

class VehicleListPage extends StatelessWidget {
  const VehicleListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<VehicleBloc>()..add(LoadVehicles()),
      child: const VehicleListView(),
    );
  }
}

class VehicleListView extends StatelessWidget {
  const VehicleListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vehicles'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push('/vehicles/new'),
          ),
        ],
      ),
      body: BlocConsumer<VehicleBloc, VehicleState>(
        listener: (context, state) {
          if (state is VehicleError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          if (state is VehicleLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is VehicleLoaded) {
            return ListView.builder(
              itemCount: state.vehicles.length,
              itemBuilder: (context, index) {
                final vehicle = state.vehicles[index];
                return ListTile(
                  title:
                      Text('${vehicle.vehicleBrand} - ${vehicle.licensePlate}'),
                  subtitle: Text(vehicle.vehicleCategory),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      context
                          .read<VehicleBloc>()
                          .add(DeleteVehicleEvent(vehicle.id));
                    },
                  ),
                );
              },
            );
          }
          return const Center(child: Text('No vehicles found'));
        },
      ),
    );
  }
}
