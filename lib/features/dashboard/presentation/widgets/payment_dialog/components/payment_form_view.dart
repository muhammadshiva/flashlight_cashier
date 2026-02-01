import 'package:flashlight_pos/config/constans/text_styles_const.dart';
import 'package:flashlight_pos/config/themes/app_colors.dart';
import 'package:flashlight_pos/core/utils/currency_formatter.dart';
import 'package:flashlight_pos/features/customer/domain/entities/customer.dart';
import 'package:flashlight_pos/features/dashboard/presentation/widgets/payment_dialog/components/keypad_button.dart';
import 'package:flashlight_pos/features/dashboard/presentation/widgets/payment_dialog/components/order_item_list_row.dart';
import 'package:flashlight_pos/features/dashboard/presentation/widgets/payment_dialog/components/payment_action_chip.dart';
import 'package:flashlight_pos/features/dashboard/presentation/widgets/payment_dialog/components/payment_summary_row.dart';
import 'package:flashlight_pos/features/dashboard/presentation/widgets/payment_dialog/components/payment_tab.dart';
import 'package:flashlight_pos/features/work_order/domain/entities/work_order.dart';
import 'package:flashlight_pos/shared/enum/payment_enum.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class PaymentFormView extends StatelessWidget {
  final PaymentMethodType selectedPaymentMethod;
  final ValueChanged<PaymentMethodType> onPaymentMethodChanged;
  final Customer? customer;
  final WorkOrder order;
  final double taxAmount;
  final double grandTotal;
  final String inputAmountStr;
  final Function(String) onKeypadTap;
  final Function(int) onSetAmount;
  final ValueListenable<bool> isToastActiveNotifier;
  final VoidCallback onProcessPayment;
  final TextEditingController refNoController;
  final VoidCallback onClose;

  const PaymentFormView({
    super.key,
    required this.selectedPaymentMethod,
    required this.onPaymentMethodChanged,
    required this.customer,
    required this.order,
    required this.taxAmount,
    required this.grandTotal,
    required this.inputAmountStr,
    required this.onKeypadTap,
    required this.onSetAmount,
    required this.isToastActiveNotifier,
    required this.onProcessPayment,
    required this.refNoController,
    required this.onClose,
  });

  double get _inputAmount => double.tryParse(inputAmountStr) ?? 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Header
        _buildHeader(),
        Divider(height: 1.w),
        Expanded(
          child: Row(
            children: [
              // LEFT PANEL: Order Details
              _buildOrderDetailsSection(),
              VerticalDivider(width: 1.w),
              // RIGHT PANEL: Payment
              _buildPaymentSection(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.w),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: AppColors.slate800,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(Icons.wallet, color: Colors.white, size: 20.sp),
          ),
          SizedBox(width: 12.w),
          Text(
            'Payment',
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          IconButton(
            onPressed: onClose,
            icon: Icon(Icons.close, size: 20.sp),
            style: IconButton.styleFrom(
                backgroundColor: AppColors.slate100,
                padding: EdgeInsets.zero,
                minimumSize: Size(36.w, 36.w),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r))),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderDetailsSection() {
    return Expanded(
      flex: 7,
      child: Container(
        color: Colors.white,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Customer Info Header
                      Padding(
                        padding: EdgeInsets.all(24.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  customer?.name ?? 'Guest Customer',
                                  style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 4.w),
                                Text(
                                  'Order #${order.workOrderCode}',
                                  style: TextStyleConst.poppinsRegular12.copyWith(
                                    color: AppColors.slate500,
                                    fontSize: 13.sp,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              DateFormat('EEE, d MMM\nh:mm a').format(DateTime.now()),
                              textAlign: TextAlign.right,
                              style: TextStyleConst.poppinsRegular12.copyWith(
                                color: AppColors.slate500,
                                fontSize: 13.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Search Member Input
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                        child: Row(
                          children: [
                            Expanded(
                              child: SizedBox(
                                height: 48.w,
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: 'Input Member Code',
                                    hintStyle: TextStyleConst.poppinsRegular14
                                        .copyWith(color: AppColors.slate400),
                                    filled: true,
                                    fillColor: Colors.white,
                                    contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.r),
                                      borderSide: const BorderSide(color: AppColors.slate200),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.r),
                                      borderSide: const BorderSide(color: AppColors.slate200),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 12.w),
                            SizedBox(
                              height: 48.w,
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.orangePrimary,
                                    foregroundColor: Colors.white,
                                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8.r))),
                                child: const Text('Search'),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 24.w),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                        child: SizedBox(
                          width: double.infinity,
                          child: Text(
                            'Order Details',
                            style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Divider(height: 32.w, indent: 24.w, endIndent: 24.w),
                      // List
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                        child: Column(
                          children: [
                            ...order.services.map((s) => OrderItemListRow(
                                  name: s.service?.name ?? 'Service',
                                  price: s.priceAtOrder,
                                  qty: s.quantity,
                                )),
                            ...order.products.map((p) => OrderItemListRow(
                                  name: p.product?.name ?? 'Product',
                                  price: p.priceAtOrder,
                                  qty: p.quantity,
                                )),
                          ],
                        ),
                      ),
                      const Spacer(),
                      // Totals
                      Container(
                        padding: EdgeInsets.all(24.w),
                        decoration: const BoxDecoration(
                          border: Border(top: BorderSide(color: AppColors.slate200)),
                        ),
                        child: Column(
                          children: [
                            PaymentSummaryRow(
                                label: 'Sub Total', value: order.totalPrice.toDouble()),
                            SizedBox(height: 8.w),
                            PaymentSummaryRow(label: 'Tax 11%', value: taxAmount),
                            Divider(height: 32.w),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Total Payment',
                                  style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  grandTotal.toCurrencyFormat(),
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            if (selectedPaymentMethod.isCash) ...[
                              SizedBox(height: 8.w),
                              _buildChangeRow(),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildPaymentSection() {
    return Expanded(
      flex: 5,
      child: Container(
        color: AppColors.slate50,
        padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 16.w),
        child: Column(
          children: [
            // Tab Bar
            Container(
              height: 44.w,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: AppColors.slate200),
              ),
              child: Row(
                children: [
                  PaymentTab(
                      label: 'Cash',
                      icon: Icons.money,
                      isSelected: selectedPaymentMethod.isCash,
                      onTap: () => onPaymentMethodChanged(PaymentMethodType.cash)),
                  Container(width: 1, height: 20.w, color: AppColors.slate200),
                  PaymentTab(
                      label: 'Card',
                      icon: Icons.credit_card,
                      isSelected: selectedPaymentMethod.isCard,
                      onTap: () => onPaymentMethodChanged(PaymentMethodType.card)),
                  Container(width: 1, height: 20, color: AppColors.slate200),
                  PaymentTab(
                      label: 'QR Code',
                      icon: Icons.qr_code,
                      isSelected: selectedPaymentMethod.isQris,
                      onTap: () => onPaymentMethodChanged(PaymentMethodType.qris)),
                ],
              ),
            ),

            SizedBox(height: 24.w),

            // DYNAMIC CONTENT BASED ON PAYMENT METHOD
            if (selectedPaymentMethod.isCash)
              _buildCashPaymentContent()
            else
              _buildExternalPaymentContent(), // Card or QR
          ],
        ),
      ),
    );
  }

  Widget _buildCashPaymentContent() {
    return Expanded(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                  children: [
                    const Spacer(flex: 1),
                    Text(
                      'Input Money',
                      style: TextStyleConst.poppinsMedium14.copyWith(color: AppColors.slate500),
                    ),
                    SizedBox(height: 4.w),
                    Text(
                      'Enter cash amount received',
                      style: TextStyleConst.poppinsRegular12.copyWith(color: AppColors.slate400),
                    ),
                    SizedBox(height: 12.w),
                    // Display Input
                    Text(
                      inputAmountStr.isEmpty
                          ? 'Rp 0'
                          : 'Rp ${int.tryParse(inputAmountStr)?.toCurrencyFormat().replaceAll("Rp ", "") ?? inputAmountStr}',
                      style: TextStyleConst.poppinsBold32.copyWith(color: AppColors.slate800),
                    ),
                    SizedBox(height: 24.w),
                    // Quick Amounts
                    Scrollbar(
                      thumbVisibility: true,
                      trackVisibility: true,
                      thickness: 1.sp,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.only(bottom: 8.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            PaymentActionChip(
                                isSelected: inputAmountStr == grandTotal.toInt().toString(),
                                label: 'Uang Pas',
                                onTap: () => onSetAmount(grandTotal.toInt())),
                            SizedBox(width: 8.w),
                            PaymentActionChip(
                                isSelected: _inputAmount == 10000,
                                label: 10000.toCurrencyFormat().replaceAll(",00", ""),
                                onTap: () => onSetAmount(10000)),
                            SizedBox(width: 8.w),
                            PaymentActionChip(
                                isSelected: _inputAmount == 20000,
                                label: 20000.toCurrencyFormat().replaceAll(",00", ""),
                                onTap: () => onSetAmount(20000)),
                            SizedBox(width: 8.w),
                            PaymentActionChip(
                                isSelected: _inputAmount == 50000,
                                label: 50000.toCurrencyFormat().replaceAll(",00", ""),
                                onTap: () => onSetAmount(50000)),
                            SizedBox(width: 8.w),
                            PaymentActionChip(
                                isSelected: _inputAmount == 100000,
                                label: 100000.toCurrencyFormat().replaceAll(",00", ""),
                                onTap: () => onSetAmount(100000)),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 24.w),

                    /// Keypad
                    Column(
                      children: [
                        Row(children: [
                          KeypadButton('1', onPressed: () => onKeypadTap('1')),
                          KeypadButton('2', onPressed: () => onKeypadTap('2')),
                          KeypadButton('3', onPressed: () => onKeypadTap('3')),
                        ]),
                        Row(children: [
                          KeypadButton('4', onPressed: () => onKeypadTap('4')),
                          KeypadButton('5', onPressed: () => onKeypadTap('5')),
                          KeypadButton('6', onPressed: () => onKeypadTap('6')),
                        ]),
                        Row(children: [
                          KeypadButton('7', onPressed: () => onKeypadTap('7')),
                          KeypadButton('8', onPressed: () => onKeypadTap('8')),
                          KeypadButton('9', onPressed: () => onKeypadTap('9')),
                        ]),
                        Row(children: [
                          // const Spacer(), // Empty slot
                          KeypadButton('00', onPressed: () => onKeypadTap('00')),
                          KeypadButton('0', onPressed: () => onKeypadTap('0')),
                          // Backspace Button
                          Expanded(
                            child: SizedBox(
                              height: 64.w,
                              child: Material(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(100.r),
                                child: InkWell(
                                  onTap: () => onKeypadTap('DEL'),
                                  borderRadius: BorderRadius.circular(100.r),
                                  child: Center(
                                    child: Icon(
                                      Icons.backspace_outlined,
                                      color: AppColors.slate500,
                                      size: 24.w,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ]),
                      ],
                    ),
                    const Spacer(flex: 2),
                    SizedBox(
                      width: double.infinity,
                      child: ValueListenableBuilder<bool>(
                        valueListenable: isToastActiveNotifier,
                        builder: (context, isToastActive, child) {
                          return ElevatedButton(
                            onPressed: isToastActive ? null : onProcessPayment,
                            style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.orangePrimary,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                shape:
                                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                elevation: 0),
                            child: const Text('Pay Now',
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildExternalPaymentContent() {
    final bool isCard = selectedPaymentMethod.isCard;
    final String instruction =
        isCard ? 'Process payment on EDC Machine' : 'Scan QR Code on EDC / Customer App';
    final IconData icon = isCard ? Icons.credit_card : Icons.qr_code_scanner;

    return Expanded(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(),
                    // Icon and Instruction
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: const BoxDecoration(
                        color: AppColors.slate100,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(icon, size: 48.sp, color: AppColors.slate500),
                    ),
                    SizedBox(height: 24.w),
                    Text(
                      instruction,
                      textAlign: TextAlign.center,
                      style: TextStyleConst.poppinsMedium16.copyWith(color: AppColors.slate500),
                    ),
                    SizedBox(height: 8.w),
                    Text(
                      'Total Amount to Pay',
                      style: TextStyleConst.poppinsRegular12
                          .copyWith(color: AppColors.slate400, fontSize: 13.sp),
                    ),
                    SizedBox(height: 12.w),
                    // Large Amount Display
                    Text(
                      grandTotal.toCurrencyFormat(),
                      style: TextStyleConst.poppinsBold32
                          .copyWith(fontSize: 40.sp, color: AppColors.slate800),
                    ),

                    SizedBox(height: 48.w),

                    // Reference Number Input
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Reference Number (Optional)',
                          style: TextStyleConst.poppinsMedium14.copyWith(color: AppColors.slate800),
                        ),
                        SizedBox(height: 8.w),
                        TextField(
                          controller: refNoController,
                          decoration: InputDecoration(
                            hintText: 'Enter approval code / ref no.',
                            hintStyle:
                                TextStyleConst.poppinsRegular14.copyWith(color: AppColors.slate400),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.r),
                              borderSide: const BorderSide(color: AppColors.slate200),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.r),
                              borderSide: const BorderSide(color: AppColors.slate200),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.r),
                              borderSide: const BorderSide(color: AppColors.orangePrimary),
                            ),
                            contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.w),
                          ),
                        ),
                      ],
                    ),

                    const Spacer(flex: 2),

                    // Confirm Button
                    SizedBox(
                      width: double.infinity,
                      child: ValueListenableBuilder<bool>(
                        valueListenable: isToastActiveNotifier,
                        builder: (context, isToastActive, child) {
                          return ElevatedButton(
                            onPressed: isToastActive ? null : onProcessPayment,
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    AppColors.greenLight100, // Use green for confirmation
                                foregroundColor: Colors.white,
                                padding: EdgeInsets.symmetric(vertical: 16.w),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.r)),
                                elevation: 0),
                            child: Text('Confirm Payment',
                                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildChangeRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Change',
          style: TextStyleConst.poppinsMedium14.copyWith(
            color: AppColors.slate500,
          ),
        ),
        Text(
          (_inputAmount > grandTotal ? _inputAmount - grandTotal : 0).toCurrencyFormat(),
          style: TextStyleConst.poppinsBold16.copyWith(
            color: AppColors.orangePrimary,
          ),
        ),
      ],
    );
  }
}
