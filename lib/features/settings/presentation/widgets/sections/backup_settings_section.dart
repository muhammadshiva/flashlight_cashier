import 'package:flashlight_pos/config/themes/app_colors.dart';
import 'package:flashlight_pos/features/settings/domain/entities/backup_settings.dart';
import 'package:flashlight_pos/features/settings/presentation/cubit/backup_settings/backup_settings_cubit.dart';
import 'package:flashlight_pos/shared/models/ui_state_model.dart';
import 'package:flashlight_pos/shared/widgets/toggle_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BackupSettingsSection extends StatefulWidget {
  const BackupSettingsSection({super.key});

  @override
  State<BackupSettingsSection> createState() => _BackupSettingsSectionState();
}

class _BackupSettingsSectionState extends State<BackupSettingsSection>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Konstanta untuk string yang digunakan berulang kali
  static const String _retryButtonText = 'Retry';
  static const String _errorPrefix = 'Error: ';

  // Konstanta untuk spacing
  static final double _defaultSpacing = 16.0.w;
  static final double _largeSpacing = 24.0.w;
  static final double _iconSize = 48.0.sp;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BackupSettingsCubit, BackupSettingsState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTabBar(),
            SizedBox(height: _defaultSpacing),
            SizedBox(
              height: 500.h, // Fixed height for TabBarView
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildBackupTab(context, state),
                  _buildRestoreTab(context, state),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTabBar() {
    return TabBar(
      controller: _tabController,
      labelColor: AppColors.orangePrimary,
      unselectedLabelColor: AppColors.textGray2,
      indicatorColor: AppColors.orangePrimary,
      tabs: const [
        Tab(
          icon: Icon(Icons.cloud_upload_outlined),
          text: 'Backup',
        ),
        Tab(
          icon: Icon(Icons.cloud_download_outlined),
          text: 'Restore',
        ),
      ],
    );
  }

  Widget _buildBackupTab(BuildContext context, BackupSettingsState state) {
    return state.data.when(
      loading: () => _buildLoadingWidget(),
      error: (message) => _buildErrorWidget(context, message),
      empty: (message) => _buildEmptyWidget(context, message),
      idle: () => const SizedBox.shrink(),
      success: (backupSettings) => _buildBackupContent(context, backupSettings, state),
    );
  }

  Widget _buildRestoreTab(BuildContext context, BackupSettingsState state) {
    return _buildRestoreContent(context, state);
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
            Icons.backup_outlined,
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

  Widget _buildBackupContent(
    BuildContext context,
    BackupSettings backupSettings,
    BackupSettingsState state,
  ) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: _defaultSpacing),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAutoBackupSection(context, backupSettings, state),
          SizedBox(height: _largeSpacing),
          _buildBackupOptionsSection(context, backupSettings, state),
          SizedBox(height: _largeSpacing),
          _buildManualBackupSection(context, state),
          SizedBox(height: _largeSpacing),
          if (state.backupSuccess) _buildSuccessMessage('Backup berhasil dibuat!'),
          if (state.backupError != null) _buildErrorMessage(state.backupError!),
        ],
      ),
    );
  }

  Widget _buildAutoBackupSection(
    BuildContext context,
    BackupSettings backupSettings,
    BackupSettingsState state,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Auto Backup',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.blackFoundation600,
              ),
        ),
        SizedBox(height: _defaultSpacing),
        ToggleItem(
          label: 'Aktifkan Auto Backup',
          description: 'Backup otomatis data aplikasi secara berkala',
          value: backupSettings.autoBackupEnabled,
          onChanged: (value) => _toggleAutoBackup(context, value),
          isLoading: state.isUpdatingAutoBackup,
        ),
        if (backupSettings.autoBackupEnabled) ...[
          SizedBox(height: _defaultSpacing),
          _buildAutoBackupInterval(context, backupSettings, state),
        ],
      ],
    );
  }

  Widget _buildAutoBackupInterval(
    BuildContext context,
    BackupSettings backupSettings,
    BackupSettingsState state,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Interval Auto Backup',
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
                  value: backupSettings.autoBackupIntervalDays,
                  isExpanded: true,
                  underline: const SizedBox.shrink(),
                  items: [1, 3, 7, 14, 30].map((days) {
                    return DropdownMenuItem<int>(
                      value: days,
                      child: Text('$days hari'),
                    );
                  }).toList(),
                  onChanged: state.isUpdatingAutoBackupInterval
                      ? null
                      : (value) {
                          if (value != null) {
                            _updateAutoBackupInterval(context, value);
                          }
                        },
                ),
              ),
              if (state.isUpdatingAutoBackupInterval)
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

  Widget _buildBackupOptionsSection(
    BuildContext context,
    BackupSettings backupSettings,
    BackupSettingsState state,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Data yang akan di-backup',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.blackFoundation600,
              ),
        ),
        SizedBox(height: _defaultSpacing),
        ToggleItem(
          label: 'Data Transaksi',
          description: 'Semua data transaksi penjualan',
          value: backupSettings.includeTransactionData,
          onChanged: (value) => _toggleIncludeTransactionData(context, value),
          isLoading: state.isUpdatingBackupOptions,
        ),
        SizedBox(height: _defaultSpacing),
        ToggleItem(
          label: 'Data Pelanggan',
          description: 'Informasi pelanggan dan riwayat pembelian',
          value: backupSettings.includeCustomerData,
          onChanged: (value) => _toggleIncludeCustomerData(context, value),
          isLoading: state.isUpdatingBackupOptions,
        ),
        SizedBox(height: _defaultSpacing),
        ToggleItem(
          label: 'Data Produk',
          description: 'Katalog produk dan harga',
          value: backupSettings.includeProductData,
          onChanged: (value) => _toggleIncludeProductData(context, value),
          isLoading: state.isUpdatingBackupOptions,
        ),
        SizedBox(height: _defaultSpacing),
        ToggleItem(
          label: 'Pengaturan',
          description: 'Konfigurasi aplikasi dan preferensi',
          value: backupSettings.includeSettingsData,
          onChanged: (value) => _toggleIncludeSettingsData(context, value),
          isLoading: state.isUpdatingBackupOptions,
        ),
      ],
    );
  }

  Widget _buildManualBackupSection(BuildContext context, BackupSettingsState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Backup Manual',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.blackFoundation600,
              ),
        ),
        SizedBox(height: _defaultSpacing),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: state.isCreatingBackup ? null : () => _createManualBackup(context),
            icon: state.isCreatingBackup
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : const Icon(Icons.cloud_upload),
            label: Text(state.isCreatingBackup ? 'Membuat backup...' : 'Buat Backup Sekarang'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.orangePrimary,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 12.h),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRestoreContent(BuildContext context, BackupSettingsState state) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: _defaultSpacing),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Restore dari Backup',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.blackFoundation600,
                ),
          ),
          SizedBox(height: _defaultSpacing),
          Text(
            'Pilih file backup untuk mengembalikan data aplikasi. Proses ini akan menimpa data yang ada saat ini.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textGray2,
                ),
          ),
          SizedBox(height: _largeSpacing),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: state.isRestoringBackup ? null : () => _restoreFromBackup(context),
              icon: state.isRestoringBackup
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Icon(Icons.cloud_download),
              label: Text(state.isRestoringBackup ? 'Mengembalikan data...' : 'Pilih File Backup'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.orangePrimary,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 12.h),
              ),
            ),
          ),
          SizedBox(height: _largeSpacing),
          if (state.restoreSuccess) _buildSuccessMessage('Data berhasil dikembalikan!'),
          if (state.restoreError != null) _buildErrorMessage(state.restoreError!),
        ],
      ),
    );
  }

  Widget _buildSuccessMessage(String message) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColors.success50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.success3),
      ),
      child: Row(
        children: [
          Icon(Icons.check_circle, color: AppColors.success600, size: 20.sp),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                color: AppColors.success600,
                fontSize: 13.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorMessage(String message) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColors.error50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.error1),
      ),
      child: Row(
        children: [
          Icon(Icons.error, color: AppColors.error600, size: 20.sp),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                color: AppColors.error600,
                fontSize: 13.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _retryLoadSettings(BuildContext context) {
    context.read<BackupSettingsCubit>().loadBackupSettings();
  }

  void _toggleAutoBackup(BuildContext context, bool value) {
    context.read<BackupSettingsCubit>().toggleAutoBackup(value);
  }

  void _updateAutoBackupInterval(BuildContext context, int value) {
    context.read<BackupSettingsCubit>().updateAutoBackupInterval(value);
  }

  void _toggleIncludeTransactionData(BuildContext context, bool value) {
    context.read<BackupSettingsCubit>().toggleIncludeTransactionData(value);
  }

  void _toggleIncludeCustomerData(BuildContext context, bool value) {
    context.read<BackupSettingsCubit>().toggleIncludeCustomerData(value);
  }

  void _toggleIncludeProductData(BuildContext context, bool value) {
    context.read<BackupSettingsCubit>().toggleIncludeProductData(value);
  }

  void _toggleIncludeSettingsData(BuildContext context, bool value) {
    context.read<BackupSettingsCubit>().toggleIncludeSettingsData(value);
  }

  void _createManualBackup(BuildContext context) async {
    try {
      // For now, use a default path. In real implementation, you would use file picker
      String backupPath =
          '/storage/emulated/0/Download/backup_${DateTime.now().millisecondsSinceEpoch}.zip';
      context.read<BackupSettingsCubit>().createManualBackup(backupPath);
    } catch (e) {
      // Handle error
    }
  }

  void _restoreFromBackup(BuildContext context) async {
    try {
      // For now, use a default path. In real implementation, you would use file picker
      String backupPath = '/storage/emulated/0/Download/backup_example.zip';
      context.read<BackupSettingsCubit>().restoreFromBackup(backupPath);
    } catch (e) {
      // Handle error
    }
  }
}
