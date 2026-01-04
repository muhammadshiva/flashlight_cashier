import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:flashlight_pos/config/themes/app_colors.dart';
import 'package:flashlight_pos/features/settings/presentation/cubit/printer_settings_cubit.dart';
import 'package:flashlight_pos/shared/models/ui_state_model.dart';
import 'package:flashlight_pos/shared/widgets/toggle_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission_handler/permission_handler.dart';

/// Printer Settings Section with Cubit pattern
///
/// This widget displays printer configuration UI and uses PrinterSettingsCubit
/// for state management with UIStateModel
class PrinterSettingsSection extends StatelessWidget {
  const PrinterSettingsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PrinterSettingsCubit, PrinterSettingsState>(
      builder: (context, state) {
        return state.data.when(
          success: (printerSettings) => _buildContent(context, state, printerSettings),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (message) => _buildError(message),
          empty: (message) => Center(child: Text(message)),
          idle: () => const SizedBox.shrink(),
        );
      },
    );
  }

  Widget _buildContent(
    BuildContext context,
    PrinterSettingsState state,
    printerSettings,
  ) {
    final isMobilePlatform = Platform.isAndroid || Platform.isIOS;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Platform Warning for non-mobile platforms
        if (!isMobilePlatform) ...[
          const PlatformWarningWidget(),
          24.verticalSpace,
        ],

        // Bluetooth Toggle
        BluetoothToggleWidget(
          bluetoothEnabled: printerSettings.bluetoothEnabled,
          isTogglingBluetooth: state.isTogglingBluetooth,
          onToggle: (value) => _requestBluetoothPermissions(context, value),
        ),

        24.verticalSpace,

        // Printer Connection Section
        const SectionTitleWidget(title: 'Bluetooth Printer'),
        16.verticalSpace,

        // Connected Printer Display
        ConnectedPrinterWidget(
          connectedPrinterName: printerSettings.connectedPrinterName,
          onDisconnect: () => context.read<PrinterSettingsCubit>().disconnectFromPrinter(),
        ),

        16.verticalSpace,

        // Search Printer Button
        SearchPrinterButtonWidget(
          bluetoothEnabled: printerSettings.bluetoothEnabled,
          isScanningPrinters: state.isScanningPrinters,
          isMobilePlatform: isMobilePlatform,
          onSearch: () => context.read<PrinterSettingsCubit>().scanForPrinters(),
        ),

        // Available Printers List
        if (state.availablePrinters.isNotEmpty) ...[
          16.verticalSpace,
          AvailablePrintersWidget(
            availablePrinters: state.availablePrinters,
            connectedPrinterMac: printerSettings.connectedPrinterMac,
            isConnectingPrinter: state.isConnectingPrinter,
            onConnectToPrinter: (printer) =>
                context.read<PrinterSettingsCubit>().connectToPrinter(printer),
          ),
        ],

        32.verticalSpace,

        // Printer Configuration
        const SectionTitleWidget(title: 'Printer Configuration'),
        16.verticalSpace,

        // Paper Size Selection
        PaperSizeDropdownWidget(
          paperSize: printerSettings.paperSize,
          onChanged: (value) {
            if (value != null) {
              context.read<PrinterSettingsCubit>().updateSettings(
                    printerSettings.copyWith(paperSize: value),
                  );
            }
          },
        ),

        24.verticalSpace,

        // Print Options
        PrintOptionsWidget(
          autoPrintReceipt: printerSettings.autoPrintReceipt,
          onAutoPrintChanged: (value) {
            context.read<PrinterSettingsCubit>().updateSettings(
                  printerSettings.copyWith(autoPrintReceipt: value),
                );
          },
        ),

        24.verticalSpace,
      ],
    );
  }

  Widget _buildError(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline,
            color: AppColors.error600,
            size: 48,
          ),
          16.verticalSpace,
          const Text(
            'Error loading printer settings',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.blackFoundation600,
            ),
          ),
          8.verticalSpace,
          Text(
            message,
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.textGray2,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  /// Request Bluetooth permissions on Android
  Future<void> _requestBluetoothPermissions(BuildContext context, bool enable) async {
    if (!Platform.isAndroid && !Platform.isIOS) {
      return;
    }

    if (Platform.isAndroid) {
      final statuses = await [
        Permission.bluetooth,
        Permission.bluetoothScan,
        Permission.bluetoothConnect,
      ].request();

      final allGranted = statuses.values.every((status) => status.isGranted);
      final anyPermanentlyDenied = statuses.values.any((status) => status.isPermanentlyDenied);

      if (!allGranted) {
        if (anyPermanentlyDenied && context.mounted) {
          _showPermissionDeniedDialog(context);
        } else if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Bluetooth permissions required to use printer features.'),
              duration: Duration(seconds: 3),
            ),
          );
        }
        return;
      }
    }

    // Permissions granted, toggle Bluetooth
    if (context.mounted) {
      context.read<PrinterSettingsCubit>().toggleBluetooth(enable);
    }
  }

  void _showPermissionDeniedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Row(
            children: [
              const Icon(
                Icons.warning_amber_rounded,
                color: AppColors.warning7,
                size: 28,
              ),
              12.horizontalSpace,
              const Text(
                'Permission Required',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.blackFoundation600,
                ),
              ),
            ],
          ),
          content: const Text(
            'Bluetooth permissions are required to use printer features. '
            'Please enable Bluetooth permissions in your device settings.',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.blackFoundation600,
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: AppColors.textGray2,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.of(dialogContext).pop();
                await AppSettings.openAppSettings(type: AppSettingsType.bluetooth);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.orangeAccent,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
              child: const Text(
                'Open Bluetooth Settings',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

/// Platform Warning Widget for non-mobile platforms
class PlatformWarningWidget extends StatelessWidget {
  const PlatformWarningWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.warning50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.warning3),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.info_outline,
            color: AppColors.warning7,
            size: 24,
          ),
          12.horizontalSpace,
          const Expanded(
            child: Text(
              'Bluetooth printer features are only available on Android and iOS platforms. Please run this app on a mobile device to use Bluetooth printer functionality.',
              style: TextStyle(
                fontSize: 13,
                color: AppColors.blackFoundation600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Bluetooth Toggle Widget
class BluetoothToggleWidget extends StatelessWidget {
  final bool bluetoothEnabled;
  final bool isTogglingBluetooth;
  final Function(bool) onToggle;

  const BluetoothToggleWidget({
    super.key,
    required this.bluetoothEnabled,
    required this.isTogglingBluetooth,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return ToggleItem(
      label: 'Bluetooth',
      description: 'Enable Bluetooth to connect to printer',
      value: bluetoothEnabled,
      isLoading: isTogglingBluetooth,
      onChanged: isTogglingBluetooth ? null : onToggle,
    );
  }
}

/// Connected Printer Display Widget
class ConnectedPrinterWidget extends StatelessWidget {
  final String? connectedPrinterName;
  final VoidCallback onDisconnect;

  const ConnectedPrinterWidget({
    super.key,
    this.connectedPrinterName,
    required this.onDisconnect,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.backgroundGrey6,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderGray),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: connectedPrinterName == null
                  ? AppColors.backgroundGrey3.withOpacity(0.3)
                  : AppColors.success50,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.print_outlined,
              color: connectedPrinterName == null ? AppColors.textGray2 : AppColors.success600,
              size: 24,
            ),
          ),
          16.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  connectedPrinterName ?? 'No Printer Connected',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.blackFoundation600,
                  ),
                ),
                4.verticalSpace,
                Text(
                  connectedPrinterName == null
                      ? 'Connect a Bluetooth printer to print receipts'
                      : 'Ready to print',
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textGray2,
                  ),
                ),
              ],
            ),
          ),
          if (connectedPrinterName != null)
            IconButton(
              onPressed: onDisconnect,
              icon: const Icon(Icons.close, color: AppColors.error600, size: 20),
            ),
        ],
      ),
    );
  }
}

