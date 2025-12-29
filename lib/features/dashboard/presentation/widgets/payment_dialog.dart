import 'dart:async';

import 'package:flashlight_pos/config/themes/app_colors.dart';
import 'package:flashlight_pos/core/utils/currency_formatter.dart';
import 'package:flashlight_pos/features/customer/domain/entities/customer.dart';
import 'package:flashlight_pos/features/work_order/domain/entities/work_order.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PaymentDialog extends StatefulWidget {
  final WorkOrder order;
  final Customer? customer;

  const PaymentDialog({
    super.key,
    required this.order,
    this.customer,
  });

  @override
  State<PaymentDialog> createState() => _PaymentDialogState();
}

class _PaymentDialogState extends State<PaymentDialog> {
  int _selectedMethodIndex = 0; // 0: Cash, 1: Card, 2: QR
  String _inputAmountStr = '';
  bool _paymentSuccess = false;
  double _change = 0;
  int _autoCloseTimer = 5;
  Timer? _timer;

  // Tax Mock (e.g. 11%)
  double get _taxAmount => widget.order.totalPrice * 0.11;

  double get _grandTotal => widget.order.totalPrice + _taxAmount;
  double get _inputAmount => double.tryParse(_inputAmountStr) ?? 0;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _onKeypadTap(String value) {
    if (_paymentSuccess) return; // Disable keypad if success

    setState(() {
      if (value == 'DEL') {
        if (_inputAmountStr.isNotEmpty) {
          _inputAmountStr =
              _inputAmountStr.substring(0, _inputAmountStr.length - 1);
        }
      } else if (value == 'CLEAR') {
        // Assuming X icon is clear
        _inputAmountStr = '';
      } else {
        if (_inputAmountStr.length < 12) {
          // Limit length
          _inputAmountStr += value;
        }
      }
    });
  }

  void _setAmount(int amount) {
    if (_paymentSuccess) return;
    setState(() {
      _inputAmountStr = amount.toString();
    });
  }

