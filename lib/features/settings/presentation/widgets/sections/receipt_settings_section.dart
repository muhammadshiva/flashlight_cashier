import 'package:flashlight_pos/config/constans/text_styles_const.dart';
import 'package:flashlight_pos/config/themes/app_colors.dart';
import 'package:flashlight_pos/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:flashlight_pos/shared/widgets/toggle_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Receipt Settings Section with BLoC pattern
///
/// Features:
/// - Customize receipt display options (logo, discount, tax details, etc.)
/// - Live preview of receipt with current settings
class ReceiptSettingsSection extends StatelessWidget {
  const ReceiptSettingsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      buildWhen: (previous, current) =>
          previous.receiptSettings != current.receiptSettings ||
          previous.appSettings != current.appSettings,
      builder: (context, state) {
        final receiptSettings = state.receiptSettings;
        final appSettings = state.appSettings;

        // Return loading state if settings not available
        if (receiptSettings == null || appSettings == null) {
          return const Center(child: CircularProgressIndicator());
        }

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left: Settings Panel
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Display Options
                  Text(
                    'Display Options',
                    style: TextStyleConst.poppinsBold16.copyWith(
                      color: AppColors.blackFoundation600,
                    ),
                  ),
                  16.verticalSpaceFromWidth,

                  ToggleItem(
                    label: 'Show Store Logo',
                    description: 'Display store logo at the top of receipt',
                    value: receiptSettings.showLogo,
                    onChanged: (value) {
                      context.read<SettingsBloc>().add(
                            UpdateReceiptSettingsEvent(
                              settings: receiptSettings.copyWith(showLogo: value),
                            ),
                          );
                    },
                  ),

                  24.verticalSpaceFromWidth,

                  ToggleItem(
                    label: 'Show Tax Details',
                    description: 'Display tax breakdown on receipt',
                    value: receiptSettings.showTaxDetails,
                    onChanged: (value) {
                      context.read<SettingsBloc>().add(
                            UpdateReceiptSettingsEvent(
                              settings: receiptSettings.copyWith(showTaxDetails: value),
                            ),
                          );
                    },
                  ),

                  24.verticalSpaceFromWidth,

                  ToggleItem(
                    label: 'Show Discount',
                    description: 'Display discount information if applicable',
                    value: receiptSettings.showDiscount,
                    onChanged: (value) {
                      context.read<SettingsBloc>().add(
                            UpdateReceiptSettingsEvent(
                              settings: receiptSettings.copyWith(showDiscount: value),
                            ),
                          );
                    },
                  ),

                  24.verticalSpaceFromWidth,

                  ToggleItem(
                    label: 'Show Payment Method',
                    description: 'Display payment method used',
                    value: receiptSettings.showPaymentMethod,
                    onChanged: (value) {
                      context.read<SettingsBloc>().add(
                            UpdateReceiptSettingsEvent(
                              settings: receiptSettings.copyWith(showPaymentMethod: value),
                            ),
                          );
                    },
                  ),

                  24.verticalSpaceFromWidth,

                  ToggleItem(
                    label: 'Show Footer Message',
                    description: 'Display custom message at bottom of receipt',
                    value: receiptSettings.showFooterMessage,
                    onChanged: (value) {
                      context.read<SettingsBloc>().add(
                            UpdateReceiptSettingsEvent(
                              settings: receiptSettings.copyWith(showFooterMessage: value),
                            ),
                          );
                    },
                  ),

                  32.verticalSpaceFromWidth,

                  // Receipt Content
                  Text(
                    'Receipt Content',
                    style: TextStyleConst.poppinsBold16.copyWith(
                      color: AppColors.blackFoundation600,
                    ),
                  ),
                  16.verticalSpaceFromWidth,

                  _buildTextFieldItem(
                    context,
                    label: 'Receipt Header',
                    description: 'Custom header text (e.g., "INVOICE", "RECEIPT")',
                    value: receiptSettings.receiptHeader,
                    onChanged: (value) {
                      context.read<SettingsBloc>().add(
                            UpdateReceiptSettingsEvent(
                              settings: receiptSettings.copyWith(receiptHeader: value),
                            ),
                          );
                    },
                  ),

                  24.verticalSpaceFromWidth,

                  _buildTextFieldItem(
                    context,
                    label: 'Footer Message',
                    description:
                        'Message displayed at bottom (e.g., "Thank you for your purchase!")',
                    value: receiptSettings.footerMessage,
                    maxLines: 2,
                    onChanged: (value) {
                      context.read<SettingsBloc>().add(
                            UpdateReceiptSettingsEvent(
                              settings: receiptSettings.copyWith(footerMessage: value),
                            ),
                          );
                    },
                  ),
                  24.verticalSpaceFromWidth,
                ],
              ),
            ),

            32.horizontalSpace,

            // Right: Preview Panel
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Receipt Preview',
                        style: TextStyleConst.poppinsBold16.copyWith(
                          color: AppColors.blackFoundation600,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        'Live Preview',
                        style: TextStyleConst.poppinsSemiBold12.copyWith(
                          color: AppColors.success600,
                        ),
                      ),
                      8.horizontalSpace,
                      Container(
                        width: 8.w,
                        height: 8.w,
                        decoration: const BoxDecoration(
                          color: AppColors.success600,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ),
                  16.verticalSpaceFromWidth,

                  // Receipt Preview Card
                  _buildReceiptPreview(
                    context,
                    receiptSettings: receiptSettings,
                    appSettings: appSettings,
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTextFieldItem(
    BuildContext context, {
    required String label,
    required String description,
    required String value,
    required ValueChanged<String> onChanged,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyleConst.poppinsSemiBold14.copyWith(
            color: AppColors.blackFoundation600,
          ),
        ),
        4.verticalSpaceFromWidth,
        Text(
          description,
          style: TextStyleConst.poppinsRegular12.copyWith(
            fontSize: 13,
            color: AppColors.textGray2,
          ),
        ),
        12.verticalSpaceFromWidth,
        TextField(
          controller: TextEditingController(text: value)
            ..selection = TextSelection.fromPosition(
              TextPosition(offset: value.length),
            ),
          onChanged: onChanged,
          maxLines: maxLines,
          style: TextStyleConst.poppinsRegular14.copyWith(
            color: AppColors.blackFoundation600,
          ),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.w),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: const BorderSide(color: AppColors.borderGray),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: const BorderSide(color: AppColors.borderGray),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: AppColors.orangePrimary, width: 2.w),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildReceiptPreview(
    BuildContext context, {
    required receiptSettings,
    required appSettings,
  }) {
    return Container(
      constraints: BoxConstraints(maxHeight: 600.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppColors.borderGray),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Logo (if enabled)
              if (receiptSettings.showLogo) ...[
                Container(
                  width: 60.w,
                  height: 60.w,
                  decoration: BoxDecoration(
                    color: AppColors.blackFoundation600,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Icon(
                    Icons.flash_on,
                    color: Colors.white,
                    size: 32.w,
                  ),
                ),
                16.verticalSpaceFromWidth,
              ],

              // Store Info
              Text(
                appSettings.storeName,
                style: TextStyleConst.poppinsBold16.copyWith(
                  color: AppColors.blackFoundation600,
                ),
                textAlign: TextAlign.center,
              ),
              4.verticalSpaceFromWidth,
              Text(
                appSettings.storeAddress,
                style: TextStyleConst.poppinsRegular12.copyWith(
                  fontSize: 11,
                  color: AppColors.textGray3,
                ),
                textAlign: TextAlign.center,
              ),
              2.verticalSpaceFromWidth,
              Text(
                appSettings.storePhone,
                style: TextStyleConst.poppinsRegular12.copyWith(
                  fontSize: 11,
                  color: AppColors.textGray3,
                ),
                textAlign: TextAlign.center,
              ),

              16.verticalSpaceFromWidth,

              // Header
              Text(
                receiptSettings.receiptHeader,
                style: TextStyleConst.poppinsBold14.copyWith(
                  color: AppColors.blackFoundation600,
                  letterSpacing: 1.5,
                ),
              ),

              12.verticalSpaceFromWidth,

              // Divider
              const Divider(color: AppColors.borderGray, thickness: 1),

              12.verticalSpaceFromWidth,

              // Transaction Info
              _buildReceiptRow('Date', '2026-01-01 21:30'),
              _buildReceiptRow('Invoice', '#INV-2026-0001'),
              _buildReceiptRow('Cashier', 'Admin'),

              12.verticalSpaceFromWidth,
              const Divider(color: AppColors.borderGray, thickness: 1, height: 1),
              12.verticalSpaceFromWidth,

              _buildReceiptRow('Customer', 'Budi Santoso'),
              _buildReceiptRow('Vehicle', 'Honda Vario 160'),
              _buildReceiptRow('Plate No', 'B 1234 XYZ'),

              12.verticalSpaceFromWidth,
              const Divider(color: AppColors.borderGray, thickness: 1),
              12.verticalSpaceFromWidth,

              // Items
              _buildReceiptItemHeader(),
              8.verticalSpaceFromWidth,
              _buildReceiptItem('Oil Change', 1, 150000),
              _buildReceiptItem('Tire Replacement', 2, 200000),

              12.verticalSpaceFromWidth,
              const Divider(color: AppColors.borderGray, thickness: 1, height: 1),
              12.verticalSpaceFromWidth,

              // Subtotal
              _buildReceiptRow('Subtotal', 'Rp 550,000', bold: false),

              // Discount (if enabled)
              if (receiptSettings.showDiscount) ...[
                8.verticalSpaceFromWidth,
                _buildReceiptRow('Discount (10%)', '- Rp 55,000', bold: false),
              ],

              // Tax (if enabled)
              if (receiptSettings.showTaxDetails) ...[
                8.verticalSpaceFromWidth,
                _buildReceiptRow('Tax (${appSettings.taxRate}%)', 'Rp 54,450', bold: false),
              ],

              12.verticalSpaceFromWidth,
              Divider(color: AppColors.borderGray, thickness: 2, height: 1.w),
              12.verticalSpaceFromWidth,

              // Total
              _buildReceiptRow(
                'TOTAL',
                receiptSettings.showDiscount && receiptSettings.showTaxDetails
                    ? 'Rp 549,450'
                    : receiptSettings.showDiscount
                        ? 'Rp 495,000'
                        : receiptSettings.showTaxDetails
                            ? 'Rp 604,450'
                            : 'Rp 550,000',
                bold: true,
                larger: true,
              ),

              // Payment Method (if enabled)
              if (receiptSettings.showPaymentMethod) ...[
                12.verticalSpaceFromWidth,
                const Divider(color: AppColors.borderGray, thickness: 1, height: 1),
                12.verticalSpaceFromWidth,
                _buildReceiptRow('Payment', 'Cash', bold: false),
                _buildReceiptRow('Paid', 'Rp 600,000', bold: false),
                _buildReceiptRow('Change', 'Rp 50,550', bold: false),
              ],

              // Footer Message (if enabled)
              if (receiptSettings.showFooterMessage &&
                  receiptSettings.footerMessage.isNotEmpty) ...[
                20.verticalSpaceFromWidth,
                const Divider(color: AppColors.borderGray, thickness: 1),
                12.verticalSpaceFromWidth,
                Text(
                  receiptSettings.footerMessage,
                  style: TextStyleConst.poppinsRegular12.copyWith(
                    fontSize: 11,
                    color: AppColors.textGray3,
                    fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],

              16.verticalSpaceFromWidth,
              Text(
                'Powered by Flashlight POS',
                style: TextStyleConst.poppinsRegular10.copyWith(
                  fontSize: 9,
                  color: AppColors.textGray3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReceiptRow(
    String label,
    String value, {
    bool bold = false,
    bool larger = false,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 4,
            child: Text(
              label,
              style:
                  (bold ? TextStyleConst.poppinsBold12 : TextStyleConst.poppinsMedium12).copyWith(
                fontSize: larger ? 13 : 11,
                color: AppColors.blackFoundation600,
              ),
            ),
          ),
          Text(
            ':',
            style: (bold ? TextStyleConst.poppinsBold12 : TextStyleConst.poppinsMedium12).copyWith(
              fontSize: larger ? 13 : 11,
              color: AppColors.blackFoundation600,
            ),
          ),
          const Spacer(),
          Expanded(
            flex: 5,
            child: Text(
              value,
              textAlign: TextAlign.right,
              style:
                  (bold ? TextStyleConst.poppinsBold12 : TextStyleConst.poppinsRegular12).copyWith(
                fontSize: larger ? 13 : 11,
                color: AppColors.blackFoundation600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReceiptItemHeader() {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(
            'Item',
            style: TextStyleConst.poppinsSemiBold12.copyWith(
              fontSize: 11,
              color: AppColors.textGray3,
            ),
          ),
        ),
        SizedBox(
          width: 30.w,
          child: Text(
            'Qty',
            style: TextStyleConst.poppinsSemiBold12.copyWith(
              fontSize: 11,
              color: AppColors.textGray3,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(width: 8.w),
        SizedBox(
          width: 80.w,
          child: Text(
            'Amount',
            style: TextStyleConst.poppinsSemiBold12.copyWith(
              fontSize: 11,
              color: AppColors.textGray3,
            ),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }

  Widget _buildReceiptItem(String name, int qty, int price) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.w),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              name,
              style: TextStyleConst.poppinsRegular12.copyWith(
                fontSize: 11,
                color: AppColors.blackFoundation600,
              ),
            ),
          ),
          SizedBox(
            width: 30.w,
            child: Text(
              '$qty',
              style: TextStyleConst.poppinsRegular12.copyWith(
                fontSize: 11,
                color: AppColors.blackFoundation600,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(width: 8.w),
          SizedBox(
            width: 80.w,
            child: Text(
              'Rp ${(price * qty).toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}',
              style: TextStyleConst.poppinsRegular12.copyWith(
                fontSize: 11,
                color: AppColors.blackFoundation600,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
