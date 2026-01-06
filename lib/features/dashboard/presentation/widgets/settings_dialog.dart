import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:flashlight_pos/config/themes/app_colors.dart';
import 'package:flashlight_pos/shared/widgets/toggle_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';

class SettingsDialog extends StatefulWidget {
  const SettingsDialog({super.key});

  @override
  State<SettingsDialog> createState() => _SettingsDialogState();
}

class _SettingsDialogState extends State<SettingsDialog> {
  String selectedMenu = 'store_info';
  bool autoCalculateTax = true;

  // Printer Settings
  bool bluetoothEnabled = false;
  bool autoPrintReceipt = true;
  bool printLogo = true;
  String paperSize = '58mm';
  String selectedPrinter = 'Not Connected';
  bool isSearchingPrinter = false;
  List<BluetoothInfo> availablePrinters = [];
  bool isTogglingBluetooth = false; // Loading state untuk toggle

  StreamSubscription<BluetoothAdapterState>? _bluetoothStateSubscription;

  @override
  void initState() {
    super.initState();
    _initBluetooth();
  }

  Future<void> _initBluetooth() async {
    // Check if platform is mobile (Android or iOS)
    if (!Platform.isAndroid && !Platform.isIOS) {
      log("Bluetooth printer is only supported on Android and iOS platforms",
          name: "SettingsDialog");
      return;
    }

    try {
      // Request Bluetooth permissions for Android
      if (Platform.isAndroid) {
        Map<Permission, PermissionStatus> statuses = await [
          Permission.bluetooth,
          Permission.bluetoothScan,
          Permission.bluetoothConnect,
        ].request();

        log("Bluetooth permissions: $statuses", name: "SettingsDialog");

        // Check if all permissions granted
        bool allGranted = statuses.values.every((status) => status.isGranted);
        bool anyPermanentlyDenied = statuses.values.any((status) => status.isPermanentlyDenied);

        if (!allGranted) {
          log("Bluetooth permissions not granted", name: "SettingsDialog");

          if (anyPermanentlyDenied && mounted) {
            // If permanently denied, show dialog to open settings
            _showPermissionDeniedDialog();
          } else if (mounted) {
            // If just denied, show snackbar
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Bluetooth permissions required to use printer features.'),
                duration: Duration(seconds: 3),
              ),
            );
          }
          return; // Don't proceed with Bluetooth initialization
        }
      }

      // Get current Bluetooth state
      final bool isOn = await PrintBluetoothThermal.bluetoothEnabled;
      if (mounted) {
        setState(() {
          bluetoothEnabled = isOn;
        });
      }

