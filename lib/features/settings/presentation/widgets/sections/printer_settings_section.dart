import 'dart:io';
import 'package:app_settings/app_settings.dart';
import 'package:flashlight_pos/config/themes/app_colors.dart';
import 'package:flashlight_pos/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission_handler/permission_handler.dart';

/// Printer Settings Section with BLoC pattern
///
/// This widget displays printer configuration UI and uses SettingsBloc
/// for state management instead of StatefulWidget
class PrinterSettingsSection extends StatelessWidget {
  const PrinterSettingsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      // Optimize: Only rebuild when printer-related state changes
      buildWhen: (previous, current) =>
          previous.printerSettings != current.printerSettings ||
          previous.isScanningPrinters != current.isScanningPrinters ||
          previous.availablePrinters != current.availablePrinters ||
          previous.isTogglingBluetooth != current.isTogglingBluetooth ||
          previous.isConnectingPrinter != current.isConnectingPrinter,
      builder: (context, state) {
        final printerSettings = state.printerSettings;
        final isMobilePlatform = Platform.isAndroid || Platform.isIOS;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Platform Warning for non-mobile platforms
            if (!isMobilePlatform) ...[
              Container(
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
              ),
              24.verticalSpace,
            ],

            // Bluetooth Toggle
            _buildToggleItem(
              context,
              label: 'Bluetooth',
              description: 'Enable Bluetooth to connect to printer',
              value: printerSettings.bluetoothEnabled,
              isLoading: state.isTogglingBluetooth,
              onChanged: state.isTogglingBluetooth
                  ? null
                  : (value) {
                      _requestBluetoothPermissions(context, value);
                    },
            ),

            24.verticalSpace,

            // Printer Connection Section
            const Text(
              'Bluetooth Printer',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppColors.blackFoundation600,
              ),
            ),
            16.verticalSpace,

            // Connected Printer Display
            Container(
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
                      color: printerSettings.connectedPrinterName == null
                          ? AppColors.backgroundGrey3.withOpacity(0.3)
                          : AppColors.success50,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.print_outlined,
                      color: printerSettings.connectedPrinterName == null
                          ? AppColors.textGray2
                          : AppColors.success600,
                      size: 24,
                    ),
                  ),
                  16.horizontalSpace,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          printerSettings.connectedPrinterName ?? 'No Printer Connected',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.blackFoundation600,
                          ),
                        ),
                        4.verticalSpace,
                        Text(
                          printerSettings.connectedPrinterName == null
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
                  if (printerSettings.connectedPrinterName != null)
                    IconButton(
                      onPressed: () {
                        context.read<SettingsBloc>().add(
                              const SettingsEvent.disconnectPrinter(),
                            );
                      },
                      icon: const Icon(Icons.close, color: AppColors.error600, size: 20),
                    ),
                ],
              ),
            ),

            16.verticalSpace,

            // Search Printer Button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: (!printerSettings.bluetoothEnabled ||
                        state.isScanningPrinters ||
                        !isMobilePlatform)
                    ? null
                    : () {
                        context.read<SettingsBloc>().add(
                              const SettingsEvent.scanPrinters(),
                            );
                      },
                icon: state.isScanningPrinters
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
                  state.isScanningPrinters ? 'Searching...' : 'Search for Printers',
                  style: TextStyle(
                    color: (!printerSettings.bluetoothEnabled || state.isScanningPrinters)
                        ? AppColors.textGray2
                        : AppColors.orangePrimary,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  side: BorderSide(
                    color: (!printerSettings.bluetoothEnabled || state.isScanningPrinters)
                        ? AppColors.textGray2
                        : AppColors.orangePrimary,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),

            // Available Printers List
            if (state.availablePrinters.isNotEmpty) ...[
              16.verticalSpace,
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
                  itemCount: state.availablePrinters.length,
                  separatorBuilder: (context, index) => const Divider(
                    height: 1,
                    color: AppColors.borderGray,
                  ),
                  itemBuilder: (context, index) {
                    final printer = state.availablePrinters[index];
                    final isConnected =
                        printerSettings.connectedPrinterMac == printer.macAddress;

                    return InkWell(
                      onTap: state.isConnectingPrinter
                          ? null
                          : () {
                              context.read<SettingsBloc>().add(
                                    SettingsEvent.connectPrinter(device: printer),
                                  );
                            },
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
                                      fontWeight:
                                          isConnected ? FontWeight.w600 : FontWeight.w400,
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
                            else if (state.isConnectingPrinter)
                              const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor:
                                      AlwaysStoppedAnimation<Color>(AppColors.orangePrimary),
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

            32.verticalSpace,

            // Printer Configuration
            const Text(
              'Printer Configuration',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppColors.blackFoundation600,
              ),
            ),
            16.verticalSpace,

            // Paper Size Selection
            _buildDropdownItem(
              context,
              label: 'Paper Size',
              value: printerSettings.paperSize,
              items: const ['58mm', '80mm'],
              onChanged: (value) {
                if (value != null) {
                  context.read<SettingsBloc>().add(
                        SettingsEvent.updatePrinterSettings(
                          settings: printerSettings.copyWith(paperSize: value),
                        ),
                      );
                }
              },
            ),

            24.verticalSpace,

            // Print Options
            const Text(
              'Print Options',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppColors.blackFoundation600,
              ),
            ),
            16.verticalSpace,

            _buildToggleItem(
              context,
              label: 'Auto Print Receipt',
              description: 'Automatically print receipt after transaction',
              value: printerSettings.autoPrintReceipt,
              onChanged: (value) {
                context.read<SettingsBloc>().add(
                      SettingsEvent.updatePrinterSettings(
                        settings: printerSettings.copyWith(autoPrintReceipt: value),
                      ),
                    );
              },
            ),

            24.verticalSpace,

            _buildToggleItem(
              context,
              label: 'Print Logo',
              description: 'Include store logo on printed receipts',
              value: printerSettings.printLogo,
              onChanged: (value) {
                context.read<SettingsBloc>().add(
                      SettingsEvent.updatePrinterSettings(
                        settings: printerSettings.copyWith(printLogo: value),
                      ),
                    );
              },
            ),

            24.verticalSpace,
          ],
        );
      },
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
      context.read<SettingsBloc>().add(
            SettingsEvent.toggleBluetooth(enable: enable),
          );
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

  Widget _buildToggleItem(
    BuildContext context, {
    required String label,
    required String description,
    required bool value,
    required ValueChanged<bool>? onChanged,
    bool isLoading = false,
  }) {
    return Row(
      children: [
        Expanded(
          child: Column(
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
                style: TextStyle(
                  fontSize: 13,
                  color: isLoading ? AppColors.textGray2.withOpacity(0.5) : AppColors.textGray2,
                ),
              ),
            ],
          ),
        ),
        if (isLoading)
          const SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.orangeAccent),
            ),
          )
        else
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.orangeAccent,
            activeTrackColor: AppColors.warning3,
          ),
      ],
    );
  }

  Widget _buildDropdownItem(
    BuildContext context, {
    required String label,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
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
        8.verticalSpace,
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.borderGray),
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButton<String>(
            value: value,
            isExpanded: true,
            underline: const SizedBox(),
            icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.textGray2),
            items: items.map((String item) {
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
