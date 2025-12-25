import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../injection_container.dart';
import '../../domain/entities/user.dart';
import '../bloc/user_bloc.dart';
import '../bloc/user_event.dart';
import '../bloc/user_state.dart';

class UserFormPage extends StatefulWidget {
  final User? user; // If null, create mode. If not null, edit mode.

  const UserFormPage({super.key, this.user});

  @override
  State<UserFormPage> createState() => _UserFormPageState();
}

class _UserFormPageState extends State<UserFormPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _usernameController;
  late TextEditingController _fullNameController;
  late TextEditingController _emailController;
  late TextEditingController _roleController; // Dropdown usually
  late TextEditingController _passwordController; // Only for Create

  bool get isEditMode => widget.user != null;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController(text: widget.user?.username ?? '');
    _fullNameController = TextEditingController(text: widget.user?.fullName ?? '');
    _emailController = TextEditingController(text: widget.user?.email ?? '');
    _roleController = TextEditingController(text: widget.user?.role ?? 'staff');
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _fullNameController.dispose();
    _emailController.dispose();
    _roleController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<UserBloc>(),
      child: BlocConsumer<UserBloc, UserState>(
        listener: (context, state) {
          if (state is UserOperationSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
            // Navigate back and force refresh of list if possible.
            // Since UserListPage uses BlocProvider(create: ... add(LoadUsers)), sticking back to it might not auto-refresh unless we pass a result or use a global Bus.
            // But since UserBloc creation in UserListPage does `..add(LoadUsers)`, re-entering the page will refresh.
            // For simply popping:
            context.pop();
          } else if (state is UserError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message), backgroundColor: Colors.red));
          }
        },
        builder: (context, state) {
          if (state is UserLoading) {
            return const Scaffold(body: Center(child: CircularProgressIndicator()));
          }
          return Scaffold(
            appBar: AppBar(
              title: Text(isEditMode ? 'Edit User' : 'Create User'),
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _usernameController,
                      decoration: const InputDecoration(labelText: 'Username'),
                      validator: (v) => v!.isEmpty ? 'Required' : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _fullNameController,
                      decoration: const InputDecoration(labelText: 'Full Name'),
                      validator: (v) => v!.isEmpty ? 'Required' : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(labelText: 'Email'),
                      validator: (v) => v!.isEmpty ? 'Required' : null,
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      initialValue:
                          _roleController.text.isNotEmpty ? _roleController.text : 'staff',
                      items: const [
                        DropdownMenuItem(value: 'staff', child: Text('Staff')),
                        DropdownMenuItem(value: 'admin', child: Text('Admin')),
                      ],
                      onChanged: (val) => setState(() => _roleController.text = val!),
                      decoration: const InputDecoration(labelText: 'Role'),
                    ),
                    const SizedBox(height: 16),
                    if (!isEditMode) ...[
                      TextFormField(
                        controller: _passwordController,
                        decoration: const InputDecoration(labelText: 'Password'),
                        obscureText: true,
                        validator: (v) => v!.isEmpty ? 'Required' : null,
                      ),
                      const SizedBox(height: 24),
                    ],
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          if (isEditMode) {
                            final updatedUser = User(
                              id: widget.user!.id,
                              username: _usernameController.text,
                              fullName: _fullNameController.text,
                              email: _emailController.text,
                              role: _roleController.text,
                              status: widget.user!.status,
                            );
                            context.read<UserBloc>().add(UpdateUserEvent(updatedUser));
                          } else {
                            final newUser = User(
                              id: '', // Server generated
                              username: _usernameController.text,
                              fullName: _fullNameController.text,
                              email: _emailController.text,
                              role: _roleController.text,
                              status: 'active',
                            );
                            context
                                .read<UserBloc>()
                                .add(CreateUserEvent(newUser, _passwordController.text));
                          }
                        }
                      },
                      child: Text(isEditMode ? 'Update' : 'Create'),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
