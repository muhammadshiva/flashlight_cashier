import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../injection_container.dart';
import '../../domain/entities/vehicle.dart';
import '../bloc/vehicle_bloc.dart';

class VehicleFormPage extends StatelessWidget {
  const VehicleFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<VehicleBloc>(),
      child: const VehicleFormView(),
    );
  }
}

class VehicleFormView extends StatefulWidget {
  const VehicleFormView({super.key});

  @override
  State<VehicleFormView> createState() => _VehicleFormViewState();
}

class _VehicleFormViewState extends State<VehicleFormView> {
  final _formKey = GlobalKey<FormState>();
  final _plateController = TextEditingController();
  final _brandController = TextEditingController();
  final _colorController = TextEditingController();
  final _specsController = TextEditingController();
  String _category = 'S';

  @override
  void dispose() {
    _plateController.dispose();
    _brandController.dispose();
    _colorController.dispose();
    _specsController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    if (_formKey.currentState!.validate()) {
      context.read<VehicleBloc>().add(
            CreateVehicleEvent(
              Vehicle(
                id: '',
                licensePlate: _plateController.text,
                vehicleBrand: _brandController.text,
                vehicleColor: _colorController.text,
                vehicleCategory: _category,
                vehicleSpecs: _specsController.text,
              ),
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New Vehicle')),
      body: BlocListener<VehicleBloc, VehicleState>(
        listener: (context, state) {
          if (state is VehicleOperationSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
            context.pop();
          } else if (state is VehicleError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                TextFormField(
                  controller: _plateController,
                  decoration: const InputDecoration(labelText: 'License Plate'),
                  validator: (v) => v!.isEmpty ? 'Required' : null,
                ),
                TextFormField(
                  controller: _brandController,
                  decoration: const InputDecoration(labelText: 'Brand'),
                  validator: (v) => v!.isEmpty ? 'Required' : null,
                ),
                TextFormField(
                  controller: _colorController,
                  decoration: const InputDecoration(labelText: 'Color'),
                  validator: (v) => v!.isEmpty ? 'Required' : null,
                ),
                DropdownButtonFormField<String>(
                  initialValue: _category,
                  decoration: const InputDecoration(labelText: 'Category'),
                  items: const [
                    DropdownMenuItem(value: 'S', child: Text('Small (S)')),
                    DropdownMenuItem(value: 'M', child: Text('Medium (M)')),
                    DropdownMenuItem(value: 'L', child: Text('Large (L)')),
                  ],
                  onChanged: (v) => setState(() => _category = v!),
                ),
                TextFormField(
                  controller: _specsController,
                  decoration: const InputDecoration(labelText: 'Specs'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _onSubmit,
                  child: const Text('Save Vehicle'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
