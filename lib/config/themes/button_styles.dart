import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_colors.dart';

class ButtonStyles {
  // Primary Buttons
  static ButtonStyle primary = ElevatedButton.styleFrom(
    backgroundColor: AppColors.primary600,
    foregroundColor: AppColors.white,
    elevation: 0,
    shadowColor: Colors.transparent,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
    padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
    minimumSize: Size(120.w, 48.h),
    textStyle: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
  );

  // Secondary Buttons
  static ButtonStyle secondary = OutlinedButton.styleFrom(
    foregroundColor: AppColors.primary600,
    backgroundColor: AppColors.white,
    side: BorderSide(color: AppColors.primary600, width: 1.5),
    elevation: 0,
    shadowColor: Colors.transparent,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
    padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
    minimumSize: Size(120.w, 48.h),
    textStyle: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
  );

  // Success Buttons (for completed actions)
  static ButtonStyle success = ElevatedButton.styleFrom(
    backgroundColor: AppColors.success600,
    foregroundColor: AppColors.white,
    elevation: 0,
    shadowColor: Colors.transparent,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
    padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
    minimumSize: Size(120.w, 48.h),
    textStyle: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
  );

  // Warning Buttons (for caution actions)
  static ButtonStyle warning = ElevatedButton.styleFrom(
    backgroundColor: AppColors.warning600,
    foregroundColor: AppColors.white,
    elevation: 0,
    shadowColor: Colors.transparent,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
    padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
    minimumSize: Size(120.w, 48.h),
    textStyle: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
  );

  // Danger/Error Buttons (for delete, cancel actions)
  static ButtonStyle danger = ElevatedButton.styleFrom(
    backgroundColor: AppColors.error600,
    foregroundColor: AppColors.white,
    elevation: 0,
    shadowColor: Colors.transparent,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
    padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
    minimumSize: Size(120.w, 48.h),
    textStyle: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
  );

  // Small Buttons (for compact spaces)
  static ButtonStyle small = ElevatedButton.styleFrom(
    backgroundColor: AppColors.primary600,
    foregroundColor: AppColors.white,
    elevation: 0,
    shadowColor: Colors.transparent,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.r)),
    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
    minimumSize: Size(80.w, 32.h),
    textStyle: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
  );

  // Large Buttons (for primary actions)
  static ButtonStyle large = ElevatedButton.styleFrom(
    backgroundColor: AppColors.primary600,
    foregroundColor: AppColors.white,
    elevation: 0,
    shadowColor: Colors.transparent,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
    padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 16.h),
    minimumSize: Size(200.w, 56.h),
    textStyle: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700),
  );

  // Icon Buttons (for toolbar actions)
  static ButtonStyle iconButton = IconButton.styleFrom(
    foregroundColor: AppColors.primary600,
    backgroundColor: AppColors.primary50,
    padding: EdgeInsets.all(8.w),
    minimumSize: Size(40.w, 40.h),
    iconSize: 20.sp,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
  );

  // Text Buttons (for less important actions)
  static ButtonStyle textButton = TextButton.styleFrom(
    foregroundColor: AppColors.primary600,
    backgroundColor: Colors.transparent,
    elevation: 0,
    shadowColor: Colors.transparent,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
    minimumSize: Size(80.w, 36.h),
    textStyle: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
  );

  // POS Specific Buttons
  static ButtonStyle posAction = ElevatedButton.styleFrom(
    backgroundColor: AppColors.success600,
    foregroundColor: AppColors.white,
    elevation: 2,
    shadowColor: AppColors.success600.withOpacity(0.3),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
    minimumSize: Size(140.w, 50.h),
    textStyle: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700),
  );

  // Payment Method Buttons
  static ButtonStyle paymentMethod = OutlinedButton.styleFrom(
    foregroundColor: AppColors.blackText900,
    backgroundColor: AppColors.white,
    side: BorderSide(color: AppColors.backgroundGrey6, width: 1.5),
    elevation: 0,
    shadowColor: Colors.transparent,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
    minimumSize: Size(100.w, 60.h),
    textStyle: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
  );

  // Selected Payment Method
  static ButtonStyle paymentMethodSelected = ElevatedButton.styleFrom(
    backgroundColor: AppColors.primary600,
    foregroundColor: AppColors.white,
    elevation: 2,
    shadowColor: AppColors.primary600.withOpacity(0.3),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
    minimumSize: Size(100.w, 60.h),
    textStyle: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700),
  );

  // Floating Action Button Style
  static ButtonStyle fab = ElevatedButton.styleFrom(
    backgroundColor: AppColors.primary600,
    foregroundColor: AppColors.white,
    elevation: 4,
    shadowColor: AppColors.primary600.withOpacity(0.4),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
    padding: EdgeInsets.all(16.w),
    minimumSize: Size(56.w, 56.h),
  );
}

// Button Size Variants
class ButtonSizes {
  static const double smallHeight = 32;
  static const double mediumHeight = 48;
  static const double largeHeight = 56;
  static const double extraLargeHeight = 64;

  static const double smallPaddingHorizontal = 16;
  static const double mediumPaddingHorizontal = 24;
  static const double largePaddingHorizontal = 32;

  static const double smallFontSize = 14;
  static const double mediumFontSize = 16;
  static const double largeFontSize = 18;
}

// Button Colors for Different States
class ButtonColors {
  static const Color primaryDefault = AppColors.primary600;
  static const Color primaryHover = AppColors.primary700;
  static const Color primaryPressed = AppColors.primary800;
  static const Color primaryDisabled = AppColors.backgroundGrey4;

  static const Color secondaryDefault = AppColors.white;
  static const Color secondaryHover = AppColors.primary50;
  static const Color secondaryPressed = AppColors.primary100;

  static const Color successDefault = AppColors.success600;
  static const Color warningDefault = AppColors.warning600;
  static const Color dangerDefault = AppColors.error600;
}
