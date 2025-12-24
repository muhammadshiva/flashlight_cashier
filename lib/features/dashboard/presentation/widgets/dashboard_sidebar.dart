import 'package:flashlight_pos/config/themes/app_colors.dart';
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
      color: Colors.transparent, // Transparent to blend with body
      child: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _SidebarGroupTitle(title: 'Overview'),
                _SidebarItem(
                  icon: Icons.dashboard_outlined,
                  label: 'Dashboard',
                  isActive: location == AppRoutes.dashboard,
                  onTap: () => context.go(AppRoutes.dashboard),
                ),
                const SizedBox(height: 24),
                _SidebarGroupTitle(title: 'Inventory'),
                _SidebarItem(
                  icon: Icons.shopping_bag_outlined,
                  label: 'Products',
                  isActive: location.startsWith(AppRoutes.products),
                  onTap: () => context.go(AppRoutes.products),
                ),
                _SidebarItem(
                  icon: Icons.category_outlined,
                  label: 'Categories',
                  isActive: false, // Placeholder
                  onTap: () {},
                ),
                _SidebarItem(
                  icon: Icons.inventory_2_outlined,
                  label: 'Stock Control',
                  isActive: false, // Placeholder
                  onTap: () {},
                ),
                const SizedBox(height: 24),
                _SidebarGroupTitle(title: 'Management'),
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
                  icon: Icons.manage_accounts,
                  label: 'Pengguna',
                  isActive: location.startsWith(AppRoutes.users),
                  onTap: () => context.go(AppRoutes.users),
                ),
              ],
            ),
          ),
          // Removed duplicate profile section as it's in header now
        ],
      ),
    );
  }
}

class _SidebarGroupTitle extends StatelessWidget {
  final String title;
  const _SidebarGroupTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, bottom: 8, top: 16),
      child: Text(
        title.toUpperCase(),
        style: const TextStyle(
          color: Color(0xFF64748B),
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
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
      margin: const EdgeInsets.only(bottom: 4),
      decoration: isActive
          ? BoxDecoration(
              color: AppColors.orangePrimary,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  )
                ])
          : null,
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          hoverColor: Colors.white.withOpacity(0.5),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: Row(
              children: [
                Icon(
                  icon,
                  size: 20,
                  color: isActive
                      ? AppColors.white
                      : const Color(0xFF64748B), // Gray for inactive
                ),
                const SizedBox(width: 12),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                    color: isActive
                        ? AppColors.white
                        : AppColors.blackFoundation600,
                  ),
                ),
                if (isActive) ...[
                  const Spacer(),
                  const Icon(Icons.keyboard_arrow_down,
                      color: AppColors.white,
                      size: 16) // Dropdown indicator implies active
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }
}
