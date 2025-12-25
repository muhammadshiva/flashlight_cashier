import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../injection_container.dart';
import '../../domain/entities/membership.dart';
import '../bloc/membership_bloc.dart';

class MembershipFormPage extends StatelessWidget {
  const MembershipFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<MembershipBloc>(),
      child: const MembershipFormView(),
    );
  }
}

class MembershipFormView extends StatefulWidget {
  const MembershipFormView({super.key});

  @override
  State<MembershipFormView> createState() => _MembershipFormViewState();
}

class _MembershipFormViewState extends State<MembershipFormView> {
  final _formKey = GlobalKey<FormState>();
  final _customerIdController = TextEditingController();
  final _levelController = TextEditingController();
  String _type = 'member';

  @override
  void dispose() {
    _customerIdController.dispose();
    _levelController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    if (_formKey.currentState!.validate()) {
      context.read<MembershipBloc>().add(
            CreateMembershipEvent(
              Membership(
                id: '',
                customerId: _customerIdController.text,
                membershipType: _type,
                membershipLevel: _levelController.text,
                isActive: true,
              ),
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New Membership')),
      body: BlocListener<MembershipBloc, MembershipState>(
        listener: (context, state) {
          if (state is MembershipOperationSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
            context.pop();
          } else if (state is MembershipError) {
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
                  controller: _customerIdController,
                  decoration: const InputDecoration(labelText: 'Customer ID'),
                  validator: (v) => v!.isEmpty ? 'Required' : null,
                ),
                DropdownButtonFormField<String>(
                  initialValue: _type,
                  decoration: const InputDecoration(labelText: 'Type'),
                  items: const [
                    DropdownMenuItem(value: 'member', child: Text('Member')),
                    DropdownMenuItem(value: 'nonMember', child: Text('Non-Member')),
                  ],
                  onChanged: (v) => setState(() => _type = v!),
                ),
                TextFormField(
                  controller: _levelController,
                  decoration: const InputDecoration(labelText: 'Level'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _onSubmit,
                  child: const Text('Save Membership'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
