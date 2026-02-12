import 'package:flashlight_pos/config/themes/app_colors.dart';
import 'package:flashlight_pos/shared/widgets/custom_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../injection_container.dart';
import '../../domain/entities/vehicle.dart';
import '../bloc/vehicle_bloc.dart';
import 'vehicle_form_dialog.dart';

class VehicleListPage extends StatelessWidget {
  const VehicleListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<VehicleBloc>()..add(LoadVehicles()),
      child: const _VehicleContentView(),
    );
  }
}

class _VehicleContentView extends StatelessWidget {
  const _VehicleContentView();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(32.w, 16.w, 32.w, 32.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _StatsAndFilterSection(),
          SizedBox(height: 12.w),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: AppColors.slate200),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 20,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Divider(height: 1, color: AppColors.slate100),
                  Expanded(
                    child: BlocConsumer<VehicleBloc, VehicleState>(
                      listener: (context, state) {
                        if (state is VehicleError) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.message)),
                          );
                        }
                      },
                      builder: (context, state) {
                        if (state is VehicleLoading || state is VehicleInitial) {
                          return const CustomLoading();
                        } else if (state is VehicleLoaded) {
                          if (state.vehicles.isEmpty) {
                            return const Center(
                              child: Text(
                                'Vehicle not found',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: AppColors.slate500,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            );
                          }
                          return _VehicleTable(vehicles: state.vehicles);
                        }
                        return const Center(child: Text('No vehicles found'));
                      },
                    ),
                  ),
                  const _PaginationSection(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatsAndFilterSection extends StatelessWidget {
  const _StatsAndFilterSection();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VehicleBloc, VehicleState>(
      builder: (context, state) {
        return Row(
          children: [
            const Text(
              'Vehicles',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.slate800,
              ),
            ),
            const Spacer(),
            Container(
              width: 300,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.slate200),
              ),
              child: Row(
                children: [
                  const Icon(Icons.search, color: AppColors.slate400, size: 20),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        context.read<VehicleBloc>().add(SearchVehiclesEvent(value));
                      },
                      decoration: const InputDecoration(
                        hintText: 'Search plate, brand, category...',
                        border: InputBorder.none,
                        isDense: true,
                        hintStyle: TextStyle(color: AppColors.slate400, fontSize: 14),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            ElevatedButton.icon(
              onPressed: () async {
                final result = await VehicleFormDialog.show(context);
                if (result == true && context.mounted) {
                  context.read<VehicleBloc>().add(LoadVehicles());
                }
              },
              icon: const Icon(Icons.add, size: 14),
              label: const Text('Add Vehicle'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.orangePrimary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                elevation: 0,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _VehicleTable extends StatelessWidget {
  final List<Vehicle> vehicles;

  const _VehicleTable({required this.vehicles});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Sticky Header
        Table(
          columnWidths: const {
            0: FlexColumnWidth(2),
            1: FlexColumnWidth(2),
            2: FlexColumnWidth(1.5),
            3: FlexColumnWidth(1.5),
            4: FlexColumnWidth(2),
            5: FixedColumnWidth(100),
          },
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: [
            TableRow(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
                border: const Border(
                  bottom: BorderSide(color: AppColors.slate200),
                ),
              ),
              children: const [
                _HeaderCell('LICENSE PLATE'),
                _HeaderCell('BRAND'),
                _HeaderCell('COLOR'),
                _HeaderCell('CATEGORY'),
                _HeaderCell('SPECS'),
                _HeaderCell('ACTION', align: Alignment.centerRight),
              ],
            ),
          ],
        ),
        // Scrollable Content
        Expanded(
          child: SingleChildScrollView(
            child: Table(
              columnWidths: const {
                0: FlexColumnWidth(2),
                1: FlexColumnWidth(2),
                2: FlexColumnWidth(1.5),
                3: FlexColumnWidth(1.5),
                4: FlexColumnWidth(2),
                5: FixedColumnWidth(100),
              },
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                ...vehicles.map((vehicle) => _buildVehicleRow(context, vehicle)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  TableRow _buildVehicleRow(BuildContext context, Vehicle vehicle) {
    return TableRow(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.slate100)),
      ),
      children: [
        TableCell(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: AppColors.orangePrimary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.directions_car, color: AppColors.orangePrimary, size: 24),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    vehicle.licensePlate,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.slate800,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
        _DataCell(text: vehicle.vehicleBrand),
        _DataCell(text: vehicle.vehicleColor),
        _DataCell(text: vehicle.vehicleCategory),
        _DataCell(text: vehicle.vehicleSpecs),
        TableCell(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: const Icon(Icons.edit_outlined, size: 20, color: AppColors.slate500),
                onPressed: () async {
                  final result = await VehicleFormDialog.show(context, vehicle: vehicle);
                  if (result == true && context.mounted) {
                    context.read<VehicleBloc>().add(LoadVehicles());
                  }
                },
              ),
              IconButton(
                icon: const Icon(Icons.delete_outline, size: 20, color: Color(0xFFEF4444)),
                onPressed: () async {
                  final confirmed = await showDialog<bool>(
                    context: context,
                    builder: (dialogContext) => AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      title: const Row(
                        children: [
                          Icon(Icons.warning_amber_rounded, color: Color(0xFFEF4444), size: 24),
                          SizedBox(width: 12),
                          Text('Delete Vehicle',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                        ],
                      ),
                      content: Text(
                        'Are you sure you want to delete "${vehicle.licensePlate}"? This action cannot be undone.',
                        style: const TextStyle(fontSize: 14, color: AppColors.slate600),
                      ),
                      actions: [
                        OutlinedButton(
                          onPressed: () => Navigator.pop(dialogContext, true),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            side: const BorderSide(color: Color(0xFFEF4444)),
                          ),
                          child: const Text('Delete',
                              style:
                                  TextStyle(color: Color(0xFFEF4444), fontWeight: FontWeight.w600)),
                        ),
                        ElevatedButton(
                          onPressed: () => Navigator.pop(dialogContext, false),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.orangePrimary,
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text('Cancel',
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                        ),
                      ],
                    ),
                  );
                  if (confirmed == true && context.mounted) {
                    context.read<VehicleBloc>().add(DeleteVehicleEvent(vehicle.id));
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _HeaderCell extends StatelessWidget {
  final String label;
  final Alignment align;

  const _HeaderCell(this.label, {this.align = Alignment.centerLeft});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Align(
        alignment: align,
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: AppColors.slate500,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }
}

class _DataCell extends StatelessWidget {
  final String text;

  const _DataCell({required this.text});

  @override
  Widget build(BuildContext context) {
    return TableCell(
      verticalAlignment: TableCellVerticalAlignment.middle,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.slate600,
          ),
        ),
      ),
    );
  }
}

class _PaginationSection extends StatelessWidget {
  const _PaginationSection();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VehicleBloc, VehicleState>(
      builder: (context, state) {
        if (state is! VehicleLoaded) return const SizedBox.shrink();

        final currentPage = state.currentPage;
        final itemsPerPage = state.itemsPerPage;
        final totalItems = state.totalItems;
        final totalPages = (totalItems / itemsPerPage).ceil();

        final startItem = totalItems == 0 ? 0 : (currentPage - 1) * itemsPerPage + 1;
        final endItem = (startItem + state.vehicles.length - 1);

        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Text('View', style: TextStyle(color: AppColors.slate500)),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.slate200),
                    ),
                    child: Row(
                      children: [
                        Text('$itemsPerPage', style: const TextStyle(fontWeight: FontWeight.bold)),
                        const Icon(Icons.keyboard_arrow_down, size: 16),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text('entry per page', style: TextStyle(color: AppColors.slate500)),
                ],
              ),
              Row(
                children: [
                  Text('Showing $startItem-$endItem of $totalItems entries',
                      style: const TextStyle(color: AppColors.slate500)),
                  const SizedBox(width: 24),
                  IconButton(
                      onPressed: currentPage > 1
                          ? () => context.read<VehicleBloc>().add(ChangePageEvent(currentPage - 1))
                          : null,
                      icon: Icon(Icons.chevron_left,
                          color: currentPage > 1 ? AppColors.slate500 : AppColors.slate300)),
                  ...List.generate(totalPages, (index) {
                    final page = index + 1;
                    if (totalPages > 7 &&
                        (page > 2 &&
                            page < totalPages - 1 &&
                            (page < currentPage - 1 || page > currentPage + 1))) {
                      return page == currentPage - 2 || page == currentPage + 2
                          ? const Text('...', style: TextStyle(color: AppColors.slate500))
                          : const SizedBox.shrink();
                    }
                    return _buildPageNumber(context, page, isActive: page == currentPage);
                  }),
                  IconButton(
                      onPressed: currentPage < totalPages
                          ? () => context.read<VehicleBloc>().add(ChangePageEvent(currentPage + 1))
                          : null,
                      icon: Icon(Icons.chevron_right,
                          color:
                              currentPage < totalPages ? AppColors.slate500 : AppColors.slate300)),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPageNumber(BuildContext context, int number, {required bool isActive}) {
    return InkWell(
      onTap: () => context.read<VehicleBloc>().add(ChangePageEvent(number)),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        width: 32,
        height: 32,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isActive ? AppColors.orangePrimary : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          number.toString(),
          style: TextStyle(
            color: isActive ? Colors.white : AppColors.slate500,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
