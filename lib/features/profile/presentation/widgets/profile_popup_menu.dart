import 'package:flashlight_pos/config/themes/app_colors.dart';
import 'package:flashlight_pos/configs/injector/injector_config.dart';
import 'package:flashlight_pos/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:flashlight_pos/features/profile/presentation/widgets/profile_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Profile Popup Menu
///
/// Menampilkan pop menu saat icon profile diklik
/// Berisi opsi untuk membuka dialog edit profile
class ProfilePopupMenu extends StatelessWidget {
  const ProfilePopupMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(
        Icons.account_circle,
        color: AppColors.blackFoundation600,
        size: 32,
      ),
      tooltip: 'Profile',
      color: AppColors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      itemBuilder: (BuildContext context) => [
        PopupMenuItem<String>(
          value: 'edit_profile',
          child: Row(
            children: [
              const Icon(
                Icons.edit,
                size: 20,
                color: AppColors.blackFoundation600,
              ),
              12.horizontalSpace,
              const Text(
                'Edit Profile',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.blackFoundation600,
                ),
              ),
            ],
          ),
        ),
        PopupMenuItem<String>(
          value: 'view_profile',
          child: Row(
            children: [
              const Icon(
                Icons.visibility,
                size: 20,
                color: AppColors.blackFoundation600,
              ),
              12.horizontalSpace,
              const Text(
                'View Profile',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.blackFoundation600,
                ),
              ),
            ],
          ),
        ),
      ],
      onSelected: (String value) {
        if (value == 'edit_profile') {
          _showProfileDialog(context);
        } else if (value == 'view_profile') {
          _showProfileDialog(context);
        }
      },
    );
  }

  void _showProfileDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return BlocProvider(
          create: (_) => sl<ProfileCubit>(),
          child: const ProfileDialog(),
        );
      },
    );
  }
}
