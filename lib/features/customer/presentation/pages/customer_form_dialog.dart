import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../injection_container.dart';
import '../../domain/entities/customer.dart';
import '../bloc/customer_bloc.dart';
import '../bloc/customer_event.dart';
import '../bloc/customer_state.dart';

class CustomerFormDialog extends StatelessWidget {
  final Customer? customer;
  const CustomerFormDialog({super.key, this.customer});

  /// Show the customer form dialog. Returns `true` if a customer was created/updated.
  static Future<bool?> show(BuildContext context, {Customer? customer}) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (_) => CustomerFormDialog(customer: customer),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<CustomerBloc>(),
      child: _CustomerFormDialogContent(customer: customer),
    );
  }
}

class _CustomerFormDialogContent extends StatefulWidget {
  final Customer? customer;
  const _CustomerFormDialogContent({this.customer});

  @override
  State<_CustomerFormDialogContent> createState() =>
      _CustomerFormDialogContentState();
}

class _CustomerFormDialogContentState
    extends State<_CustomerFormDialogContent> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;

  bool get isEditMode => widget.customer != null;

  @override
  void initState() {
    super.initState();
    _nameController =
        TextEditingController(text: widget.customer?.name ?? '');
    _phoneController =
        TextEditingController(text: widget.customer?.phoneNumber ?? '');
    _emailController =
        TextEditingController(text: widget.customer?.email ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    if (_formKey.currentState!.validate()) {
      if (isEditMode) {
        final updatedCustomer = Customer(
          id: widget.customer!.id,
          name: _nameController.text,
          phoneNumber: _phoneController.text,
          email: _emailController.text,
        );
        context
            .read<CustomerBloc>()
            .add(UpdateCustomerEvent(updatedCustomer));
      } else {
        context.read<CustomerBloc>().add(
              CreateCustomerEvent(
                name: _nameController.text,
                phoneNumber: _phoneController.text,
                email: _emailController.text,
              ),
            );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CustomerBloc, CustomerState>(
      listener: (context, state) {
        if (state is CustomerOperationSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
          Navigator.pop(context, true);
        } else if (state is CustomerError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(state.message), backgroundColor: Colors.red),
          );
        }
      },
      child: Dialog(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        insetPadding:
            EdgeInsets.symmetric(horizontal: 40.w, vertical: 24.w),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16.r),
          child: ConstrainedBox(
            constraints:
                BoxConstraints(maxWidth: 900.w, maxHeight: 500.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildHeader(),
                const Divider(height: 1, color: Color(0xFFE2E8F0)),
                Flexible(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _buildSectionCard(
                            title: 'General Information',
                            children: [
                              _buildLabel('Full Name', isRequired: true),
                              TextFormField(
                                controller: _nameController,
                                decoration: _buildInputDecoration(
                                    hint: 'e.g. John Doe'),
                                validator: (v) => v!.isEmpty
                                    ? 'Name is required'
                                    : null,
                              ),
                              const SizedBox(height: 16),
                              Row(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        _buildLabel('Phone Number',
                                            isRequired: true),
                                        TextFormField(
                                          controller: _phoneController,
                                          decoration:
                                              _buildInputDecoration(
                                                  hint:
                                                      'e.g. 081234567890'),
                                          keyboardType:
                                              TextInputType.phone,
                                          validator: (v) => v!.isEmpty
                                              ? 'Phone is required'
                                              : null,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        _buildLabel('Email Address',
                                            isRequired: true),
                                        TextFormField(
                                          controller: _emailController,
                                          decoration:
                                              _buildInputDecoration(
                                                  hint:
                                                      'e.g. john@example.com'),
                                          keyboardType: TextInputType
                                              .emailAddress,
                                          validator: (v) => v!.isEmpty
                                              ? 'Email is required'
                                              : null,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const Divider(height: 1, color: Color(0xFFE2E8F0)),
                _buildFooter(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          Text(
            isEditMode ? 'Edit Customer' : 'New Customer',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1E293B),
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.close, color: Color(0xFF64748B)),
            splashRadius: 20,
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          OutlinedButton(
            onPressed: () => Navigator.pop(context),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                  horizontal: 24, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              side: const BorderSide(color: Color(0xFFE2E8F0)),
            ),
            child: const Text(
              'Cancel',
              style: TextStyle(
                color: Color(0xFF64748B),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 12),
          ElevatedButton(
            onPressed: _onSubmit,
            style: ElevatedButton.styleFrom(
              elevation: 0,
              padding: const EdgeInsets.symmetric(
                  horizontal: 24, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              isEditMode ? 'Update Customer' : 'Save Customer',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionCard(
      {required String title, required List<Widget> children}) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 20),
          ...children,
        ],
      ),
    );
  }

  Widget _buildLabel(String label, {bool isRequired = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black54,
            ),
          ),
          if (isRequired)
            const Text(
              ' *',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFFEF4444),
              ),
            ),
        ],
      ),
    );
  }

  InputDecoration _buildInputDecoration(
      {String? hint, String? prefixText}) {
    return InputDecoration(
      hintText: hint,
      prefixText: prefixText,
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey[300]!),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey[300]!),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Theme.of(context).primaryColor),
      ),
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    );
  }
}
