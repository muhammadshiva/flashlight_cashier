import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../../config/constans/app_lottie_const.dart';

class LoadingOverlayWidget extends StatelessWidget {
  final String message;
  final bool isVisible;
  final Widget child;

  const LoadingOverlayWidget({
    super.key,
    this.message = 'Memproses...',
    required this.isVisible,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isVisible)
          Container(
            color: Colors.black12,
            child: Center(
              child: Card(
                child: Padding(
                  padding: REdgeInsets.all(24.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Lottie.asset(
                        AppLottieConst.loading,
                        width: 100.sp,
                      ),
                      16.verticalSpaceFromWidth,
                      Text(message),
                    ],
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
