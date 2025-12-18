import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/routes/app_routes.dart';

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
                  isActive: location == AppRoutes.dashboard,
                  onTap: () => context.go(AppRoutes.dashboard),
                ),
                _SidebarItem(
                  icon: Icons.history,
                  label: 'Riwayat',
                  isActive: location.startsWith(AppRoutes.workOrders),
                  onTap: () => context.go(AppRoutes.workOrders),
                ),
                _SidebarItem(
                  icon: Icons.pie_chart_outline,
                  label: 'Laporan',
                  isActive: location.startsWith(AppRoutes.reports),
                  onTap: () => context.go(AppRoutes.reports),
                ),
                _SidebarItem(
                  icon: Icons.people_outline,
                  label: 'Pelanggan',
                  isActive: location.startsWith(AppRoutes.customers),
                  onTap: () => context.go(AppRoutes.customers),
                ),
                _SidebarItem(
                  icon: Icons.card_membership,
                  label: 'Membership',
                  isActive: location.startsWith(AppRoutes.memberships),
                  onTap: () => context.go(AppRoutes.memberships),
                ),
                _SidebarItem(
                  icon: Icons.directions_car,
                  label: 'Kendaraan',
                  isActive: location.startsWith(AppRoutes.vehicles),
                  onTap: () => context.go(AppRoutes.vehicles),
                ),
                _SidebarItem(
                  icon: Icons.cleaning_services,
                  label: 'Layanan',
                  isActive: location.startsWith(AppRoutes.services),
                  onTap: () => context.go(AppRoutes.services),
                ),
                _SidebarItem(
                  icon: Icons.shopping_bag,
                  label: 'Produk',
                  isActive: location.startsWith(AppRoutes.products),
                  onTap: () => context.go(AppRoutes.products),
                ),
                _SidebarItem(
                  icon: Icons.manage_accounts,
                  label: 'Pengguna',
                  isActive: location.startsWith(AppRoutes.users),
                  onTap: () => context.go(AppRoutes.users),
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
            'Flashlight',
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
        color: isActive ? const Color(0xFFE0E7FF) : Colors.transparent, // Light blue if active
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
                    color: isActive ? const Color(0xFF4F46E5) : const Color(0xFF64748B),
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
