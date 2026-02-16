import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../injection_container.dart';
import '../../domain/entities/vehicle.dart';
import '../bloc/vehicle_bloc.dart';

class VehicleFormDialog extends StatelessWidget {
  final Vehicle? vehicle;
  const VehicleFormDialog({super.key, this.vehicle});

  /// Show the vehicle form dialog. Returns `true` if a vehicle was created/updated.
  static Future<bool?> show(BuildContext context, {Vehicle? vehicle}) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (_) => VehicleFormDialog(vehicle: vehicle),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<VehicleBloc>(),
      child: _VehicleFormDialogContent(vehicle: vehicle),
    );
  }
}

class _VehicleFormDialogContent extends StatefulWidget {
  final Vehicle? vehicle;
  const _VehicleFormDialogContent({this.vehicle});

  @override
  State<_VehicleFormDialogContent> createState() => _VehicleFormDialogContentState();
}

class _VehicleFormDialogContentState extends State<_VehicleFormDialogContent> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _plateController;
  late TextEditingController _brandController;
  late TextEditingController _colorController;
  late TextEditingController _specsController;
  late String _category;

  bool get isEditMode => widget.vehicle != null;

  @override
  void initState() {
    super.initState();
    _plateController = TextEditingController(text: widget.vehicle?.licensePlate ?? '');
    _brandController = TextEditingController(text: widget.vehicle?.vehicleBrand ?? '');
    _colorController = TextEditingController(text: widget.vehicle?.vehicleColor ?? '');
    _specsController = TextEditingController(text: widget.vehicle?.vehicleSpecs ?? '');
    _category = widget.vehicle?.vehicleCategory ?? 'Motor';
  }

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
      final vehicle = Vehicle(
        id: isEditMode ? widget.vehicle!.id : '',
        customerId: isEditMode ? widget.vehicle!.customerId : null,
        licensePlate: _plateController.text,
        vehicleBrand: _brandController.text,
        vehicleColor: _colorController.text,
        vehicleCategory: _category,
        vehicleSpecs: _specsController.text,
      );

      if (isEditMode) {
        context.read<VehicleBloc>().add(UpdateVehicleEvent(vehicle));
      } else {
        context.read<VehicleBloc>().add(CreateVehicleEvent(vehicle));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<VehicleBloc, VehicleState>(
      listener: (context, state) {
        if (state is VehicleOperationSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
          Navigator.pop(context, true);
        } else if (state is VehicleError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        }
      },
      child: Dialog(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        insetPadding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 24.w),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16.r),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 1000.w, maxHeight: 600.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildHeader(),
                const Divider(height: 1, color: Color(0xFFE2E8F0)),
                Flexible(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(24.w),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _buildSectionCard(
                            title: 'Vehicle Information',
                            children: [
                              _buildLabel('License Plate', isRequired: true),
                              TextFormField(
                                controller: _plateController,
                                decoration: _buildInputDecoration(hint: 'e.g. B 1234 ABC'),
                                validator: (v) => v!.isEmpty ? 'License plate is required' : null,
                              ),
                              SizedBox(height: 16.w),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        _buildLabel('Brand', isRequired: true),
                                        TextFormField(
                                          controller: _brandController,
                                          decoration:
                                              _buildInputDecoration(hint: 'e.g. Toyota Avanza'),
                                          validator: (v) => v!.isEmpty ? 'Brand is required' : null,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 16.w),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        _buildLabel('Color', isRequired: true),
                                        TextFormField(
                                          controller: _colorController,
                                          decoration: _buildInputDecoration(hint: 'e.g. White'),
                                          validator: (v) => v!.isEmpty ? 'Color is required' : null,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 16.w),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        _buildLabel('Category', isRequired: true),
                                        _buildCategorySelector(),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 16.w),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        _buildLabel('Specs'),
                                        TextFormField(
                                          controller: _specsController,
                                          decoration: _buildInputDecoration(hint: 'e.g. 1.5L AT'),
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
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.w),
      child: Row(
        children: [
          Text(
            isEditMode ? 'Edit Vehicle' : 'New Vehicle',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF1E293B),
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
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          OutlinedButton(
            onPressed: () => Navigator.pop(context),
            style: OutlinedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 14.w),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
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
          SizedBox(width: 12.w),
          ElevatedButton(
            onPressed: _onSubmit,
            style: ElevatedButton.styleFrom(
              elevation: 0,
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 14.w),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            child: Text(
              isEditMode ? 'Update Vehicle' : 'Save Vehicle',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  static const _categories = <String, IconData>{
    'Motor': Icons.motorcycle_outlined,
    'Mobil': Icons.directions_car_outlined,
  };

  static const _categoryLabels = <String, String>{
    'Motor': 'Motor',
    'Mobil': 'Mobil',
  };

  Widget _buildCategorySelector() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return PopupMenuButton<String>(
          offset: const Offset(0, 50),
          constraints: BoxConstraints(
            minWidth: constraints.maxWidth,
            maxWidth: constraints.maxWidth,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
            side: const BorderSide(color: Color(0xFFE2E8F0)),
          ),
          color: Colors.white,
          elevation: 8,
          onSelected: (v) => setState(() => _category = v),
          itemBuilder: (_) => _categories.entries.map((e) {
            final isSelected = e.key == _category;
            return PopupMenuItem<String>(
              value: e.key,
              child: Row(
                children: [
                  Icon(
                    e.value,
                    size: 20.w,
                    color: isSelected ? Theme.of(context).primaryColor : const Color(0xFF64748B),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Text(
                      _categoryLabels[e.key]!,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                        color: isSelected ? const Color(0xFF1E293B) : const Color(0xFF475569),
                      ),
                    ),
                  ),
                  if (isSelected)
                    Icon(
                      Icons.check,
                      size: 18.w,
                      color: Theme.of(context).primaryColor,
                    ),
                ],
              ),
            );
          }).toList(),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: Row(
              children: [
                Icon(
                  _categories[_category],
                  size: 20.w,
                  color: const Color(0xFF64748B),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    _categoryLabels[_category]!,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                ),
                Icon(
                  Icons.keyboard_arrow_down,
                  size: 20.w,
                  color: Color(0xFF64748B),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSectionCard({required String title, required List<Widget> children}) {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 20.w),
          ...children,
        ],
      ),
    );
  }

  Widget _buildLabel(String label, {bool isRequired = false}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.w),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: Colors.black54,
            ),
          ),
          if (isRequired)
            Text(
              ' *',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFFEF4444),
              ),
            ),
        ],
      ),
    );
  }

  InputDecoration _buildInputDecoration({String? hint, String? prefixText}) {
    return InputDecoration(
      hintText: hint,
      prefixText: prefixText,
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: BorderSide(color: Colors.grey[300]!),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: BorderSide(color: Colors.grey[300]!),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: BorderSide(color: Theme.of(context).primaryColor),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.w),
    );
  }
}
