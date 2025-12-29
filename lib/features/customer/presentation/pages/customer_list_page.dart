import 'package:flashlight_pos/config/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../injection_container.dart';
import '../bloc/customer_bloc.dart';
import '../bloc/customer_event.dart';
import '../bloc/customer_state.dart';
import '../../domain/entities/customer.dart';

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
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _StatsAndFilterSection(),
          const SizedBox(height: 12),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 20,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Divider(height: 1, color: Color(0xFFF1F5F9)),
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
                        if (state is CustomerLoading) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (state is CustomerLoaded) {
                          if (state.customers.isEmpty) {
                            return const Center(
                              child: Text(
                                'Customer not found',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF64748B),
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
    return BlocBuilder<CustomerBloc, CustomerState>(
      builder: (context, state) {
        return Row(
          children: [
            const Text(
              'Customers',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E293B),
              ),
            ),
            const Spacer(),
            Container(
              width: 300,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.search, color: Color(0xFF94A3B8), size: 20),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        context
                            .read<CustomerBloc>()
                            .add(SearchCustomersEvent(value));
                      },
                      decoration: const InputDecoration(
                        hintText: 'Search customer...',
                        border: InputBorder.none,
                        isDense: true,
                        hintStyle:
                            TextStyle(color: Color(0xFF94A3B8), fontSize: 14),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            ElevatedButton.icon(
              onPressed: () => context.push('/customers/new'),
              icon: const Icon(Icons.add, size: 14),
              label: const Text('Add Customer'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.orangePrimary,
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
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
          children: const [
            TableRow(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  bottom: BorderSide(color: Color(0xFFE2E8F0)),
                ),
              ),
              children: [
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
        border: Border(bottom: BorderSide(color: Color(0xFFF1F5F9))),
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
                icon: const Icon(Icons.edit_outlined,
                    size: 20, color: Color(0xFF64748B)),
                onPressed: () => context.push('/customers/${customer.id}/edit',
                    extra: customer),
              ),
              IconButton(
                icon: const Icon(Icons.delete_outline,
                    size: 20, color: Color(0xFFEF4444)),
                onPressed: () {
                  context
                      .read<CustomerBloc>()
                      .add(DeleteCustomerEvent(customer.id));
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
            color: Color(0xFF64748B),
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
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xFF475569),
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
    return BlocBuilder<CustomerBloc, CustomerState>(
      builder: (context, state) {
        if (state is! CustomerLoaded) return const SizedBox.shrink();

        final currentPage = state.currentPage;
        final itemsPerPage = state.itemsPerPage;
        final totalItems = state.totalItems;
        final totalPages = (totalItems / itemsPerPage).ceil();

        final startItem =
            totalItems == 0 ? 0 : (currentPage - 1) * itemsPerPage + 1;
        final endItem = (startItem + state.customers.length - 1);

        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Text('View',
                      style: TextStyle(color: Color(0xFF64748B))),
                  const SizedBox(width: 8),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: Row(
                      children: [
                        Text('$itemsPerPage',
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                        const Icon(Icons.keyboard_arrow_down, size: 16),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text('entry per page',
                      style: TextStyle(color: Color(0xFF64748B))),
                ],
              ),
              Row(
                children: [
                  Text('Showing $startItem-$endItem of $totalItems entries',
                      style: const TextStyle(color: Color(0xFF64748B))),
                  const SizedBox(width: 24),
                  IconButton(
                      onPressed: currentPage > 1
                          ? () => context
                              .read<CustomerBloc>()
                              .add(ChangePageEvent(currentPage - 1))
                          : null,
                      icon: Icon(Icons.chevron_left,
                          color: currentPage > 1
                              ? const Color(0xFF64748B)
                              : const Color(0xFFCBD5E1))),
                  ...List.generate(totalPages, (index) {
                    final page = index + 1;
                    if (totalPages > 7 &&
                        (page > 2 &&
                            page < totalPages - 1 &&
                            (page < currentPage - 1 ||
                                page > currentPage + 1))) {
                      return page == currentPage - 2 || page == currentPage + 2
                          ? const Text('...',
                              style: TextStyle(color: Color(0xFF64748B)))
                          : const SizedBox.shrink();
                    }
                    return _buildPageNumber(context, page,
                        isActive: page == currentPage);
                  }),
                  IconButton(
                      onPressed: currentPage < totalPages
                          ? () => context
                              .read<CustomerBloc>()
                              .add(ChangePageEvent(currentPage + 1))
                          : null,
                      icon: Icon(Icons.chevron_right,
                          color: currentPage < totalPages
                              ? const Color(0xFF64748B)
                              : const Color(0xFFCBD5E1))),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPageNumber(BuildContext context, int number,
      {required bool isActive}) {
    return InkWell(
      onTap: () => context.read<CustomerBloc>().add(ChangePageEvent(number)),
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
            color: isActive ? Colors.white : const Color(0xFF64748B),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
