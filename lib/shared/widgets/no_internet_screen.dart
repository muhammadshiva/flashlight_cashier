import 'package:flashlight_pos/config/constans/app_lottie_const.dart';
import 'package:flashlight_pos/config/constans/text_styles_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../../config/themes/app_colors.dart';

class NoInternetScreen extends StatelessWidget {
  const NoInternetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Material(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: AppColors.backgroundGrey2,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(
                  AppLottieConst.noInternet,
                  width: 250.w,
                  height: 250.w,
                  fit: BoxFit.contain,
                ),
                24.verticalSpaceFromWidth,
                Text(
                  'Tidak Ada Koneksi Internet',
                  style: TextStyleConst.poppinsBold20.copyWith(
                    color: AppColors.blackText800,
                  ),
                ),
                12.verticalSpaceFromWidth,
                Text(
                  'Periksa koneksi internet Anda dan coba lagi.',
                  style: TextStyleConst.poppinsRegular14.copyWith(
                    color: AppColors.greyFoundation300,
                  ),
                  textAlign: TextAlign.center,
                ),
                8.verticalSpaceFromWidth,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 30.w,
                      height: 30.w,
                      child: Lottie.asset(
                        AppLottieConst.loading,
                        fit: BoxFit.contain,
                      ),
                    ),
                    8.horizontalSpace,
                    Text(
                      'Menunggu koneksi...',
                      style: TextStyleConst.poppinsRegular12.copyWith(
                        color: AppColors.greyFoundation200,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
