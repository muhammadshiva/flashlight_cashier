import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../injection_container.dart';
import '../bloc/customer_bloc.dart';
import '../bloc/customer_event.dart';
import '../bloc/customer_state.dart';

class CustomerFormPage extends StatelessWidget {
  const CustomerFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<CustomerBloc>(),
      child: const CustomerFormView(),
    );
  }
}

class CustomerFormView extends StatefulWidget {
  const CustomerFormView({super.key});

  @override
  State<CustomerFormView> createState() => _CustomerFormViewState();
}

class _CustomerFormViewState extends State<CustomerFormView> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    if (_formKey.currentState!.validate()) {
      context.read<CustomerBloc>().add(
            CreateCustomerEvent(
              name: _nameController.text,
              phoneNumber: _phoneController.text,
              email: _emailController.text,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New Customer')),
      body: BlocListener<CustomerBloc, CustomerState>(
        listener: (context, state) {
          if (state is CustomerOperationSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
            context.pop(); // Go back to list
          } else if (state is CustomerError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                  validator: (v) => v!.isEmpty ? 'Required' : null,
                ),
                TextFormField(
                  controller: _phoneController,
                  decoration: const InputDecoration(labelText: 'Phone'),
                  validator: (v) => v!.isEmpty ? 'Required' : null,
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator: (v) => v!.isEmpty ? 'Required' : null,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _onSubmit,
                  child: const Text('Save Customer'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
