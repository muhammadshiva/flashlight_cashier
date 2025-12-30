import 'package:flashlight_pos/config/routes/app_routes.dart';
import 'package:flashlight_pos/config/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../auth/presentation/bloc/auth_bloc.dart';
import 'settings_dialog.dart';

class DashboardTopNavigation extends StatelessWidget {
  const DashboardTopNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    // Get current location (route path)
    final location = GoRouterState.of(context).uri.toString();

    return Container(
      height: 72,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Color(0xFFE2E8F0))),
      ),
      child: Row(
        children: [
          // Branding (Logo)
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.blackFoundation600,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.flash_on, color: Colors.white, size: 24),
          ),

          // Horizontal Navigation Menu
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  const SizedBox(width: 24),
                  _TopNavItem(
                    icon: Icons.dashboard_outlined,
                    label: 'Dashboard',
                    isActive: location == AppRoutes.dashboard,
                    onTap: () => context.go(AppRoutes.dashboard),
                  ),
                  const SizedBox(width: 8),
                  _TopNavItem(
                    icon: Icons.history, // Using history icon for Order/WorkOrder
                    label: 'Order',
                    isActive: location.startsWith(AppRoutes.workOrders),
                    onTap: () => context.go(AppRoutes.workOrders),
                  ),
                  const SizedBox(width: 8),
                  _TopNavItem(
                    icon: Icons.inventory_2_outlined,
                    label: 'Inventory',
                    isActive: location.startsWith(AppRoutes.products),
                    onTap: () => context.go(AppRoutes.products),
                  ),
                  const SizedBox(width: 8),
                  _TopNavItem(
                    icon: Icons.people_outline,
                    label: 'Customer',
                    isActive: location.startsWith(AppRoutes.customers),
                    onTap: () => context.go(AppRoutes.customers),
                  ),
                  const SizedBox(width: 8),
                  _TopNavItem(
                    icon: Icons.directions_car,
                    label: 'Vehicle',
                    isActive: location.startsWith(AppRoutes.vehicles),
                    onTap: () => context.go(AppRoutes.vehicles),
                  ),
                ],
              ),
            ),
          ),

          // Right Actions & Profile
          Row(
            children: [
              /// icon notification
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.notifications_outlined,
                  color: Color(0xFF64748B),
                ),
                style: IconButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: const BorderSide(color: Color(0xFFE2E8F0)))),
              ),

              16.horizontalSpace,

              const _ProfileMenuButton(),
            ],
          ),
        ],
      ),
    );
  }
}

class _TopNavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _TopNavItem({
    required this.icon,
    required this.label,
    this.isActive = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
            color: isActive ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: isActive ? Border.all(color: const Color(0xFFE2E8F0)) : null,
            boxShadow: isActive
                ? [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 4,
                      offset: const Offset(0, 1),
                    )
                  ]
                : null),
        child: Row(
          children: [
            Icon(
              icon,
              size: 18,
              color: isActive ? const Color(0xFF1E293B) : const Color(0xFF94A3B8),
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                color: isActive ? const Color(0xFF1E293B) : const Color(0xFF94A3B8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileMenuButton extends StatelessWidget {
  const _ProfileMenuButton();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        String userName = 'Alexander';
        String userRole = 'Admin';

        if (state is AuthSuccess) {
          userName = state.auth.user.name;
        }

        return PopupMenuButton<String>(
          offset: const Offset(0, 55),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: const BorderSide(color: Color(0xFFE2E8F0)),
          ),
          color: Colors.white,
          elevation: 8,
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'profile',
              child: Row(
                children: [
                  Icon(
                    Icons.person_outline,
                    size: 20,
                    color: Color(0xFF64748B),
                  ),
                  SizedBox(width: 12),
                  Text(
                    'Profile',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                ],
              ),
            ),
            const PopupMenuItem(
              value: 'settings',
              child: Row(
                children: [
                  Icon(
                    Icons.settings_outlined,
                    size: 20,
                    color: Color(0xFF64748B),
                  ),
                  SizedBox(width: 12),
                  Text(
                    'Settings',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                ],
              ),
            ),
            const PopupMenuItem(
              height: 1,
              enabled: false,
              child: Divider(
                color: Color(0xFFE2E8F0),
                thickness: 1,
              ),
            ),
            const PopupMenuItem(
              value: 'signout',
              child: Row(
                children: [
                  Icon(
                    Icons.logout,
                    size: 20,
                    color: Color(0xFFEF4444),
                  ),
                  SizedBox(width: 12),
                  Text(
                    'Sign out',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFFEF4444),
                    ),
                  ),
                ],
              ),
            ),
          ],
          onSelected: (value) {
            if (value == 'profile') {
              // TODO: Navigate to profile page
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Profile page - coming soon')),
              );
            } else if (value == 'settings') {
              // Show settings dialog
              showDialog(
                context: context,
                builder: (context) => const SettingsDialog(),
              );
            } else if (value == 'signout') {
              // Sign out action
              context.read<AuthBloc>().add(LogoutRequested());
              context.go(AppRoutes.login);
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 16,
                  backgroundImage:
                      NetworkImage('https://i.pravatar.cc/150?u=a042581f4e29026024d'),
                ),
                const SizedBox(width: 12),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userName,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                    Text(
                      userRole,
                      style: const TextStyle(
                        fontSize: 11,
                        color: Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 8),
                const Icon(
                  Icons.keyboard_arrow_down,
                  size: 20,
                  color: Color(0xFF64748B),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
