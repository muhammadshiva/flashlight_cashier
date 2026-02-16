import 'package:flashlight_pos/config/constans/text_styles_const.dart';
import 'package:flashlight_pos/config/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaymentDetailRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isBold;
  final Color? valueColor;
  final IconData? icon;

  const PaymentDetailRow({
    super.key,
    required this.label,
    required this.value,
    this.isBold = false,
    this.valueColor,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyleConst.poppinsRegular14.copyWith(color: AppColors.slate500),
        ),
        Row(
          children: [
            if (icon != null) ...[
              Icon(icon, size: 16.w, color: valueColor ?? AppColors.slate800),
              SizedBox(width: 4.w),
            ],
            Text(
              value,
              style: (isBold ? TextStyleConst.poppinsBold14 : TextStyleConst.poppinsRegular14)
                  .copyWith(
                color: valueColor ?? AppColors.slate800,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
