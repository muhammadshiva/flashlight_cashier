import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/themes/app_colors.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../injection_container.dart';
import '../../domain/entities/service_entity.dart';
import '../bloc/service_bloc.dart';

class ServiceListPage extends StatelessWidget {
  const ServiceListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ServiceBloc>()..add(LoadServices()),
      child: Scaffold(
        backgroundColor: const Color(0xFFF8FAFC), // Slate-50
        body: BlocConsumer<ServiceBloc, ServiceState>(
          listener: (context, state) {
            if (state is ServiceError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: AppColors.error600,
                  action: SnackBarAction(
                    label: 'Retry',
                    textColor: AppColors.white,
                    onPressed: () {
                      context.read<ServiceBloc>().add(LoadServices());
                    },
                  ),
                ),
              );
            } else if (state is ServiceOperationSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: AppColors.success600,
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is ServiceLoading) {
              return const Center(
                  child: CircularProgressIndicator(color: AppColors.primary));
            } else if (state is ServiceLoaded) {
              return SingleChildScrollView(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const _HeaderSection(),
                    const SizedBox(height: 32),
                    const _SearchSection(),
                    const SizedBox(height: 24),
                    _ServiceTable(services: state.services),
                  ],
                ),
              );
            }
            return const Center(child: Text('Tidak ada data'));
          },
        ),
      ),
    );
  }
}

class _HeaderSection extends StatelessWidget {
  const _HeaderSection();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Daftar Layanan',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E293B), // Slate-900
              ),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Text(
                  'Dashboard',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF64748B), // Slate-500
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(Icons.circle, size: 4, color: Color(0xFFCBD5E1)),
                const SizedBox(width: 8),
                Text(
                  'Layanan',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.orangePrimary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
        ElevatedButton.icon(
          onPressed: () => context.push('/services/new'),
          icon: const Icon(Icons.add, size: 18),
          label: const Text('Tambah Layanan'),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.orangePrimary,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            elevation: 0,
          ),
        ),
      ],
    );
  }
}

class _SearchSection extends StatelessWidget {
  const _SearchSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.search, color: Color(0xFF94A3B8), size: 20),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        // TODO: Implement Search
                      },
                      decoration: const InputDecoration(
                        hintText: 'Cari layanan...',
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
          ),
          const SizedBox(width: 16),
          OutlinedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.filter_list, size: 18),
            label: const Text('Filter'),
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFF64748B),
              side: const BorderSide(color: Color(0xFFE2E8F0)),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
          ),
        ],
      ),
    );
  }
}

class _ServiceTable extends StatelessWidget {
  final List<ServiceEntity> services;

  const _ServiceTable({required this.services});

  @override
  Widget build(BuildContext context) {
    if (services.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(48.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.miscellaneous_services_outlined,
                size: 64,
                color: AppColors.textGray3.withOpacity(0.5),
              ),
              const SizedBox(height: 16),
              const Text(
                'Tidak ada layanan',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF64748B),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Table(
        columnWidths: const {
          0: FlexColumnWidth(2.5), // LAYANAN
          1: FlexColumnWidth(1), // TIPE
          2: FlexColumnWidth(1.2), // HARGA
          3: FlexColumnWidth(1), // STATUS
          4: FixedColumnWidth(140), // ACTION
        },
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: [
          const TableRow(
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Color(0xFFE2E8F0))),
            ),
            children: [
              _HeaderCell('LAYANAN'),
              _HeaderCell('TIPE'),
              _HeaderCell('HARGA'),
              _HeaderCell('STATUS'),
              _HeaderCell('ACTION', align: Alignment.centerRight),
            ],
          ),
          ...services.map((service) {
            return TableRow(
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: Color(0xFFF1F5F9))),
              ),
              children: [
                _DataCell(
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF1F5F9), // Slate-100
                          borderRadius: BorderRadius.circular(8),
                          image: service.imageUrl.isNotEmpty
                              ? DecorationImage(
                                  image: NetworkImage(service.imageUrl),
                                  fit: BoxFit.cover,
                                )
                              : null,
                        ),
                        child: service.imageUrl.isEmpty
                            ? const Icon(Icons.miscellaneous_services,
                                color: Color(0xFF94A3B8), size: 20)
                            : null,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              service.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF1E293B),
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              service.description,
                              style: const TextStyle(
                                color: Color(0xFF94A3B8),
                                fontSize: 12,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                _DataCell(
                  child: _ServiceTypeBadge(type: service.type),
                ),
                _DataCell(
                  child: Text(
                    CurrencyFormatter.format(service.price),
                    style: const TextStyle(
                      fontFamily: 'RobotoMono',
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                ),
                _DataCell(
                  child: Row(
                    children: [
                      if (service.isDefault)
                        Container(
                          margin: const EdgeInsets.only(right: 8),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: const Color(0xFFDBEAFE),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Text(
                            'Default',
                            style: TextStyle(
                              color: Color(0xFF1D4ED8),
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      if (service.isActive)
                        const Icon(Icons.check_circle,
                            color: AppColors.success600, size: 16)
                      else
                        const Icon(Icons.cancel,
                            color: AppColors.textGray3, size: 16),
                    ],
                  ),
                ),
                _DataCell(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () =>
                              context.push('/services/${service.id}/edit'),
                          icon: const Icon(Icons.edit_outlined, size: 18),
                          color: const Color(0xFF64748B),
                          tooltip: 'Edit',
                          style: IconButton.styleFrom(
                            padding: const EdgeInsets.all(8),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            _showDeleteConfirmation(context, service);
                          },
                          icon: const Icon(Icons.delete_outline, size: 18),
                          color: AppColors.error600,
                          tooltip: 'Hapus',
                          style: IconButton.styleFrom(
                            padding: const EdgeInsets.all(8),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, ServiceEntity service) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Hapus Layanan'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Apakah Anda yakin ingin menghapus layanan ini?'),
            const SizedBox(height: 8),
            Text(
              service.name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              context.read<ServiceBloc>().add(DeleteServiceEvent(service.id));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error600,
              foregroundColor: Colors.white,
            ),
            child: const Text('Hapus'),
          ),
        ],
      ),
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
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      child: Align(
        alignment: align,
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Color(0xFF64748B), // Slate-500
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }
}

class _DataCell extends StatelessWidget {
  final Widget child;

  const _DataCell({required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      child: child,
    );
  }
}

class _ServiceTypeBadge extends StatelessWidget {
  final String type;

  const _ServiceTypeBadge({required this.type});

  @override
  Widget build(BuildContext context) {
    Color bgColor;
    Color textColor;

    switch (type.toLowerCase()) {
      case 'washing':
        bgColor = const Color(0xFFDBEAFE); // Blue-100
        textColor = const Color(0xFF1D4ED8); // Blue-700
        break;
      case 'detailing':
        bgColor = const Color(0xFFDCFCE7); // Green-100
        textColor = const Color(0xFF15803D); // Green-700
        break;
      case 'cleaning':
        bgColor = const Color(0xFFF1F5F9); // Slate-100
        textColor = const Color(0xFF64748B); // Slate-500
        break;
      default:
        bgColor = const Color(0xFFFEF3C7); // Amber-100
        textColor = const Color(0xFFD97706); // Amber-700
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        type.toUpperCase(),
        style: TextStyle(
          color: textColor,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
