import 'package:flashlight_pos/config/constans/text_styles_const.dart';
import 'package:flashlight_pos/config/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class KeypadButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const KeypadButton(this.label, {super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: 64.w, // Fixed height for keypad buttons
        child: TextButton(
            onPressed: onPressed,
            child: Text(
              label,
              style: TextStyleConst.poppinsBold24.copyWith(
                color: AppColors.grayMedium,
              ),
            )),
      ),
    );
  }
}
