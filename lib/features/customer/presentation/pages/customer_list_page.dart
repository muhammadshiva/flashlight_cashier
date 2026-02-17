import 'package:flashlight_pos/config/themes/app_colors.dart';
import 'package:flashlight_pos/shared/widgets/custom_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/shared/models/pagination_actions.dart';
import '../../../../core/shared/models/pagination_config.dart';
import '../../../../core/shared/models/pagination_data.dart';
import '../../../../core/widgets/pagination/pagination_widget.dart';
import '../../../../injection_container.dart';
import '../../domain/entities/customer.dart';
import '../bloc/customer_bloc.dart';
import '../bloc/customer_event.dart';
import '../bloc/customer_state.dart';
import 'customer_form_dialog.dart';

class CustomerListPage extends StatelessWidget {
  const CustomerListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<CustomerBloc>()..add(LoadCustomers()),
      child: const _CustomerContentView(),
    );
  }
}

class _CustomerContentView extends StatelessWidget {
  const _CustomerContentView();

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
                    blurRadius: 20.r,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Divider(height: 1, color: AppColors.slate100),
                  Expanded(
                    child: BlocConsumer<CustomerBloc, CustomerState>(
                      listener: (context, state) {
                        if (state is CustomerError) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.message)),
                          );
                        }
                      },
                      builder: (context, state) {
                        if (state is CustomerLoading || state is CustomerInitial) {
                          return const CustomLoading();
                        } else if (state is CustomerLoaded) {
                          if (state.customers.isEmpty) {
                            return Center(
                              child: Text(
                                'Customer not found',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: AppColors.slate500,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            );
                          }
                          return _CustomerTable(customers: state.customers);
                        }
                        return const Center(child: Text('No customers found'));
                      },
                    ),
                  ),
                  BlocBuilder<CustomerBloc, CustomerState>(
                    builder: (context, state) {
                      if (state is! CustomerLoaded) return const SizedBox.shrink();

                      final currentPage = state.currentPage;
                      final itemsPerPage = state.itemsPerPage;
                      final totalItems = state.totalItems;
                      final totalPages = (totalItems / itemsPerPage).ceil();
                      final startItem = totalItems == 0 ? 0 : (currentPage - 1) * itemsPerPage + 1;
                      final endItem = totalItems == 0 ? 0 : startItem + state.customers.length - 1;

                      return DataDrivenPagination(
                        config: PaginationConfig(
                          data: PaginationData(
                            currentPage: currentPage,
                            totalPages: totalPages > 0 ? totalPages : 1,
                            itemsPerPage: itemsPerPage,
                            totalItems: totalItems,
                            startIndex: startItem,
                            endIndex: endItem,
                            itemLabel: 'customer',
                          ),
                          actions: PaginationActions(
                            onPageChanged: (page) =>
                                context.read<CustomerBloc>().add(ChangePageEvent(page)),
                            onItemsPerPageChanged: (count) =>
                                context.read<CustomerBloc>().add(ChangeItemsPerPageEvent(count)),
                            onNextPage: currentPage < totalPages
                                ? () => context
                                    .read<CustomerBloc>()
                                    .add(ChangePageEvent(currentPage + 1))
                                : null,
                            onPreviousPage: currentPage > 1
                                ? () => context
                                    .read<CustomerBloc>()
                                    .add(ChangePageEvent(currentPage - 1))
                                : null,
                          ),
                        ),
                      );
                    },
                  ),
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
    return BlocBuilder<CustomerBloc, CustomerState>(
      builder: (context, state) {
        return Row(
          children: [
            Text(
              'Customers',
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF1E293B),
              ),
            ),
            const Spacer(),
            Container(
              width: 300.w,
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: AppColors.slate200),
              ),
              child: Row(
                children: [
                  Icon(Icons.search, color: AppColors.slate400, size: 20.w),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        context.read<CustomerBloc>().add(SearchCustomersEvent(value));
                      },
                      decoration: InputDecoration(
                        hintText: 'Search customer...',
                        border: InputBorder.none,
                        isDense: true,
                        hintStyle: TextStyle(color: AppColors.slate400, fontSize: 14.sp),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 16.w),
            ElevatedButton.icon(
              onPressed: () async {
                final result = await CustomerFormDialog.show(context);
                if (result == true && context.mounted) {
                  context.read<CustomerBloc>().add(LoadCustomers());
                }
              },
              icon: const Icon(Icons.add, size: 14),
              label: const Text('Add Customer'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.orangePrimary,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.w),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
                elevation: 0,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _CustomerTable extends StatelessWidget {
  final List<Customer> customers;

  const _CustomerTable({required this.customers});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Sticky Header
        Table(
          columnWidths: const {
            0: FlexColumnWidth(2),
            1: FlexColumnWidth(2),
            2: FlexColumnWidth(2),
            3: FixedColumnWidth(100),
          },
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: [
            TableRow(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
                color: Colors.white,
                border: const Border(
                  bottom: BorderSide(color: AppColors.slate200),
                ),
              ),
              children: const [
                _HeaderCell('NAME'),
                _HeaderCell('PHONE'),
                _HeaderCell('EMAIL'),
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
                2: FlexColumnWidth(2),
                3: FixedColumnWidth(100),
              },
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                ...customers.map((customer) => _buildCustomerRow(context, customer)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  TableRow _buildCustomerRow(BuildContext context, Customer customer) {
    return TableRow(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.slate100)),
      ),
      children: [
        _DataCell(text: customer.name),
        _DataCell(text: customer.phoneNumber),
        _DataCell(text: customer.email),
        TableCell(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: const Icon(Icons.edit_outlined, size: 20, color: AppColors.slate500),
                onPressed: () async {
                  final result = await CustomerFormDialog.show(context, customer: customer);
                  if (result == true && context.mounted) {
                    context.read<CustomerBloc>().add(LoadCustomers());
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
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      title: Row(
                        children: [
                          Icon(Icons.warning_amber_rounded,
                              color: const Color(0xFFEF4444), size: 24.w),
                          SizedBox(width: 12.w),
                          Text('Delete Customer',
                              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600)),
                        ],
                      ),
                      content: Text(
                        'Are you sure you want to delete "${customer.name}"? This action cannot be undone.',
                        style: TextStyle(fontSize: 14.sp, color: const Color(0xFF475569)),
                      ),
                      actions: [
                        OutlinedButton(
                          onPressed: () => Navigator.pop(dialogContext, true),
                          style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.w),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r),
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
                            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.w),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                          ),
                          child: const Text('Cancel',
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                        ),
                      ],
                    ),
                  );
                  if (confirmed == true && context.mounted) {
                    context.read<CustomerBloc>().add(DeleteCustomerEvent(customer.id));
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
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.w),
      child: Align(
        alignment: align,
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12.sp,
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
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.w),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF475569),
          ),
        ),
      ),
    );
  }
}
