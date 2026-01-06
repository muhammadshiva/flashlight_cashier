import 'package:flashlight_pos/config/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Reusable Toggle Item Widget for Settings
///
/// A consistent toggle switch component used across settings screens.
/// Displays a label, description, optional loading state, and a switch.
class ToggleItem extends StatelessWidget {
  final String label;
  final String description;
  final bool value;
  final ValueChanged<bool>? onChanged;
  final bool isLoading;

  const ToggleItem({
    super.key,
    required this.label,
    required this.description,
    required this.value,
    required this.onChanged,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.blackFoundation600,
                ),
              ),
              4.verticalSpace,
              Text(
                description,
                style: TextStyle(
                  fontSize: 13,
                  color:
                      isLoading ? AppColors.textGray2.withValues(alpha: 0.5) : AppColors.textGray3,
                ),
              ),
            ],
          ),
        ),
        if (isLoading)
          const SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.orangeAccent),
            ),
          )
        else
          Switch(
            value: value,
            onChanged: onChanged,
            activeThumbColor: AppColors.orangeAccent,
            activeTrackColor: AppColors.warning3,
          ),
      ],
    );
  }
}
