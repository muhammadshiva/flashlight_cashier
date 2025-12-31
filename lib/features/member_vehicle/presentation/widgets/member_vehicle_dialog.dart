import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../configs/injector/injector_config.dart';
import '../../domain/entities/member_vehicle.dart';
import '../bloc/member_vehicle_bloc.dart';
import '../bloc/member_vehicle_event.dart';
import '../bloc/member_vehicle_state.dart';

/// Shows a dialog for creating or editing a member vehicle.
Future<bool?> showMemberVehicleDialog(
  BuildContext context, {
  MemberVehicle? vehicle,
  String? membershipId,
}) {
  return showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (context) => BlocProvider(
      create: (context) => sl<MemberVehicleBloc>(),
      child: MemberVehicleDialog(
        vehicle: vehicle,
        membershipId: membershipId,
      ),
    ),
  );
}

/// Dialog widget for creating or editing a member vehicle.
class MemberVehicleDialog extends StatefulWidget {
  final MemberVehicle? vehicle;
  final String? membershipId;

  const MemberVehicleDialog({
    super.key,
    this.vehicle,
    this.membershipId,
  });

  @override
  State<MemberVehicleDialog> createState() => _MemberVehicleDialogState();
}

class _MemberVehicleDialogState extends State<MemberVehicleDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _plateNumberController;
  late final TextEditingController _specsController;
  late final TextEditingController _iconController;

  bool get isEditing => widget.vehicle != null;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.vehicle?.name ?? '');
    _plateNumberController =
        TextEditingController(text: widget.vehicle?.plateNumber ?? '');
    _specsController = TextEditingController(text: widget.vehicle?.specs ?? '');
    _iconController = TextEditingController(text: widget.vehicle?.icon ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _plateNumberController.dispose();
    _specsController.dispose();
    _iconController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    final vehicle = MemberVehicle(
      id: widget.vehicle?.id ?? '',
      membershipId: widget.vehicle?.membershipId ?? widget.membershipId,
      name: _nameController.text.trim(),
      plateNumber: _plateNumberController.text.trim(),
      specs: _specsController.text.trim().isEmpty
          ? null
          : _specsController.text.trim(),
      icon:
          _iconController.text.trim().isEmpty ? null : _iconController.text.trim(),
    );

    if (isEditing) {
      context.read<MemberVehicleBloc>().add(UpdateMemberVehicleEvent(vehicle));
    } else {
      context.read<MemberVehicleBloc>().add(CreateMemberVehicleEvent(vehicle));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MemberVehicleBloc, MemberVehicleState>(
      listener: (context, state) {
        if (state is MemberVehicleOperationSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.of(context).pop(true);
        } else if (state is MemberVehicleError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: AlertDialog(
        title: Text(isEditing ? 'Edit Member Vehicle' : 'Add Member Vehicle'),
        content: SizedBox(
          width: 400.w,
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Vehicle Name',
                      hintText: 'e.g., Honda Civic',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Vehicle name is required';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.h),
                  TextFormField(
                    controller: _plateNumberController,
                    decoration: const InputDecoration(
                      labelText: 'Plate Number',
                      hintText: 'e.g., B 1234 CD',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Plate number is required';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.h),
                  TextFormField(
                    controller: _specsController,
                    decoration: const InputDecoration(
                      labelText: 'Specifications',
                      hintText: 'e.g., Black, 2022',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  TextFormField(
                    controller: _iconController,
                    decoration: const InputDecoration(
                      labelText: 'Icon',
                      hintText: 'e.g., car',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          BlocBuilder<MemberVehicleBloc, MemberVehicleState>(
            builder: (context, state) {
              final isLoading = state is MemberVehicleLoading;
              return ElevatedButton(
                onPressed: isLoading ? null : _submit,
                child: isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Text(isEditing ? 'Update' : 'Create'),
              );
            },
          ),
        ],
      ),
    );
  }
}

/// Shows a confirmation dialog before deleting a member vehicle.
Future<bool?> showDeleteMemberVehicleDialog(
  BuildContext context,
  String vehicleId,
  String vehicleName,
) {
  return showDialog<bool>(
    context: context,
    builder: (context) => BlocProvider(
      create: (context) => sl<MemberVehicleBloc>(),
      child: _DeleteMemberVehicleDialog(
        vehicleId: vehicleId,
        vehicleName: vehicleName,
      ),
    ),
  );
}

class _DeleteMemberVehicleDialog extends StatelessWidget {
  final String vehicleId;
  final String vehicleName;

  const _DeleteMemberVehicleDialog({
    required this.vehicleId,
    required this.vehicleName,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<MemberVehicleBloc, MemberVehicleState>(
      listener: (context, state) {
        if (state is MemberVehicleOperationSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.of(context).pop(true);
        } else if (state is MemberVehicleError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: AlertDialog(
        title: const Text('Delete Member Vehicle'),
        content: Text('Are you sure you want to delete "$vehicleName"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          BlocBuilder<MemberVehicleBloc, MemberVehicleState>(
            builder: (context, state) {
              final isLoading = state is MemberVehicleLoading;
              return ElevatedButton(
                onPressed: isLoading
                    ? null
                    : () {
                        context
                            .read<MemberVehicleBloc>()
                            .add(DeleteMemberVehicleEvent(vehicleId));
                      },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Text('Delete', style: TextStyle(color: Colors.white)),
              );
            },
          ),
        ],
      ),
    );
  }
}