      // Listen to Bluetooth adapter state changes from flutter_blue_plus
      _bluetoothStateSubscription =
          FlutterBluePlus.adapterState.listen((BluetoothAdapterState state) {
        if (mounted) {
          setState(() {
            bluetoothEnabled = state == BluetoothAdapterState.on;
            if (state != BluetoothAdapterState.on) {
              selectedPrinter = 'Not Connected';
              availablePrinters = [];
              isSearchingPrinter = false;
            }
          });
        }
      });
    } catch (e, stacktrace) {
      log("Error initializing Bluetooth: $e",
          name: "SettingsDialog", error: e, stackTrace: stacktrace);

      // Set default state on error
      if (mounted) {
        setState(() {
          bluetoothEnabled = false;
        });
      }
    }
  }

  Future<void> _handleBluetoothToggle(bool value) async {
    // Prevent spam clicking
    if (isTogglingBluetooth) return;

    setState(() {
      isTogglingBluetooth = true;
    });

    try {
      if (value) {
        // Request to turn on Bluetooth
        try {
          await FlutterBluePlus.turnOn();
        } catch (e, stackTrace) {
          log("Error turning on Bluetooth: $e\n$stackTrace");
          if (mounted) {
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  backgroundColor: AppColors.white,
                  content: Text('Please enable Bluetooth from settings',
                      style: TextStyle(color: AppColors.blackFoundation600))),
            );
          }
        }
      } else {
        // Note: Turning off Bluetooth programmatically is not supported on most platforms
        if (mounted) {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                backgroundColor: AppColors.white,
                content: Text('Please disable Bluetooth from device settings',
                    style: TextStyle(color: AppColors.blackFoundation600))),
          );
        }
      }
    } finally {
      // Wait a bit before allowing toggle again
      await Future.delayed(const Duration(milliseconds: 1500));
      if (mounted) {
        setState(() {
          isTogglingBluetooth = false;
        });
      }
    }
  }

  void _showPermissionDeniedDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
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
                Navigator.of(context).pop();
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
                Navigator.of(context).pop();
                // Open Bluetooth settings directly
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

  @override
  void dispose() {
    _bluetoothStateSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final dialogWidth = screenWidth * 0.8;

    return Dialog(
      insetPadding: EdgeInsets.symmetric(vertical: 70.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        width: dialogWidth,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            // Left Sidebar Menu
            Container(
              width: 250.w,
              decoration: const BoxDecoration(
                color: AppColors.backgroundGrey6,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(24),
                    child: Text(
                      'Settings Menu',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: AppColors.blackFoundation600,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      padding: EdgeInsets.symmetric(horizontal: 12.w).copyWith(bottom: 24.h),
                      children: [
                        _buildMenuItem(
                          icon: Icons.store_outlined,
                          label: 'Store Information',
                          value: 'store_info',
                        ),
                        _buildMenuItem(
                          icon: Icons.point_of_sale_outlined,
                          label: 'POS Settings',
                          value: 'pos_settings',
                        ),
                        _buildMenuItem(
                          icon: Icons.print_outlined,
                          label: 'Printer Settings',
                          value: 'printer_settings',
                        ),
                        _buildMenuItem(
                          icon: Icons.receipt_outlined,
                          label: 'Receipt Settings',
                          value: 'receipt_settings',
                        ),
                        _buildMenuItem(
                          icon: Icons.language_outlined,
                          label: 'Language',
                          value: 'language',
                        ),
                        _buildMenuItem(
                          icon: Icons.notifications_outlined,
                          label: 'Notifications',
                          value: 'notifications',
                        ),
                        _buildMenuItem(
                          icon: Icons.security_outlined,
                          label: 'Security',
                          value: 'security',
                        ),
                        _buildMenuItem(
                          icon: Icons.cloud_upload_outlined,
                          label: 'Backup & Restore',
                          value: 'backup',
                        ),
                        _buildMenuItem(
                          icon: Icons.display_settings_outlined,
                          label: 'Display',
                          value: 'display',
                        ),
                        _buildMenuItem(
                          icon: Icons.data_usage_outlined,
                          label: 'Data Management',
                          value: 'data_management',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Right Content Area
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header with close button
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _getContentTitle(),
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: AppColors.blackFoundation600,
                          ),
                        ),
                        IconButton(
                          onPressed: () => Navigator.of(context).pop(),
                          icon: const Icon(Icons.close, color: AppColors.blackFoundation600),
                          style: IconButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Content
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: _buildContent(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String label,
    required String value,
  }) {
    final isSelected = selectedMenu == value;

    return InkWell(
      onTap: () {
        setState(() {
          selectedMenu = value;
        });
      },
      borderRadius: BorderRadius.circular(8),
      child: Container(
        margin: const EdgeInsets.only(bottom: 4),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: isSelected ? 24.sp : 20.sp,
              color: isSelected ? AppColors.orangePrimary : AppColors.textGray2,
            ),
            const SizedBox(width: 12),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                color: isSelected ? AppColors.orangePrimary : AppColors.blackFoundation600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getContentTitle() {
    switch (selectedMenu) {
      case 'store_info':
        return 'Store Information';
      case 'pos_settings':
        return 'POS Settings';
      case 'printer_settings':
        return 'Printer Settings';
      case 'receipt_settings':
        return 'Receipt Settings';
      case 'language':
        return 'Language';
      case 'notifications':
        return 'Notifications';
      case 'security':
        return 'Security';
      case 'backup':
        return 'Backup & Restore';
      case 'display':
        return 'Display';
      case 'data_management':
        return 'Data Management';
      default:
        return 'Settings';
    }
  }

  Widget _buildContent() {
    switch (selectedMenu) {
      case 'store_info':
        return _buildStoreInformation();
      case 'pos_settings':
        return _buildPOSSettings();
      case 'printer_settings':
        return _buildPrinterSettings();
      default:
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(48),
            child: Text(
              'Content for ${_getContentTitle()} coming soon',
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.textGray2,
              ),
            ),
          ),
        );
    }
  }

  Widget _buildStoreInformation() {
    return Column(
      children: [
        _buildInfoItem(
          label: 'Store Name',
          value: 'Mocca POS',
        ),
        24.verticalSpace,
        _buildInfoItem(
          label: 'Store Address',
          value: 'Jl. Merdeka No. 123, Jakarta',
        ),
        24.verticalSpace,
        _buildInfoItem(
          label: 'Store Phone',
          value: '+62 21 1234 5678',
        ),
        24.verticalSpace,
        _buildInfoItem(
          label: 'Store Email',
          value: 'info@moccapos.com',
        ),
        24.verticalSpace,
      ],
    );
  }

  Widget _buildPOSSettings() {
    return Column(
      children: [
        _buildInfoItem(
          label: 'Tax Rate (%)',
          value: '11.0%',
        ),
        32.verticalSpace,
        ToggleItem(
          label: 'Auto Calculate Tax',
          description: 'Automatically calculate tax for transactions',
          value: autoCalculateTax,
          onChanged: (value) {
            setState(() {
              autoCalculateTax = value;
            });
          },
        ),
        24.verticalSpace,
      ],
    );
  }

  Widget _buildInfoItem({
    required String label,
    required String value,
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
        Row(
          children: [
            Expanded(
              child: Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.textGray2,
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Edit $label - coming soon')),
                );
              },
              icon: const Icon(
                Icons.edit_outlined,
                size: 20,
                color: AppColors.orangeAccent,
              ),
              style: IconButton.styleFrom(
                padding: const EdgeInsets.all(8),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPrinterSettings() {
    // Check if platform is mobile
    final bool isMobilePlatform = Platform.isAndroid || Platform.isIOS;

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
        ToggleItem(
          label: 'Bluetooth',
          description: 'Enable Bluetooth to connect to printer',
          value: bluetoothEnabled,
          isLoading: isTogglingBluetooth,
          onChanged: isTogglingBluetooth
              ? null
              : (value) {
                  _handleBluetoothToggle(value);
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
                  color: selectedPrinter == 'Not Connected'
                      ? AppColors.backgroundGrey3.withOpacity(0.3)
                      : AppColors.success50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.print_outlined,
                  color: selectedPrinter == 'Not Connected'
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
                      selectedPrinter == 'Not Connected' ? 'No Printer Connected' : selectedPrinter,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.blackFoundation600,
                      ),
                    ),
                    4.verticalSpace,
                    Text(
                      selectedPrinter == 'Not Connected'
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
              if (selectedPrinter != 'Not Connected')
                IconButton(
                  onPressed: () {
                    setState(() {
                      selectedPrinter = 'Not Connected';
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Printer disconnected')),
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
            onPressed: (!bluetoothEnabled ||
                    isSearchingPrinter ||
                    (!Platform.isAndroid && !Platform.isIOS))
                ? null
                : () async {
                    setState(() {
                      isSearchingPrinter = true;
                      availablePrinters = [];
                    });

                    try {
                      // Get paired Bluetooth devices using print_bluetooth_thermal
                      final List<BluetoothInfo> devices =
                          await PrintBluetoothThermal.pairedBluetooths;

                      if (mounted) {
                        setState(() {
                          availablePrinters = devices;
                          isSearchingPrinter = false;
                        });

                        if (devices.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  'No paired Bluetooth devices found. Please pair your printer first in device settings.'),
                            ),
                          );
                        }
                      }
                    } catch (e) {
                      if (mounted) {
                        setState(() {
                          isSearchingPrinter = false;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Error searching devices: $e')),
                        );
                      }
                    }
                  },
            icon: isSearchingPrinter
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
              isSearchingPrinter ? 'Searching...' : 'Search for Printers',
              style: TextStyle(
                color: (!bluetoothEnabled || isSearchingPrinter)
                    ? AppColors.textGray2
                    : AppColors.orangePrimary,
              ),
            ),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              side: BorderSide(
                color: (!bluetoothEnabled || isSearchingPrinter)
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
        if (availablePrinters.isNotEmpty) ...[
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
              itemCount: availablePrinters.length,
              separatorBuilder: (context, index) => const Divider(
                height: 1,
                color: AppColors.borderGray,
              ),
              itemBuilder: (context, index) {
                final printer = availablePrinters[index];
                final isConnected = selectedPrinter == printer.name;

                return InkWell(
                  onTap: () async {
                    try {
                      // Connect to the selected printer
                      final bool connected =
                          await PrintBluetoothThermal.connect(macPrinterAddress: printer.macAdress);

                      if (mounted) {
                        if (connected) {
                          setState(() {
                            selectedPrinter = printer.name;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Connected to ${printer.name}')),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Failed to connect to ${printer.name}')),
                          );
                        }
                      }
                    } catch (e) {
                      if (mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Error connecting: $e')),
                        );
                      }
                    }
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
                                  fontWeight: isConnected ? FontWeight.w600 : FontWeight.w400,
                                  color: AppColors.blackFoundation600,
                                ),
                              ),
                              2.verticalSpace,
                              Text(
                                printer.macAdress,
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
          label: 'Paper Size',
          value: paperSize,
          items: const ['58mm', '80mm'],
          onChanged: (value) {
            setState(() {
              paperSize = value!;
            });
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

        ToggleItem(
          label: 'Auto Print Receipt',
          description: 'Automatically print receipt after transaction',
          value: autoPrintReceipt,
          onChanged: (value) {
            setState(() {
              autoPrintReceipt = value;
            });
          },
        ),

        24.verticalSpace,

        ToggleItem(
          label: 'Print Logo',
          description: 'Include store logo on printed receipts',
          value: printLogo,
          onChanged: (value) {
            setState(() {
              printLogo = value;
            });
          },
        ),

        32.verticalSpace,

        // Test Print Button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: selectedPrinter == 'Not Connected'
                ? null
                : () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Printing test receipt...')),
                    );
                  },
            icon: const Icon(Icons.print, color: Colors.white),
            label: const Text('Print Test Receipt', style: TextStyle(color: Colors.white)),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.orangePrimary,
              disabledBackgroundColor: AppColors.backgroundGrey3,
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),

        24.verticalSpace,
      ],
    );
  }

  Widget _buildDropdownItem({
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
