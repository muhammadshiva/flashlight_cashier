import 'package:flashlight_pos/config/themes/app_colors.dart';
import 'package:flashlight_pos/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:flashlight_pos/features/settings/presentation/cubit/notification_settings/notification_settings_cubit.dart';
import 'package:flashlight_pos/features/settings/presentation/cubit/pos_settings/pos_settings_cubit.dart';
import 'package:flashlight_pos/features/settings/presentation/cubit/printer_setting/printer_settings_cubit.dart';
import 'package:flashlight_pos/features/settings/presentation/cubit/store_info/store_info_cubit.dart';
import 'package:flashlight_pos/features/settings/presentation/cubit/ui_setting/settings_ui_cubit.dart';
import 'package:flashlight_pos/features/settings/presentation/widgets/sections/language_settings_section.dart';
import 'package:flashlight_pos/features/settings/presentation/widgets/sections/notification_settings_section.dart';
import 'package:flashlight_pos/features/settings/presentation/widgets/sections/pos_settings_section.dart';
import 'package:flashlight_pos/features/settings/presentation/widgets/sections/printer_settings_section.dart';
import 'package:flashlight_pos/features/settings/presentation/widgets/sections/receipt_settings_section.dart';
import 'package:flashlight_pos/features/settings/presentation/widgets/sections/store_info_section.dart';
import 'package:flashlight_pos/injection_container.dart';
import 'package:flashlight_pos/shared/models/ui_state_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Settings Dialog with BLoC pattern (Opsi 3: Hybrid)
///
/// Architecture:
/// - SettingsBloc (global): Data state management
/// - SettingsUICubit (dialog-scoped): UI state management
class SettingsDialog extends StatelessWidget {
  const SettingsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final dialogWidth = screenWidth * 0.8;

