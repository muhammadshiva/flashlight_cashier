import 'package:flashlight_pos/config/constans/text_styles_const.dart';
import 'package:flashlight_pos/config/themes/app_colors.dart';
import 'package:flashlight_pos/core/utils/currency_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderItemListRow extends StatelessWidget {
  final String name;
  final int price;
  final int qty;

  const OrderItemListRow({
    super.key,
    required this.name,
    required this.price,
    required this.qty,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyleConst.poppinsSemiBold14.copyWith(color: AppColors.slate800),
              ),
              SizedBox(height: 4.w),
              Text(
                price.toCurrencyFormat(),
                style: TextStyleConst.poppinsRegular12.copyWith(
                  color: AppColors.slate400,
                  fontSize: 13.sp,
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('x$qty',
                  style: TextStyleConst.poppinsRegular12.copyWith(
                    color: AppColors.slate500,
                    fontSize: 13.sp,
                  )),
              SizedBox(height: 4.w),
              Text(
                (price * qty).toCurrencyFormat(),
                style: TextStyleConst.poppinsBold14.copyWith(
                  color: AppColors.slate800,
                  fontSize: 13.sp,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
