import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../injection_container.dart';
import '../../domain/entities/service_entity.dart';
import '../bloc/service_bloc.dart';

class ServiceFormPage extends StatelessWidget {
  const ServiceFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ServiceBloc>(),
      child: const ServiceFormView(),
    );
  }
}

class ServiceFormView extends StatefulWidget {
  const ServiceFormView({super.key});

  @override
  State<ServiceFormView> createState() => _ServiceFormViewState();
}

class _ServiceFormViewState extends State<ServiceFormView> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descController = TextEditingController();
  final _priceController = TextEditingController();
  String _type = 'wash';

  @override
  void dispose() {
    _nameController.dispose();
    _descController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    if (_formKey.currentState!.validate()) {
      context.read<ServiceBloc>().add(
            CreateServiceEvent(
              ServiceEntity(
                id: '',
                name: _nameController.text,
                description: _descController.text,
                price: int.tryParse(_priceController.text) ?? 0,
                imageUrl: '',
                isDefault: false,
                isFavorite: false,
                type: _type,
                isActive: true,
              ),
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New Service')),
      body: BlocListener<ServiceBloc, ServiceState>(
        listener: (context, state) {
          if (state is ServiceOperationSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
            context.pop();
          } else if (state is ServiceError) {
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
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                  validator: (v) => v!.isEmpty ? 'Required' : null,
                ),
                TextFormField(
                  controller: _descController,
                  decoration: const InputDecoration(labelText: 'Description'),
                ),
                TextFormField(
                  controller: _priceController,
                  decoration: const InputDecoration(labelText: 'Price'),
                  keyboardType: TextInputType.number,
                  validator: (v) => v!.isEmpty ? 'Required' : null,
                ),
                DropdownButtonFormField<String>(
                  initialValue: _type,
                  decoration: const InputDecoration(labelText: 'Type'),
                  items: const [
                    DropdownMenuItem(value: 'wash', child: Text('Wash')),
                    DropdownMenuItem(value: 'wax', child: Text('Wax')),
                    DropdownMenuItem(value: 'detailing', child: Text('Detailing')),
                    DropdownMenuItem(value: 'premium', child: Text('Premium')),
                  ],
                  onChanged: (v) => setState(() => _type = v!),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _onSubmit,
                  child: const Text('Save Service'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
