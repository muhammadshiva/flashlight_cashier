import 'package:flashlight_pos/config/themes/app_colors.dart';
import 'package:flashlight_pos/features/settings/presentation/cubit/pos_settings/pos_settings_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// POS Settings Section
///
/// Displays POS configuration settings for the cashier application
/// Features:
/// - Tax rate configuration with validation
/// - Auto-calculate tax toggle
/// - Real-time form validation
/// - Save/Discard changes functionality
/// - Clean, modern card-based design
class POSSettingsSection extends StatefulWidget {
  const POSSettingsSection({super.key});

  @override
  State<POSSettingsSection> createState() => _POSSettingsSectionState();
}

class _POSSettingsSectionState extends State<POSSettingsSection> {
  final _taxRateController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // Initialize controller with current value
    final state = context.read<POSSettingsCubit>().state;
    _taxRateController.text = state.taxRate.toString();
  }

  @override
  void dispose() {
    _taxRateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<POSSettingsCubit, POSSettingsState>(
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with icon
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.orangePrimary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.point_of_sale,
                      size: 24,
                      color: AppColors.orangePrimary,
                    ),
                  ),
                  16.horizontalSpace,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'POS Settings',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: AppColors.blackFoundation600,
                          ),
                        ),
                        4.verticalSpace,
                        const Text(
                          'Configure point of sale and cashier settings',
                          style: TextStyle(
                            fontSize: 13,
                            color: AppColors.greyFoundation300,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              24.verticalSpace,

              // Tax Configuration Card
              _buildSettingsCard(
                title: 'Tax Configuration',
                icon: Icons.calculate,
                children: [
                  // Tax Rate Input
                  _buildLabelText('Tax Rate (%)'),
                  8.verticalSpace,
                  _buildTaxRateInput(state),
                  16.verticalSpace,

                  // Auto Calculate Tax Toggle
                  _buildAutoCalculateTaxToggle(state),
                ],
              ),

              16.verticalSpace,

              // Receipt & Print Settings Card
              _buildSettingsCard(
                title: 'Receipt & Print Settings',
                icon: Icons.receipt_long,
                children: [
                  // Auto Print Receipt Toggle
                  _buildAutoPrintReceiptToggle(state),
                ],
              ),

              16.verticalSpace,

              // Cashier Settings Card
              _buildSettingsCard(
                title: 'Cashier Settings',
                icon: Icons.settings,
                children: [
                  _buildCurrencyCodeDropdown(state),
                  16.verticalSpace,
                  _buildDecimalPlacesDropdown(state),
                ],
              ),

              24.verticalSpace,

              // Action Buttons
              if (state.isDirty) _buildActionButtons(state),

              24.verticalSpace,
            ],
          ),
        );
      },
    );
  }

  Widget _buildSettingsCard({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderGray),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: 18,
                color: AppColors.orangePrimary,
              ),
              8.horizontalSpace,
              Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: AppColors.blackFoundation600,
                ),
              ),
            ],
          ),
          16.verticalSpace,
          ...children,
        ],
      ),
    );
  }

  Widget _buildLabelText(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: AppColors.blackFoundation600,
      ),
    );
  }

  Widget _buildTaxRateInput(POSSettingsState state) {
    return TextFormField(
      controller: _taxRateController,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
      ],
      decoration: InputDecoration(
        hintText: 'Enter tax rate (e.g., 11.0)',
        suffixText: '%',
        suffixStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: AppColors.greyFoundation300,
        ),
        prefixIcon: const Icon(
          Icons.percent,
          size: 20,
          color: AppColors.greyFoundation300,
        ),
        filled: true,
        fillColor: AppColors.greyFoundation50,
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
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.error600),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Tax rate is required';
        }
        final rate = double.tryParse(value);
        if (rate == null) {
          return 'Please enter a valid number';
        }
        if (rate < 0 || rate > 100) {
          return 'Tax rate must be between 0 and 100';
        }
        return null;
      },
      onChanged: (value) {
        final rate = double.tryParse(value);
        if (rate != null && rate >= 0 && rate <= 100) {
          context.read<POSSettingsCubit>().updateTaxRate(rate);
        }
      },
    );
  }

  Widget _buildAutoCalculateTaxToggle(POSSettingsState state) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.greyFoundation50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.borderGray),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: state.autoCalculateTax
                  ? AppColors.orangePrimary.withValues(alpha: 0.1)
                  : AppColors.greyFoundation50,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.auto_awesome,
              size: 20,
              color: state.autoCalculateTax ? AppColors.orangePrimary : AppColors.greyFoundation300,
            ),
          ),
          12.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Auto Calculate Tax',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.blackFoundation600,
                  ),
                ),
                4.verticalSpace,
                const Text(
                  'Automatically add tax to transactions',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.greyFoundation300,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: state.autoCalculateTax,
            onChanged: (value) {
              context.read<POSSettingsCubit>().toggleAutoCalculateTax(value);
            },
            activeTrackColor: AppColors.orangePrimary,
          ),
        ],
      ),
    );
  }

  Widget _buildAutoPrintReceiptToggle(POSSettingsState state) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.greyFoundation50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.borderGray),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: state.autoPrintReceipt
                  ? AppColors.orangePrimary.withValues(alpha: 0.1)
                  : AppColors.greyFoundation50,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.print,
              size: 20,
              color: state.autoPrintReceipt ? AppColors.orangePrimary : AppColors.greyFoundation300,
            ),
          ),
          12.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Auto Print Receipt',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.blackFoundation600,
                  ),
                ),
                4.verticalSpace,
                const Text(
                  'Automatically print receipt after transaction',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.greyFoundation300,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: state.autoPrintReceipt,
            onChanged: (value) {
              context.read<POSSettingsCubit>().toggleAutoPrintReceipt(value);
            },
            activeTrackColor: AppColors.orangePrimary,
          ),
        ],
      ),
    );
  }

  Widget _buildCurrencyCodeDropdown(POSSettingsState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabelText('Currency'),
        8.verticalSpace,
        DropdownButtonFormField<String>(
          initialValue: state.currencyCode,
          decoration: InputDecoration(
            prefixIcon: const Icon(
              Icons.attach_money,
              size: 20,
              color: AppColors.greyFoundation300,
            ),
            filled: true,
            fillColor: AppColors.greyFoundation50,
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
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
          items: const [
            DropdownMenuItem(value: 'IDR', child: Text('IDR (Indonesian Rupiah)')),
            DropdownMenuItem(value: 'USD', child: Text('USD (US Dollar)')),
            DropdownMenuItem(value: 'EUR', child: Text('EUR (Euro)')),
            DropdownMenuItem(value: 'SGD', child: Text('SGD (Singapore Dollar)')),
            DropdownMenuItem(value: 'MYR', child: Text('MYR (Malaysian Ringgit)')),
          ],
          onChanged: (value) {
            if (value != null) {
              context.read<POSSettingsCubit>().updateCurrencyCode(value);
            }
          },
        ),
      ],
    );
  }

  Widget _buildDecimalPlacesDropdown(POSSettingsState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabelText('Decimal Places'),
        8.verticalSpace,
        DropdownButtonFormField<int>(
          initialValue: state.decimalPlaces,
          decoration: InputDecoration(
            prefixIcon: const Icon(
              Icons.filter_9_plus,
              size: 20,
              color: AppColors.greyFoundation300,
            ),
            filled: true,
            fillColor: AppColors.greyFoundation50,
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
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
          items: const [
            DropdownMenuItem(value: 0, child: Text('0 digits (e.g., 1234)')),
            DropdownMenuItem(value: 1, child: Text('1 digit (e.g., 1234.5)')),
            DropdownMenuItem(value: 2, child: Text('2 digits (e.g., 1234.56)')),
            DropdownMenuItem(value: 3, child: Text('3 digits (e.g., 1234.567)')),
          ],
          onChanged: (value) {
            if (value != null) {
              context.read<POSSettingsCubit>().updateDecimalPlaces(value);
            }
          },
        ),
      ],
    );
  }

  Widget _buildActionButtons(POSSettingsState state) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.warning50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.warning1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.info_outline,
                size: 20,
                color: AppColors.warning600,
              ),
              8.horizontalSpace,
              const Expanded(
                child: Text(
                  'You have unsaved changes',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.warning600,
                  ),
                ),
              ),
            ],
          ),
          16.verticalSpace,
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: state.isSaving
                      ? null
                      : () {
                          context.read<POSSettingsCubit>().discardChanges();
                          _taxRateController.text = state.taxRate.toString();
                        },
                  icon: const Icon(Icons.close, size: 18),
                  label: const Text('Discard'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.greyFoundation400,
                    side: const BorderSide(color: AppColors.borderGray),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              12.horizontalSpace,
              Expanded(
                flex: 2,
                child: ElevatedButton.icon(
                  onPressed: state.isSaving
                      ? null
                      : () async {
                          if (_formKey.currentState?.validate() ?? false) {
                            await context.read<POSSettingsCubit>().saveSettings();
                            if (mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Row(
                                    children: [
                                      const Icon(Icons.check_circle,
                                          color: AppColors.white, size: 20),
                                      12.horizontalSpace,
                                      const Text('POS settings saved successfully'),
                                    ],
                                  ),
                                  backgroundColor: AppColors.success600,
                                  behavior: SnackBarBehavior.floating,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  duration: const Duration(seconds: 2),
                                ),
                              );
                            }
                          }
                        },
                  icon: state.isSaving
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: AppColors.white,
                          ),
                        )
                      : const Icon(Icons.save, size: 18),
                  label: Text(state.isSaving ? 'Saving...' : 'Save Changes'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.orangePrimary,
                    foregroundColor: AppColors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 0,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