  void _startAutoCloseTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_autoCloseTimer == 0) {
        timer.cancel();
        Navigator.pop(context);
      } else {
        setState(() {
          _autoCloseTimer--;
        });
      }
    });
  }

  void _processPayment() {
    final inputAmount = double.tryParse(_inputAmountStr) ?? 0;
    if (inputAmount < _grandTotal) {
      // Show error snackbar or alert
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Insufficient amount')),
      );
      return;
    }

    setState(() {
      _change = inputAmount - _grandTotal;
      _paymentSuccess = true;
    });

    _startAutoCloseTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100, maxHeight: 700),
          child: _paymentSuccess ? _buildSuccessView() : _buildPaymentView(),
        ),
      ),
    );
  }

  Widget _buildSuccessView() {
    return Center(
      child: Container(
        width: 400,
        padding: const EdgeInsets.symmetric(vertical: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Success Icon
            Container(
              width: 80,
              height: 80,
              decoration: const BoxDecoration(
                color: AppColors.greenLight100,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check, color: Colors.white, size: 48),
            ),
            const SizedBox(height: 24),
            const Text(
              'Payment Successful!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E293B),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Don\'t forget to say Thank You to customers',
              style: TextStyle(color: Color(0xFF94A3B8), fontSize: 14),
            ),
            const SizedBox(height: 32),
            // Details Card
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFE2E8F0)),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                      border:
                          Border(bottom: BorderSide(color: Color(0xFFF1F5F9))),
                    ),
                    child: const Text(
                      'Detail Payment',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E293B)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        _DetailRow(
                            label: 'Total Payment',
                            value: _grandTotal.toCurrencyFormat(),
                            isBold: true),
                        const SizedBox(height: 12),
                        _DetailRow(
                            label: 'Payment Method',
                            value: _selectedMethodIndex == 0
                                ? 'Cash'
                                : (_selectedMethodIndex == 1
                                    ? 'Card'
                                    : 'QR Code'),
                            valueColor: AppColors.orangePrimary,
                            icon: _selectedMethodIndex == 0
                                ? Icons.money
                                : (_selectedMethodIndex == 1
                                    ? Icons.credit_card
                                    : Icons.qr_code)),
                        const SizedBox(height: 12),
                        _DetailRow(
                            label: 'Customer Pays',
                            value: (double.tryParse(_inputAmountStr) ?? 0)
                                .toCurrencyFormat(),
                            isBold: true),
                      ],
                    ),
                  ),
                  const Divider(height: 1),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Change',
                          style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFF64748B),
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          _change.toCurrencyFormat(),
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1E293B)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            // Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      // TODO: Print functionality
                    },
                    icon: const Icon(Icons.print_outlined, size: 20),
                    label: const Text('Print Bill'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF1E293B),
                      side: const BorderSide(color: Color(0xFFE2E8F0)),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.orangePrimary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      elevation: 0,
                    ),
                    child: const Text('Confirm Payment',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            RichText(
              text: TextSpan(
                text: 'Auto close in ',
                style: const TextStyle(color: AppColors.textGray3),
                children: [
                  TextSpan(
                    text: '$_autoCloseTimer',
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

  Widget _buildPaymentView() {
    return Column(
      children: [
        // Header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E293B),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.wallet, color: Colors.white, size: 20),
              ),
              const SizedBox(width: 12),
              const Text(
                'Payment',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close, size: 20),
                style: IconButton.styleFrom(
                    backgroundColor: const Color(0xFFF1F5F9),
                    padding: EdgeInsets.zero,
                    minimumSize: const Size(36, 36),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8))),
              ),
            ],
          ),
        ),
        const Divider(height: 1),
        Expanded(
          child: Row(
            children: [
              // LEFT PANEL: Order Details
              Expanded(
                flex: 7,
                child: Container(
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Customer Info Header
                      Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.customer?.name ?? 'Guest Customer',
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Order #${widget.order.workOrderCode}',
                                  style: const TextStyle(
                                      color: Color(0xFF64748B), fontSize: 13),
                                ),
                              ],
                            ),
                            Text(
                              DateFormat('EEE, d MMM\nh:mm a')
                                  .format(DateTime.now()),
                              textAlign: TextAlign.right,
                              style: const TextStyle(
                                  color: Color(0xFF64748B), fontSize: 13),
                            ),
                          ],
                        ),
                      ),
                      // Search Member Input
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Row(
                          children: [
                            Expanded(
                              child: SizedBox(
                                height: 48,
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: 'Input Member Code',
                                    hintStyle: const TextStyle(
                                        color: Color(0xFF94A3B8), fontSize: 14),
                                    filled: true,
                                    fillColor: Colors.white,
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 0),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: const BorderSide(
                                          color: Color(0xFFE2E8F0)),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: const BorderSide(
                                          color: Color(0xFFE2E8F0)),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            SizedBox(
                              height: 48,
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.orangePrimary,
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 24),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8))),
                                child: const Text('Search'),
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24),
                        child: Text(
                          'Order Details',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const Divider(height: 32, indent: 24, endIndent: 24),
                      // List
                      Expanded(
                        child: ListView(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          children: [
                            ...widget.order.services
                                .map((s) => _OrderItemListRow(
                                      name: s.service?.name ?? 'Service',
                                      price: s.priceAtOrder,
                                      qty: s.quantity,
                                    )),
                            ...widget.order.products
                                .map((p) => _OrderItemListRow(
                                      name: p.product?.name ?? 'Product',
                                      price: p.priceAtOrder,
                                      qty: p.quantity,
                                    )),
                          ],
                        ),
                      ),
                      // Totals
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: const BoxDecoration(
                          border:
                              Border(top: BorderSide(color: Color(0xFFE2E8F0))),
                        ),
                        child: Column(
                          children: [
                            _SummaryRow(
                                label: 'Sub Total',
                                value: widget.order.totalPrice.toDouble()),
                            const SizedBox(height: 8),
                            _SummaryRow(label: 'Tax 11%', value: _taxAmount),
                            const Divider(height: 32),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Total Payment',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                                Text(
                                  _grandTotal.toCurrencyFormat(),
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            if (_selectedMethodIndex == 0) ...[
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('Change',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF64748B),
                                          fontWeight: FontWeight.w500)),
                                  Text(
                                    (_inputAmount > _grandTotal
                                            ? _inputAmount - _grandTotal
                                            : 0)
                                        .toCurrencyFormat(),
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.orangePrimary),
                                  ),
                                ],
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const VerticalDivider(width: 1),
              // RIGHT PANEL: Payment
              Expanded(
                flex: 5,
                child: Container(
                  color: const Color(0xFFF8FAFC),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
                  child: Column(
                    children: [
                      // Tab Bar
                      Container(
                        height: 44,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFFE2E8F0)),
                        ),
                        child: Row(
                          children: [
                            _PaymentTab(
                                label: 'Cash',
                                icon: Icons.money,
                                isSelected: _selectedMethodIndex == 0,
                                onTap: () =>
                                    setState(() => _selectedMethodIndex = 0)),
                            Container(
                                width: 1,
                                height: 20,
                                color: const Color(0xFFE2E8F0)),
                            _PaymentTab(
                                label: 'Card',
                                icon: Icons.credit_card,
                                isSelected: _selectedMethodIndex == 1,
                                onTap: () =>
                                    setState(() => _selectedMethodIndex = 1)),
                            Container(
                                width: 1,
                                height: 20,
                                color: const Color(0xFFE2E8F0)),
                            _PaymentTab(
                                label: 'QR Code',
                                icon: Icons.qr_code,
                                isSelected: _selectedMethodIndex == 2,
                                onTap: () =>
                                    setState(() => _selectedMethodIndex = 2)),
                          ],
                        ),
                      ),
                      const Spacer(flex: 1),
                      const Text('Input Money',
                          style: TextStyle(
                              color: Color(0xFF64748B),
                              fontWeight: FontWeight.w500)),
                      const SizedBox(height: 4),
                      Text(
                        'Enter cash amount received',
                        style:
                            TextStyle(color: Color(0xFF94A3B8), fontSize: 12),
                      ),
                      const SizedBox(height: 12),
                      // Display Input
                      Text(
                        _inputAmountStr.isEmpty
                            ? 'Rp 0'
                            : 'Rp ${int.tryParse(_inputAmountStr)?.toCurrencyFormat().replaceAll("Rp ", "") ?? _inputAmountStr}',
                        style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1E293B)),
                      ),
                      const SizedBox(height: 24),
                      // Quick Amounts
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _QuickAmountChip(
                              amount: 10000, onTap: () => _setAmount(10000)),
                          const SizedBox(width: 8),
                          _QuickAmountChip(
                              amount: 20000, onTap: () => _setAmount(20000)),
                          const SizedBox(width: 8),
                          _QuickAmountChip(
                              amount: 50000, onTap: () => _setAmount(50000)),
                          const SizedBox(width: 8),
                          _QuickAmountChip(
                              amount: 100000, onTap: () => _setAmount(100000)),
                        ],
                      ),
                      const SizedBox(height: 24),
                      // Keypad
                      Column(
                        children: [
                          Row(children: [
                            _KeypadButton('1',
                                onPressed: () => _onKeypadTap('1')),
                            _KeypadButton('2',
                                onPressed: () => _onKeypadTap('2')),
                            _KeypadButton('3',
                                onPressed: () => _onKeypadTap('3')),
                          ]),
                          Row(children: [
                            _KeypadButton('4',
                                onPressed: () => _onKeypadTap('4')),
                            _KeypadButton('5',
                                onPressed: () => _onKeypadTap('5')),
                            _KeypadButton('6',
                                onPressed: () => _onKeypadTap('6')),
                          ]),
                          Row(children: [
                            _KeypadButton('7',
                                onPressed: () => _onKeypadTap('7')),
                            _KeypadButton('8',
                                onPressed: () => _onKeypadTap('8')),
                            _KeypadButton('9',
                                onPressed: () => _onKeypadTap('9')),
                          ]),
                          Row(children: [
                            const Spacer(), // Empty slot
                            _KeypadButton('0',
                                onPressed: () => _onKeypadTap('0')),
                            // Backspace Button
                            Expanded(
                              child: SizedBox(
                                height: 64,
                                child: Center(
                                  child: IconButton(
                                    onPressed: () => _onKeypadTap('DEL'),
                                    icon: const Icon(Icons.backspace_outlined,
                                        color: Color(0xFF64748B), size: 24),
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
                        child: ElevatedButton(
                          onPressed: _processPayment,
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.orangePrimary,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              elevation: 0),
                          child: const Text('Pay Now',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isBold;
  final Color? valueColor;
  final IconData? icon;

  const _DetailRow(
      {required this.label,
      required this.value,
      this.isBold = false,
      this.valueColor,
      this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(color: Color(0xFF64748B), fontSize: 14),
        ),
        Row(
          children: [
            if (icon != null) ...[
              Icon(icon,
                  size: 16, color: valueColor ?? const Color(0xFF1E293B)),
              const SizedBox(width: 4),
            ],
            Text(
              value,
              style: TextStyle(
                  fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                  color: valueColor ?? const Color(0xFF1E293B),
                  fontSize: 14),
            ),
          ],
        ),
      ],
    );
  }
}

class _OrderItemListRow extends StatelessWidget {
  final String name;
  final int price;
  final int qty;

  const _OrderItemListRow(
      {required this.name, required this.price, required this.qty});

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
              Text(name,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, color: Color(0xFF1E293B))),
              const SizedBox(height: 4),
              Text(price.toCurrencyFormat(),
                  style:
                      const TextStyle(color: Color(0xFF94A3B8), fontSize: 13)),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('x$qty',
                  style:
                      const TextStyle(color: Color(0xFF64748B), fontSize: 13)),
              const SizedBox(height: 4),
              Text((price * qty).toCurrencyFormat(),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
            ],
          )
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final double value;

  const _SummaryRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: Color(0xFF64748B))),
        Text(value.toCurrencyFormat(),
            style: const TextStyle(
                fontWeight: FontWeight.w600, color: Color(0xFF1E293B))),
      ],
    );
  }
}

