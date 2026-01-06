import 'package:flashlight_pos/features/settings/domain/entities/security_settings.dart';
import 'package:flashlight_pos/features/settings/presentation/cubit/security_settings/security_settings_cubit.dart';
import 'package:flashlight_pos/shared/models/ui_state_model.dart';
import 'package:flashlight_pos/shared/widgets/toggle_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SecuritySettingsSection extends StatelessWidget {
  const SecuritySettingsSection({super.key});

  // Konstanta untuk string yang digunakan berulang kali
  static const String _sectionTitle = 'Pengaturan Keamanan';
  static const String _retryButtonText = 'Retry';
  static const String _errorPrefix = 'Error: ';

  // Konstanta untuk spacing
  static final double _defaultSpacing = 16.0.w;
  static final double _largeSpacing = 24.0.w;
  static final double _iconSize = 48.0.sp;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SecuritySettingsCubit, SecuritySettingsState>(
      builder: (context, state) {
        return state.data.when(
          loading: () => _buildLoadingWidget(),
          error: (message) => _buildErrorWidget(context, message),
          empty: (message) => _buildEmptyWidget(context, message),
          idle: () => const SizedBox.shrink(),
          success: (securitySettings) => _buildSuccessWidget(context, securitySettings, state),
        );
      },
    );
  }

  Widget _buildLoadingWidget() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildErrorWidget(BuildContext context, String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: _iconSize,
            color: Theme.of(context).colorScheme.error,
          ),
          SizedBox(height: _defaultSpacing),
          Text(
            '$_errorPrefix$message',
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: _defaultSpacing),
          ElevatedButton(
            onPressed: () => _retryLoadSettings(context),
            child: const Text(_retryButtonText),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyWidget(BuildContext context, String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.security_outlined,
            size: _iconSize,
            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
          ),
          SizedBox(height: _defaultSpacing),
          Text(
            message,
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessWidget(
    BuildContext context,
    SecuritySettings securitySettings,
    SecuritySettingsState state,
  ) {
    return Padding(
      padding: EdgeInsets.all(_defaultSpacing),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle(context),
          SizedBox(height: _largeSpacing),
          _buildSecurityToggles(context, securitySettings, state),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context) {
    return Text(
      _sectionTitle,
      style: Theme.of(context).textTheme.headlineSmall,
    );
  }

  Widget _buildSecurityToggles(
    BuildContext context,
    SecuritySettings securitySettings,
    SecuritySettingsState state,
  ) {
    return Column(
      children: [
        _buildPinForRefundToggle(context, securitySettings, state),
        _buildSpacing(),
        _buildPinForDiscountToggle(context, securitySettings, state),
        _buildSpacing(),
        _buildPinForVoidToggle(context, securitySettings, state),
        _buildSpacing(),
        _buildAutoLockToggle(context, securitySettings, state),
        _buildSpacing(),
        _buildAutoLockDuration(context, securitySettings, state),
        SizedBox(height: _largeSpacing),
      ],
    );
  }

  Widget _buildPinForRefundToggle(
    BuildContext context,
    SecuritySettings securitySettings,
    SecuritySettingsState state,
  ) {
    return ToggleItem(
      label: 'PIN untuk Refund',
      description: 'Memerlukan PIN untuk melakukan refund/pengembalian dana',
      value: securitySettings.requirePinForRefund,
      onChanged: (value) => _togglePinForRefund(context, value),
      isLoading: state.isUpdatingPinForRefund,
    );
  }

  Widget _buildPinForDiscountToggle(
    BuildContext context,
    SecuritySettings securitySettings,
    SecuritySettingsState state,
  ) {
    return ToggleItem(
      label: 'PIN untuk Diskon',
      description: 'Memerlukan PIN untuk memberikan diskon',
      value: securitySettings.requirePinForDiscount,
      onChanged: (value) => _togglePinForDiscount(context, value),
      isLoading: state.isUpdatingPinForDiscount,
    );
  }

  Widget _buildPinForVoidToggle(
    BuildContext context,
    SecuritySettings securitySettings,
    SecuritySettingsState state,
  ) {
    return ToggleItem(
      label: 'PIN untuk Void',
      description: 'Memerlukan PIN untuk membatalkan transaksi',
      value: securitySettings.requirePinForVoid,
      onChanged: (value) => _togglePinForVoid(context, value),
      isLoading: state.isUpdatingPinForVoid,
    );
  }

  Widget _buildAutoLockToggle(
    BuildContext context,
    SecuritySettings securitySettings,
    SecuritySettingsState state,
  ) {
    return ToggleItem(
      label: 'Auto Lock',
      description: 'Mengunci aplikasi secara otomatis setelah tidak ada aktivitas',
      value: securitySettings.autoLockAfterInactivity,
      onChanged: (value) => _toggleAutoLock(context, value),
      isLoading: state.isUpdatingAutoLock,
    );
  }

  Widget _buildAutoLockDuration(
    BuildContext context,
    SecuritySettings securitySettings,
    SecuritySettingsState state,
  ) {
    if (!securitySettings.autoLockAfterInactivity) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Durasi Auto Lock',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        SizedBox(height: 8.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Expanded(
                child: DropdownButton<int>(
                  value: securitySettings.autoLockDurationMinutes,
                  isExpanded: true,
                  underline: const SizedBox.shrink(),
                  items: [5, 10, 15, 30, 60].map((duration) {
                    return DropdownMenuItem<int>(
                      value: duration,
                      child: Text('$duration menit'),
                    );
                  }).toList(),
                  onChanged: state.isUpdatingAutoLockDuration
                      ? null
                      : (value) {
                          if (value != null) {
                            _updateAutoLockDuration(context, value);
                          }
                        },
                ),
              ),
              if (state.isUpdatingAutoLockDuration)
                Padding(
                  padding: EdgeInsets.only(left: 12.w),
                  child: const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSpacing() {
    return SizedBox(height: _defaultSpacing);
  }

  void _retryLoadSettings(BuildContext context) {
    context.read<SecuritySettingsCubit>().loadSecuritySettings();
  }

  void _togglePinForRefund(BuildContext context, bool value) {
    context.read<SecuritySettingsCubit>().togglePinForRefund(value);
  }

  void _togglePinForDiscount(BuildContext context, bool value) {
    context.read<SecuritySettingsCubit>().togglePinForDiscount(value);
  }

  void _togglePinForVoid(BuildContext context, bool value) {
    context.read<SecuritySettingsCubit>().togglePinForVoid(value);
  }

  void _toggleAutoLock(BuildContext context, bool value) {
    context.read<SecuritySettingsCubit>().toggleAutoLock(value);
  }

  void _updateAutoLockDuration(BuildContext context, int value) {
    context.read<SecuritySettingsCubit>().updateAutoLockDuration(value);
  }
}
