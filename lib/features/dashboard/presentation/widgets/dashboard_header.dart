import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';

class DashboardHeader extends StatelessWidget {
  const DashboardHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 32),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Color(0xFFE2E8F0))),
      ),
      child: Row(
        children: [
          const Text(
            'MotoWash POS',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E293B),
            ),
          ),
          const SizedBox(width: 16),
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              String cashierName = 'Kasir';
              if (state is AuthSuccess) {
                cashierName = 'Kasir: ${state.auth.user.name}';
              }
              return Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  cashierName,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF64748B),
                  ),
                ),
              );
            },
          ),
          const Spacer(),
          _buildStatusItem(Icons.print, 'Printer Connected'),
          const SizedBox(width: 24),
          _buildStatusItem(Icons.point_of_sale, 'Shift Open'),
          const SizedBox(width: 24),
          const CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(
                'https://i.pravatar.cc/150?u=a042581f4e29026024d'), // Placeholder
            backgroundColor: Color(0xFFE2E8F0),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.keyboard_arrow_down, color: Color(0xFF64748B)),
        ],
      ),
    );
  }

  Widget _buildStatusItem(IconData icon, String label) {
    return Row(
      children: [
        Icon(icon, size: 16, color: const Color(0xFF64748B)),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xFF64748B),
          ),
        ),
      ],
    );
  }
}