/// Search Printer Button Widget
class SearchPrinterButtonWidget extends StatelessWidget {
  final bool bluetoothEnabled;
  final bool isScanningPrinters;
  final bool isMobilePlatform;
  final VoidCallback onSearch;

  const SearchPrinterButtonWidget({
    super.key,
    required this.bluetoothEnabled,
    required this.isScanningPrinters,
    required this.isMobilePlatform,
    required this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    final isEnabled = bluetoothEnabled && !isScanningPrinters && isMobilePlatform;

    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: isEnabled ? onSearch : null,
        icon: isScanningPrinters
            ? const SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.orangePrimary),
                ),
              )
            : const Icon(Icons.bluetooth_searching, color: AppColors.orangePrimary),
        label: Text(
          isScanningPrinters ? 'Searching...' : 'Search for Printers',
          style: TextStyle(
            color: isEnabled ? AppColors.orangePrimary : AppColors.textGray2,
          ),
        ),
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          side: BorderSide(
            color: isEnabled ? AppColors.orangePrimary : AppColors.textGray2,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}

/// Available Printers List Widget
class AvailablePrintersWidget extends StatelessWidget {
  final List<dynamic> availablePrinters;
  final String? connectedPrinterMac;
  final bool isConnectingPrinter;
  final Function(dynamic) onConnectToPrinter;

