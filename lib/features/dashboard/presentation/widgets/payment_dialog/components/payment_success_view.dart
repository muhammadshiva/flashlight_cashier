import 'package:flashlight_pos/config/constans/text_styles_const.dart';
import 'package:flashlight_pos/config/themes/app_colors.dart';
import 'package:flashlight_pos/core/utils/currency_formatter.dart';
import 'package:flashlight_pos/features/dashboard/presentation/widgets/payment_dialog/components/payment_detail_row.dart';
import 'package:flashlight_pos/shared/enum/payment_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaymentSuccessView extends StatelessWidget {
  final double grandTotal;
  final PaymentMethodType selectedPaymentMethod;
  final String refNo;
  final double inputAmount;
  final double change;
  final int autoCloseTimer;
  final VoidCallback onPrintReceipt;
  final VoidCallback onConfirm;

  const PaymentSuccessView({
    super.key,
    required this.grandTotal,
    required this.selectedPaymentMethod,
    required this.refNo,
    required this.inputAmount,
    required this.change,
    required this.autoCloseTimer,
    required this.onPrintReceipt,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 400.w,
        padding: EdgeInsets.symmetric(vertical: 32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Success Icon
            Container(
              width: 80.w,
              height: 80.w,
              decoration: const BoxDecoration(
                color: AppColors.greenLight100,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.check, color: Colors.white, size: 48.sp),
            ),
            SizedBox(height: 24.w),
            Text(
              'Payment Successful!',
              style: TextStyleConst.poppinsBold20.copyWith(
                color: AppColors.slate800,
              ),
            ),
            SizedBox(height: 8.w),
            Text(
              'Don\'t forget to say Thank You to customers',
              style: TextStyleConst.poppinsRegular14.copyWith(color: AppColors.slate400),
            ),
            SizedBox(height: 32.w),
            // Details Card
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.slate200),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16.w),
                    decoration: const BoxDecoration(
                      border: Border(bottom: BorderSide(color: AppColors.slate100)),
                    ),
                    child: Text(
                      'Detail Payment',
                      style: TextStyleConst.poppinsBold14.copyWith(color: AppColors.slate800),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16.w),
                    child: Column(
                      children: [
                        PaymentDetailRow(
                            label: 'Total Payment',
                            value: grandTotal.toCurrencyFormat(),
                            isBold: true),
                        SizedBox(height: 12.w),
                        PaymentDetailRow(
                            label: 'Payment Method',
                            value: selectedPaymentMethod.isCash
                                ? 'Cash'
                                : (selectedPaymentMethod.isCard ? 'Card' : 'QR Code'),
                            valueColor: AppColors.orangePrimary,
                            icon: selectedPaymentMethod.isCash
                                ? Icons.money
                                : (selectedPaymentMethod.isCard
                                    ? Icons.credit_card
                                    : Icons.qr_code)),
                        SizedBox(height: 12.w),
                        if (!selectedPaymentMethod.isCash && refNo.isNotEmpty) ...[
                          PaymentDetailRow(label: 'Ref No.', value: refNo),
                          SizedBox(height: 12.w),
                        ],
                        PaymentDetailRow(
                            label: 'Customer Pays',
                            value: inputAmount.toCurrencyFormat(),
                            isBold: true),
                      ],
                    ),
                  ),
                  Divider(height: 1.w),
                  Padding(
                    padding: EdgeInsets.all(16.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Change',
                          style: TextStyleConst.poppinsMedium16.copyWith(
                            color: AppColors.slate500,
                          ),
                        ),
                        Text(
                          change.toCurrencyFormat(),
                          style: TextStyleConst.poppinsBold18.copyWith(
                            color: AppColors.slate800,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 32.w),
            // Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: onPrintReceipt,
                    icon: Icon(Icons.print_outlined, size: 20.sp),
                    label: const Text('Print Bill'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.slate800,
                      side: const BorderSide(color: AppColors.slate200),
                      padding: EdgeInsets.symmetric(vertical: 16.w),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                    ),
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: ElevatedButton(
                    onPressed: onConfirm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.orangePrimary,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 16.w),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                      elevation: 0,
                    ),
                    child: const Text('Confirm Payment',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.w),
            RichText(
              text: TextSpan(
                text: 'Auto close in ',
                style: TextStyleConst.poppinsRegular14.copyWith(color: AppColors.textGray3),
                children: [
                  TextSpan(
                    text: '$autoCloseTimer',
                    style: const TextStyle(color: AppColors.orangePrimary),
                  ),
                  const TextSpan(
                    text: ' seconds ...',
                    style: TextStyle(color: AppColors.textGray3),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
