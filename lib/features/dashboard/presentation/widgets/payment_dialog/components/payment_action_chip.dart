import 'package:flashlight_pos/config/constans/text_styles_const.dart';
import 'package:flashlight_pos/config/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaymentActionChip extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final bool isSelected;

  const PaymentActionChip({
    super.key,
    required this.label,
    required this.onTap,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.w),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.orangePrimary : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? AppColors.orangePrimary : AppColors.slate200,
          ),
        ),
        child: Text(
          label,
          style: TextStyleConst.poppinsBold12.copyWith(
            fontSize: 13.sp,
            color: isSelected ? Colors.white : AppColors.slate500,
          ),
        ),
      ),
    );
  }
}