  const AvailablePrintersWidget({
    super.key,
    required this.availablePrinters,
    this.connectedPrinterMac,
    required this.isConnectingPrinter,
    required this.onConnectToPrinter,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Available Devices',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.blackFoundation600,
          ),
        ),
        8.verticalSpace,
        Container(
          constraints: const BoxConstraints(maxHeight: 200),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.borderGray),
            borderRadius: BorderRadius.circular(8),
          ),
          child: ListView.separated(
            shrinkWrap: true,
            itemCount: availablePrinters.length,
            separatorBuilder: (context, index) => const Divider(
              height: 1,
              color: AppColors.borderGray,
            ),
            itemBuilder: (context, index) {
              final printer = availablePrinters[index];
              final isConnected = connectedPrinterMac == printer.macAddress;

              return InkWell(
                onTap: isConnectingPrinter ? null : () => onConnectToPrinter(printer),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  color: isConnected ? AppColors.success50 : Colors.transparent,
                  child: Row(
                    children: [
                      Icon(
                        Icons.print,
                        color: isConnected ? AppColors.success600 : AppColors.textGray2,
                        size: 20,
                      ),
                      12.horizontalSpace,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              printer.name,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: isConnected ? FontWeight.w600 : FontWeight.w400,
                                color: AppColors.blackFoundation600,
                              ),
                            ),
                            2.verticalSpace,
                            Text(
                              printer.macAddress,
                              style: const TextStyle(
                                fontSize: 11,
                                color: AppColors.textGray2,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (isConnected)
                        const Icon(
                          Icons.check_circle,
                          color: AppColors.success600,
                          size: 20,
                        )
                      else if (isConnectingPrinter)
                        const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(AppColors.orangePrimary),
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

/// Section Title Widget
class SectionTitleWidget extends StatelessWidget {
  final String title;

  const SectionTitleWidget({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: AppColors.blackFoundation600,
      ),
    );
  }
}

/// Paper Size Dropdown Widget
class PaperSizeDropdownWidget extends StatelessWidget {
  final String paperSize;
  final Function(String?) onChanged;

  const PaperSizeDropdownWidget({
    super.key,
    required this.paperSize,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Paper Size',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.blackFoundation600,
          ),
        ),
        8.verticalSpace,
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.borderGray),
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButton<String>(
            value: paperSize,
            isExpanded: true,
            underline: const SizedBox(),
            icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.textGray2),
            items: const ['58mm', '80mm'].map((String item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.blackFoundation600,
                  ),
                ),
              );
            }).toList(),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}

/// Print Options Widget
class PrintOptionsWidget extends StatelessWidget {
  final bool autoPrintReceipt;
  final Function(bool) onAutoPrintChanged;

  const PrintOptionsWidget({
    super.key,
    required this.autoPrintReceipt,
    required this.onAutoPrintChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitleWidget(title: 'Print Options'),
        16.verticalSpace,
        ToggleItem(
          label: 'Auto Print Receipt',
          description: 'Automatically print receipt after transaction',
          value: autoPrintReceipt,
          onChanged: onAutoPrintChanged,
        ),
      ],
    );
  }
}
