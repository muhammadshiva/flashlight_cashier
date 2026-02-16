import 'package:flashlight_pos/config/routes/app_routes.dart';
import 'package:flashlight_pos/config/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../profile/presentation/widgets/profile_dialog.dart';
import '../../../settings/presentation/bloc/settings_bloc.dart';
import '../../../settings/presentation/widgets/settings_dialog.dart';

class DashboardTopNavigation extends StatelessWidget {
  const DashboardTopNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    // Get current location (route path)
    final location = GoRouterState.of(context).uri.toString();

    return Container(
      height: 72.w,
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: const Color(0xFFE2E8F0), width: 1.w)),
      ),
      child: Row(
        children: [
          // Branding (Logo)
          Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              color: AppColors.blackFoundation600,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(Icons.flash_on, color: Colors.white, size: 24.w),
          ),

          // Horizontal Navigation Menu
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  SizedBox(width: 24.w),
                  _TopNavItem(
                    icon: Icons.dashboard_outlined,
                    label: 'Dashboard',
                    isActive: location == AppRoutes.dashboard,
                    onTap: () => context.go(AppRoutes.dashboard),
                  ),
                  SizedBox(width: 8.w),
                  _TopNavItem(
                    icon: Icons.history, // Using history icon for Order/WorkOrder
                    label: 'Order',
                    isActive: location.startsWith(AppRoutes.workOrders),
                    onTap: () => context.go(AppRoutes.workOrders),
                  ),
                  SizedBox(width: 8.w),
                  _TopNavItem(
                    icon: Icons.inventory_2_outlined,
                    label: 'Inventory',
                    isActive: location.startsWith(AppRoutes.products),
                    onTap: () => context.go(AppRoutes.products),
                  ),
                  SizedBox(width: 8.w),
                  _TopNavItem(
                    icon: Icons.people_outline,
                    label: 'Customer',
                    isActive: location.startsWith(AppRoutes.customers),
                    onTap: () => context.go(AppRoutes.customers),
                  ),
                  SizedBox(width: 8.w),
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
                icon: Icon(
                  Icons.notifications_outlined,
                  color: const Color(0xFF64748B),
                  size: 24.w,
                ),
                style: IconButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
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
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.w),
        decoration: BoxDecoration(
            color: isActive ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(12.r),
            border: isActive ? Border.all(color: const Color(0xFFE2E8F0)) : null,
            boxShadow: isActive
                ? [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 4.r,
                      offset: Offset(0, 1.w),
                    )
                  ]
                : null),
        child: Row(
          children: [
            Icon(
              icon,
              size: 18.w,
              color: isActive ? const Color(0xFF1E293B) : const Color(0xFF94A3B8),
            ),
            SizedBox(width: 8.w),
            Text(
              label,
              style: TextStyle(
                fontSize: 14.sp,
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
          offset: Offset(0, 55.w),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
            side: const BorderSide(color: Color(0xFFE2E8F0)),
          ),
          color: Colors.white,
          elevation: 8,
          itemBuilder: (context) => [
            PopupMenuItem(
              value: 'profile',
              child: Row(
                children: [
                  Icon(
                    Icons.person_outline,
                    size: 20.w,
                    color: const Color(0xFF64748B),
                  ),
                  SizedBox(width: 12.w),
                  Text(
                    'Profile',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: const Color(0xFF1E293B),
                    ),
                  ),
                ],
              ),
            ),
            PopupMenuItem(
              value: 'settings',
              child: Row(
                children: [
                  Icon(
                    Icons.settings_outlined,
                    size: 20.w,
                    color: const Color(0xFF64748B),
                  ),
                  SizedBox(width: 12.w),
                  Text(
                    'Settings',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: const Color(0xFF1E293B),
                    ),
                  ),
                ],
              ),
            ),
            PopupMenuItem(
              height: 1.w,
              enabled: false,
              child: Divider(
                color: const Color(0xFFE2E8F0),
                thickness: 1.w,
              ),
            ),
            PopupMenuItem(
              value: 'signout',
              child: Row(
                children: [
                  Icon(
                    Icons.logout,
                    size: 20.w,
                    color: const Color(0xFFEF4444),
                  ),
                  SizedBox(width: 12.w),
                  Text(
                    'Sign out',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: const Color(0xFFEF4444),
                    ),
                  ),
                ],
              ),
            ),
          ],
          onSelected: (value) {
            if (value == 'profile') {
              // Show profile dialog
              showDialog(
                context: context,
                builder: (_) => const ProfileDialogWithCubit(),
              );
            } else if (value == 'settings') {
              // Show settings dialog with global SettingsBloc
              showDialog(
                context: context,
                builder: (_) => BlocProvider.value(
                  value: context.read<SettingsBloc>(),
                  child: const SettingsDialog(),
                ),
              );
            } else if (value == 'signout') {
              // Sign out action
              context.read<AuthBloc>().add(const LogoutRequested());
              context.go(AppRoutes.login);
            }
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.w),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 16.r,
                  backgroundImage:
                      const NetworkImage('https://i.pravatar.cc/150?u=a042581f4e29026024d'),
                ),
                SizedBox(width: 12.w),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userName,
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF1E293B),
                      ),
                    ),
                    Text(
                      userRole,
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 8.w),
                Icon(
                  Icons.keyboard_arrow_down,
                  size: 20.w,
                  color: const Color(0xFF64748B),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