    return BlocProvider(
      // Create UI Cubit for this dialog (dialog-scoped)
      create: (_) => SettingsUICubit(),
      child: Builder(
        builder: (context) {
          return BlocListener<SettingsBloc, SettingsState>(
            listener: (context, state) {
              // Show snackbar for errors
              state.data.whenOrNull(
                error: (message) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(message),
                      backgroundColor: AppColors.error600,
                    ),
                  );
                },
              );
            },
            child: Dialog(
              insetPadding: EdgeInsets.symmetric(vertical: 70.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Container(
                width: dialogWidth,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    // Left Sidebar Menu
                    _buildSidebar(),

                    // Right Content Area
                    Expanded(
                      child: _buildContent(),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSidebar() {
    return Container(
      width: 250.w,
      decoration: const BoxDecoration(
        color: AppColors.backgroundGrey6,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          bottomLeft: Radius.circular(16),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(24),
            child: Text(
              'Settings Menu',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColors.blackFoundation600,
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<SettingsUICubit, SettingsUIState>(
              builder: (context, uiState) {
                return ListView(
                  padding: EdgeInsets.symmetric(horizontal: 12.w).copyWith(bottom: 24.h),
                  children: [
                    _buildMenuItem(
                      context,
                      icon: Icons.store_outlined,
                      label: 'Store Information',
                      value: 'store_info',
                      isSelected: uiState.selectedMenu == 'store_info',
                    ),
                    _buildMenuItem(
                      context,
                      icon: Icons.point_of_sale_outlined,
                      label: 'POS Settings',
                      value: 'pos_settings',
                      isSelected: uiState.selectedMenu == 'pos_settings',
                    ),
                    _buildMenuItem(
                      context,
                      icon: Icons.print_outlined,
                      label: 'Printer Settings',
                      value: 'printer_settings',
                      isSelected: uiState.selectedMenu == 'printer_settings',
                    ),
                    _buildMenuItem(
                      context,
                      icon: Icons.receipt_outlined,
                      label: 'Receipt Settings',
                      value: 'receipt_settings',
                      isSelected: uiState.selectedMenu == 'receipt_settings',
                    ),
                    _buildMenuItem(
                      context,
                      icon: Icons.language_outlined,
                      label: 'Language',
                      value: 'language',
                      isSelected: uiState.selectedMenu == 'language',
                    ),
                    _buildMenuItem(
                      context,
                      icon: Icons.notifications_outlined,
                      label: 'Notifications',
                      value: 'notifications',
                      isSelected: uiState.selectedMenu == 'notifications',
                    ),
                    _buildMenuItem(
                      context,
                      icon: Icons.security_outlined,
                      label: 'Security',
                      value: 'security',
                      isSelected: uiState.selectedMenu == 'security',
                    ),
                    _buildMenuItem(
                      context,
                      icon: Icons.cloud_upload_outlined,
                      label: 'Backup & Restore',
                      value: 'backup',
                      isSelected: uiState.selectedMenu == 'backup',
                    ),
                    _buildMenuItem(
                      context,
                      icon: Icons.display_settings_outlined,
                      label: 'Display',
                      value: 'display',
                      isSelected: uiState.selectedMenu == 'display',
                    ),
                    _buildMenuItem(
                      context,
                      icon: Icons.data_usage_outlined,
                      label: 'Data Management',
                      value: 'data_management',
                      isSelected: uiState.selectedMenu == 'data_management',
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
    required bool isSelected,
  }) {
    return InkWell(
      onTap: () {
        // Update UI state (menu selection)
        context.read<SettingsUICubit>().selectMenu(value);
      },
      borderRadius: BorderRadius.circular(8),
      child: Container(
        margin: const EdgeInsets.only(bottom: 4),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: isSelected ? 24.sp : 20.sp,
              color: isSelected ? AppColors.orangePrimary : AppColors.textGray2,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  color: isSelected ? AppColors.orangePrimary : AppColors.blackFoundation600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header with close button
        BlocBuilder<SettingsUICubit, SettingsUIState>(
          builder: (context, uiState) {
            return Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _getContentTitle(uiState.selectedMenu),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: AppColors.blackFoundation600,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close, color: AppColors.blackFoundation600),
                    style: IconButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),

        // Content based on selected menu
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: BlocBuilder<SettingsUICubit, SettingsUIState>(
              builder: (context, uiState) {
                switch (uiState.selectedMenu) {
                  case 'store_info':
                    return BlocProvider(
                      create: (_) => sl<StoreInfoCubit>(),
                      child: const StoreInfoSection(),
                    );

                  case 'pos_settings':
                    return BlocProvider(
                      create: (_) => sl<POSSettingsCubit>(),
                      child: const POSSettingsSection(),
                    );

                  case 'printer_settings':
                    return BlocProvider(
                      create: (_) => sl<PrinterSettingsCubit>(),
                      child: const PrinterSettingsSection(),
                    );

                  case 'receipt_settings':
                    return const ReceiptSettingsSection();

                  case 'language':
                    return const LanguageSettingsSection();

                  case 'notifications':
                    return BlocProvider(
                      create: (_) => sl<NotificationSettingsCubit>(),
                      child: const NotificationSettingsSection(),
                    );

                  // Placeholder untuk menu lainnya
                  default:
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(48),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.construction_outlined,
                              size: 64,
                              color: AppColors.textGray2.withValues(alpha: 0.5),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Content for ${_getContentTitle(uiState.selectedMenu)} coming soon',
                              style: const TextStyle(
                                fontSize: 14,
                                color: AppColors.textGray2,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    );
                }
              },
            ),
          ),
        ),
      ],
    );
  }

  String _getContentTitle(String menu) {
    switch (menu) {
      case 'store_info':
        return 'Store Information';
      case 'pos_settings':
        return 'POS Settings';
      case 'printer_settings':
        return 'Printer Settings';
      case 'receipt_settings':
        return 'Receipt Settings';
      case 'language':
        return 'Language';
      case 'notifications':
        return 'Notifications';
      case 'security':
        return 'Security';
      case 'backup':
        return 'Backup & Restore';
      case 'display':
        return 'Display';
      case 'data_management':
        return 'Data Management';
      default:
        return 'Settings';
    }
  }
}
