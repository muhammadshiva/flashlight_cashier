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
                  const Text(
                    'Display Options',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.blackFoundation600,
                    ),
                  ),
                  16.verticalSpace,

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

                  24.verticalSpace,

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

                  24.verticalSpace,

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

                  24.verticalSpace,

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

                  24.verticalSpace,

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

                  32.verticalSpace,

                  // Receipt Content
                  const Text(
                    'Receipt Content',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.blackFoundation600,
                    ),
                  ),
                  16.verticalSpace,

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

                  24.verticalSpace,

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
                  24.verticalSpace,
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
                      const Text(
                        'Receipt Preview',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppColors.blackFoundation600,
                        ),
                      ),
                      const Spacer(),
                      const Text(
                        'Live Preview',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.success600,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      8.horizontalSpace,
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: AppColors.success600,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ),
                  16.verticalSpace,

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
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.blackFoundation600,
          ),
        ),
        4.verticalSpace,
        Text(
          description,
          style: const TextStyle(
            fontSize: 13,
            color: AppColors.textGray2,
          ),
        ),
        12.verticalSpace,
        TextField(
          controller: TextEditingController(text: value)
            ..selection = TextSelection.fromPosition(
              TextPosition(offset: value.length),
            ),
          onChanged: onChanged,
          maxLines: maxLines,
          style: const TextStyle(
            fontSize: 14,
            color: AppColors.blackFoundation600,
          ),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.borderGray),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.borderGray),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.orangePrimary, width: 2),
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
      constraints: BoxConstraints(maxHeight: 600.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
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
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Logo (if enabled)
              if (receiptSettings.showLogo) ...[
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: AppColors.blackFoundation600,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.flash_on,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
                16.verticalSpace,
              ],

              // Store Info
              Text(
                appSettings.storeName,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.blackFoundation600,
                ),
                textAlign: TextAlign.center,
              ),
              4.verticalSpace,
              Text(
                appSettings.storeAddress,
                style: const TextStyle(
                  fontSize: 11,
                  color: AppColors.textGray2,
                ),
                textAlign: TextAlign.center,
              ),
              2.verticalSpace,
              Text(
                appSettings.storePhone,
                style: const TextStyle(
                  fontSize: 11,
                  color: AppColors.textGray2,
                ),
                textAlign: TextAlign.center,
              ),

              16.verticalSpace,

              // Header
              Text(
                receiptSettings.receiptHeader,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: AppColors.blackFoundation600,
                  letterSpacing: 1.5,
                ),
              ),

              12.verticalSpace,

              // Divider
              const Divider(color: AppColors.borderGray, thickness: 1),

              12.verticalSpace,

              // Transaction Info
              _buildReceiptRow('Date:', '2026-01-01 21:30'),
              _buildReceiptRow('Invoice:', '#INV-2026-0001'),
              _buildReceiptRow('Cashier:', 'Admin'),

              12.verticalSpace,
              const Divider(color: AppColors.borderGray, thickness: 1),
              12.verticalSpace,

              // Items
              _buildReceiptItemHeader(),
              8.verticalSpace,
              _buildReceiptItem('Oil Change', 1, 150000),
              _buildReceiptItem('Tire Replacement', 2, 200000),

              12.verticalSpace,
              const Divider(color: AppColors.borderGray, thickness: 1, height: 1),
              12.verticalSpace,

              // Subtotal
              _buildReceiptRow('Subtotal:', 'Rp 550,000', bold: false),

              // Discount (if enabled)
              if (receiptSettings.showDiscount) ...[
                8.verticalSpace,
                _buildReceiptRow('Discount (10%):', '- Rp 55,000', bold: false),
              ],

              // Tax (if enabled)
              if (receiptSettings.showTaxDetails) ...[
                8.verticalSpace,
                _buildReceiptRow('Tax (${appSettings.taxRate}%):', 'Rp 54,450', bold: false),
              ],

              12.verticalSpace,
              const Divider(color: AppColors.borderGray, thickness: 2, height: 1),
              12.verticalSpace,

              // Total
              _buildReceiptRow(
                'TOTAL:',
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
                12.verticalSpace,
                const Divider(color: AppColors.borderGray, thickness: 1, height: 1),
                12.verticalSpace,
                _buildReceiptRow('Payment:', 'Cash', bold: false),
                _buildReceiptRow('Paid:', 'Rp 600,000', bold: false),
                _buildReceiptRow('Change:', 'Rp 50,550', bold: false),
              ],

              // Footer Message (if enabled)
              if (receiptSettings.showFooterMessage &&
                  receiptSettings.footerMessage.isNotEmpty) ...[
                20.verticalSpace,
                const Divider(color: AppColors.borderGray, thickness: 1),
                12.verticalSpace,
                Text(
                  receiptSettings.footerMessage,
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppColors.textGray2,
                    fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],

              16.verticalSpace,
              Text(
                'Powered by Flashlight POS',
                style: TextStyle(
                  fontSize: 9,
                  color: AppColors.textGray2.withValues(alpha: 0.5),
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
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: larger ? 13 : 11,
              fontWeight: bold ? FontWeight.w700 : FontWeight.w500,
              color: AppColors.blackFoundation600,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: larger ? 13 : 11,
              fontWeight: bold ? FontWeight.w700 : FontWeight.w400,
              color: AppColors.blackFoundation600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReceiptItemHeader() {
    return const Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(
            'Item',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: AppColors.textGray2,
            ),
          ),
        ),
        SizedBox(
          width: 30,
          child: Text(
            'Qty',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: AppColors.textGray2,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(width: 8),
        SizedBox(
          width: 80,
          child: Text(
            'Amount',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: AppColors.textGray2,
            ),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }

  Widget _buildReceiptItem(String name, int qty, int price) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              name,
              style: const TextStyle(
                fontSize: 11,
                color: AppColors.blackFoundation600,
              ),
            ),
          ),
          SizedBox(
            width: 30,
            child: Text(
              '$qty',
              style: const TextStyle(
                fontSize: 11,
                color: AppColors.blackFoundation600,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 80,
            child: Text(
              'Rp ${(price * qty).toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}',
              style: const TextStyle(
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
