import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/dashboard_bloc.dart';
import '../bloc/dashboard_event.dart';
import '../bloc/dashboard_state.dart';

class StatusFilterBar extends StatelessWidget {
  const StatusFilterBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) {
        if (state is! DashboardLoaded) return const SizedBox.shrink();

        final counts = state.statusCounts;
        final selected = state.selectedStatus;

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _FilterChip(
                label: 'Semua',
                count: counts['Semua'] ?? 0,
                isActive: selected == 'Semua',
                onTap: () => context
                    .read<DashboardBloc>()
                    .add(const FilterWorkOrders(status: 'Semua')),
              ),
              const SizedBox(width: 12),
              _FilterChip(
                label: 'queued',
                count: counts['queued'] ?? 0,
                isActive: selected.toLowerCase() == 'queued',
                onTap: () => context
                    .read<DashboardBloc>()
                    .add(const FilterWorkOrders(status: 'queued')),
              ),
              const SizedBox(width: 12),
              _FilterChip(
                label: 'washing',
                count: counts['washing'] ?? 0,
                isActive: selected.toLowerCase() == 'washing',
                onTap: () => context
                    .read<DashboardBloc>()
                    .add(const FilterWorkOrders(status: 'washing')),
              ),
              const SizedBox(width: 12),
              _FilterChip(
                label: 'drying',
                count: counts['drying'] ?? 0,
                isActive: selected.toLowerCase() == 'drying',
                onTap: () => context
                    .read<DashboardBloc>()
                    .add(const FilterWorkOrders(status: 'drying')),
              ),
              const SizedBox(width: 12),
              _FilterChip(
                label: 'inspection',
                count: counts['inspection'] ?? 0,
                isActive: selected.toLowerCase() == 'inspection',
                onTap: () => context
                    .read<DashboardBloc>()
                    .add(const FilterWorkOrders(status: 'inspection')),
              ),
              const SizedBox(width: 12),
              _FilterChip(
                label:
                    'completed', // 'Ready' in UI might map to 'completed' API status
                count: counts['completed'] ?? 0,
                isActive: selected.toLowerCase() == 'completed',
                onTap: () => context
                    .read<DashboardBloc>()
                    .add(const FilterWorkOrders(status: 'completed')),
              ),
              const SizedBox(width: 12),
              _FilterChip(
                label: 'paid',
                count: counts['paid'] ?? 0,
                isActive: selected.toLowerCase() == 'paid',
                onTap: () => context
                    .read<DashboardBloc>()
                    .add(const FilterWorkOrders(status: 'paid')),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final int count;
  final bool isActive;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.count,
    this.isActive = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFF1E293B) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isActive ? const Color(0xFF1E293B) : const Color(0xFFE2E8F0),
          ),
        ),
        child: Row(
          children: [
            Text(
              label[0].toUpperCase() + label.substring(1),
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isActive ? Colors.white : const Color(0xFF64748B),
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: isActive
                    ? const Color(0xFF334155)
                    : const Color(0xFFF1F5F9),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                count.toString(),
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: isActive ? Colors.white : const Color(0xFF64748B),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
