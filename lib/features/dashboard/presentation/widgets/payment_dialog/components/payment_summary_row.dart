import 'package:flashlight_pos/config/constans/text_styles_const.dart';
import 'package:flashlight_pos/config/themes/app_colors.dart';
import 'package:flashlight_pos/core/utils/currency_formatter.dart';
import 'package:flutter/material.dart';

class PaymentSummaryRow extends StatelessWidget {
  final String label;
  final double value;

  const PaymentSummaryRow({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyleConst.poppinsRegular14.copyWith(color: AppColors.slate500)),
        Text(
          value.toCurrencyFormat(),
          style: TextStyleConst.poppinsSemiBold14.copyWith(color: AppColors.slate800),
        ),
      ],
    );
  }
}
