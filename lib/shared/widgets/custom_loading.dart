import 'package:flashlight_pos/config/constans/app_lottie_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class CustomLoading extends StatelessWidget {
  final double? width;
  final String? lottiePath;

  const CustomLoading({
    super.key,
    this.width,
    this.lottiePath,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        child: Lottie.asset(
          lottiePath ?? AppLottieConst.lottieLoading,
          width: width ?? 500.sp,
        ),
      ),
    );
  }
}
