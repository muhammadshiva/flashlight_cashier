import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DashboardSidebar extends StatelessWidget {
  const DashboardSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    // Get current location (route path)
    final location = GoRouterState.of(context).uri.toString();

    return Container(
      width: 250,
      color: Colors.white,
      child: Column(
        children: [
          _buildLogo(),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
              children: [
                _SidebarItem(
                  icon: Icons.inbox_outlined,
                  label: 'Antrian',
                  isActive: location == '/dashboard',
                  onTap: () => context.go('/dashboard'),
                ),
                _SidebarItem(
                  icon: Icons.history,
                  label: 'Riwayat',
                  isActive: location.startsWith('/work-orders'),
                  onTap: () => context.go('/work-orders'),
                ),
                _SidebarItem(
                  icon: Icons.pie_chart_outline,
                  label: 'Laporan',
                  isActive: location.startsWith('/reports'),
                  onTap: () {}, // TODO: Implement Report route
                ),
                _SidebarItem(
                  icon: Icons.people_outline,
                  label: 'Pelanggan',
                  isActive: location.startsWith('/customers'),
                  onTap: () => context.go('/customers'),
                ),
                _SidebarItem(
                  icon: Icons.local_offer_outlined,
                  label: 'Layanan',
                  isActive: location.startsWith('/products'),
                  onTap: () =>
                      context.go('/products'), // Assuming products/services
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogo() {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFF1E293B), // Dark blue/black
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.circle_outlined, color: Colors.white),
          ),
          const SizedBox(width: 12),
          const Text(
            'MotoWash',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E293B),
            ),
          ),
        ],
      ),
    );
  }
}

class _SidebarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _SidebarItem({
    required this.icon,
    required this.label,
    this.isActive = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: isActive
            ? const Color(0xFFE0E7FF)
            : Colors.transparent, // Light blue if active
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: Row(
              children: [
                Icon(
                  icon,
                  size: 20,
                  color: isActive
                      ? const Color(0xFF4F46E5)
                      : const Color(0xFF64748B), // Blue if active, Gray if not
                ),
                const SizedBox(width: 12),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: isActive
                        ? const Color(0xFF4F46E5)
                        : const Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