class _PaymentTab extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _PaymentTab(
      {required this.label,
      required this.icon,
      required this.isSelected,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected
                ? Colors.white
                : Colors.transparent, // Or a highlight logic
            // For now simple switch
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon,
                  size: 18,
                  color: isSelected ? Colors.black : const Color(0xFF94A3B8)),
              const SizedBox(width: 8),
              Text(label,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: isSelected
                          ? AppColors.black
                          : const Color(0xFF94A3B8))),
            ],
          ),
        ),
      ),
    );
  }
}

class _QuickAmountChip extends StatelessWidget {
  final int amount;
  final VoidCallback onTap;

  const _QuickAmountChip({required this.amount, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: 12, vertical: 8), // Reduced padding
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: Text(
            amount.toCurrencyFormat().replaceAll(",00", ""), // Basic formatting
            style: const TextStyle(
                fontSize: 13, // Explicit smaller size
                fontWeight: FontWeight.bold,
                color: Color(0xFF64748B))),
      ),
    );
  }
}

class _KeypadButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const _KeypadButton(this.label, {required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: 64, // Fixed height for keypad buttons
        child: TextButton(
            onPressed: onPressed,
            child: Text(
              label,
              style: const TextStyle(
                  fontSize: 24, // Smaller font
                  fontWeight: FontWeight.bold,
                  color: AppColors.black),
            )),
      ),
    );
  }
}
