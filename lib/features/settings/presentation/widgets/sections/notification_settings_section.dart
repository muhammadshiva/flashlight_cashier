import 'package:flashlight_pos/features/settings/presentation/cubit/notification_settings/notification_settings_cubit.dart';
import 'package:flashlight_pos/shared/models/ui_state_model.dart';
import 'package:flashlight_pos/shared/widgets/toggle_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationSettingsSection extends StatelessWidget {
  const NotificationSettingsSection({super.key});

  // Konstanta untuk string yang digunakan berulang kali
  static const String _sectionTitle = 'Pengaturan Notifikasi';
  static const String _retryButtonText = 'Retry';
  static const String _errorPrefix = 'Error: ';

  // Konstanta untuk spacing
  static final double _defaultSpacing = 16.0.w;
  static final double _largeSpacing = 24.0.w;
  static final double _iconSize = 48.0.sp;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationSettingsCubit, NotificationSettingsState>(
      builder: (context, state) {
        return state.data.when(
          loading: () => _buildLoadingWidget(),
          error: (message) => _buildErrorWidget(context, message),
          empty: (message) => _buildEmptyWidget(context, message),
          idle: () => const SizedBox.shrink(),
          success: (notificationSettings) =>
              _buildSuccessWidget(context, notificationSettings, state),
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
            Icons.notifications_off_outlined,
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
    dynamic notificationSettings,
    NotificationSettingsState state,
  ) {
    return Padding(
      padding: EdgeInsets.all(_defaultSpacing),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle(context),
          SizedBox(height: _largeSpacing),
          _buildNotificationToggles(context, notificationSettings, state),
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

  Widget _buildNotificationToggles(
    BuildContext context,
    dynamic notificationSettings,
    NotificationSettingsState state,
  ) {
    return Column(
      children: [
        _buildMainNotificationToggle(context, notificationSettings, state),
        _buildSpacing(),
        _buildSoundAlertsToggle(context, notificationSettings, state),
        _buildSpacing(),
        _buildLowStockToggle(context, notificationSettings, state),
        _buildSpacing(),
        _buildNewOrderToggle(context, notificationSettings, state),
        _buildSpacing(),
        _buildPaymentReceivedToggle(context, notificationSettings, state),
        SizedBox(height: _largeSpacing),
      ],
    );
  }

  Widget _buildMainNotificationToggle(
    BuildContext context,
    dynamic notificationSettings,
    NotificationSettingsState state,
  ) {
    return ToggleItem(
      label: 'Aktifkan Notifikasi',
      description: 'Menerima notifikasi dari aplikasi',
      value: notificationSettings.enableNotifications,
      onChanged: (value) => _toggleNotifications(context, value),
      isLoading: state.isUpdatingNotifications,
    );
  }

  Widget _buildSoundAlertsToggle(
    BuildContext context,
    dynamic notificationSettings,
    NotificationSettingsState state,
  ) {
    return ToggleItem(
      label: 'Alert Suara',
      description: 'Memainkan suara saat notifikasi masuk',
      value: notificationSettings.enableSoundAlerts,
      onChanged: (value) => _toggleSoundAlerts(context, value),
      isLoading: state.isUpdatingSoundAlerts,
    );
  }

  Widget _buildLowStockToggle(
    BuildContext context,
    dynamic notificationSettings,
    NotificationSettingsState state,
  ) {
    return ToggleItem(
      label: 'Notifikasi Stok Menipis',
      description: 'Dapatkan pemberitahuan saat stok produk menipis',
      value: notificationSettings.notifyOnLowStock,
      onChanged: (value) => _toggleLowStockNotifications(context, value),
      isLoading: state.isUpdatingLowStock,
    );
  }

  Widget _buildNewOrderToggle(
    BuildContext context,
    dynamic notificationSettings,
    NotificationSettingsState state,
  ) {
    return ToggleItem(
      label: 'Notifikasi Pesanan Baru',
      description: 'Dapatkan pemberitahuan saat ada pesanan baru',
      value: notificationSettings.notifyOnNewOrder,
      onChanged: (value) => _toggleNewOrderNotifications(context, value),
      isLoading: state.isUpdatingNewOrder,
    );
  }

  Widget _buildPaymentReceivedToggle(
    BuildContext context,
    dynamic notificationSettings,
    NotificationSettingsState state,
  ) {
    return ToggleItem(
      label: 'Notifikasi Pembayaran Diterima',
      description: 'Dapatkan pemberitahuan saat pembayaran diterima',
      value: notificationSettings.notifyOnPaymentReceived,
      onChanged: (value) => _togglePaymentReceivedNotifications(context, value),
      isLoading: state.isUpdatingPaymentReceived,
    );
  }

  Widget _buildSpacing() {
    return SizedBox(height: _defaultSpacing);
  }

  void _retryLoadSettings(BuildContext context) {
    context.read<NotificationSettingsCubit>().loadNotificationSettings();
  }

  void _toggleNotifications(BuildContext context, bool value) {
    context.read<NotificationSettingsCubit>().toggleNotifications(value);
  }

  void _toggleSoundAlerts(BuildContext context, bool value) {
    context.read<NotificationSettingsCubit>().toggleSoundAlerts(value);
  }

  void _toggleLowStockNotifications(BuildContext context, bool value) {
    context.read<NotificationSettingsCubit>().toggleLowStockNotifications(value);
  }

  void _toggleNewOrderNotifications(BuildContext context, bool value) {
    context.read<NotificationSettingsCubit>().toggleNewOrderNotifications(value);
  }

  void _togglePaymentReceivedNotifications(BuildContext context, bool value) {
    context.read<NotificationSettingsCubit>().togglePaymentReceivedNotifications(value);
  }
}
