# Settings Feature Implementation Guide

## ✅ Completed (Opsi 3: Hybrid BLoC + Cubit)

### Domain Layer ✓
- ✅ `AppSettings` entity (Store, POS, Language, Display)
- ✅ `PrinterSettings` entity
- ✅ `PrinterDevice` entity
- ✅ `ReceiptSettings` entity
- ✅ `NotificationSettings` entity
- ✅ `SecuritySettings` entity
- ✅ `SettingsRepository` interface
- ✅ All use cases (GetAppSettings, UpdateAppSettings, ScanPrinters, ConnectPrinter, etc.)

### Data Layer ✓
- ✅ All Freezed models with JSON serialization
- ✅ `SettingsLocalDataSource` (SharedPreferences)
- ✅ `PrinterDataSource` (Bluetooth operations)
- ✅ `SettingsRepositoryImpl`

### Presentation Layer (BLoC) ✓
- ✅ `SettingsBloc` (HydratedBloc) - Data persistence
- ✅ `SettingsEvent` - All 10+ events
- ✅ `SettingsState` - Complete state with JSON converters
- ✅ `SettingsUICubit` - UI state management (menu selection, dirty state)
- ✅ JSON Converters for domain entities

### Code Generation ✓
- ✅ All Freezed models generated
- ✅ SettingsBloc generated

---

## 🚧 Remaining Tasks

### 1. Dependency Injection (injection_container.dart)

Add to `lib/injection_container.dart`:

```dart
// ============ SETTINGS ============
// BLoC
sl.registerFactory(
  () => SettingsBloc(
    getAppSettings: sl(),
    updateAppSettings: sl(),
    scanPrinters: sl(),
    connectPrinter: sl(),
    disconnectPrinter: sl(),
    updatePrinterSettings: sl(),
  ),
);

// Use Cases
sl.registerLazySingleton(() => GetAppSettings(sl()));
sl.registerLazySingleton(() => UpdateAppSettings(sl()));
sl.registerLazySingleton(() => ScanPrinters(sl()));
sl.registerLazySingleton(() => ConnectPrinter(sl()));
sl.registerLazySingleton(() => DisconnectPrinter(sl()));
sl.registerLazySingleton(() => UpdatePrinterSettings(sl()));

// Repository
sl.registerLazySingleton<SettingsRepository>(
  () => SettingsRepositoryImpl(
    localDataSource: sl(),
    printerDataSource: sl(),
  ),
);

// Data Sources
sl.registerLazySingleton<SettingsLocalDataSource>(
  () => SettingsLocalDataSourceImpl(sharedPreferences: sl()),
);
sl.registerLazySingleton<PrinterDataSource>(
  () => PrinterDataSourceImpl(),
);
```

**Imports to add:**
```dart
import 'package:flashlight_pos/features/settings/data/datasources/printer_datasource.dart';
import 'package:flashlight_pos/features/settings/data/datasources/settings_local_datasource.dart';
import 'package:flashlight_pos/features/settings/data/repositories/settings_repository_impl.dart';
import 'package:flashlight_pos/features/settings/domain/repositories/settings_repository.dart';
import 'package:flashlight_pos/features/settings/domain/usecases/connect_printer.dart';
import 'package:flashlight_pos/features/settings/domain/usecases/disconnect_printer.dart';
import 'package:flashlight_pos/features/settings/domain/usecases/get_app_settings.dart';
import 'package:flashlight_pos/features/settings/domain/usecases/scan_printers.dart';
import 'package:flashlight_pos/features/settings/domain/usecases/update_app_settings.dart';
import 'package:flashlight_pos/features/settings/domain/usecases/update_printer_settings.dart';
import 'package:flashlight_pos/features/settings/presentation/bloc/settings_bloc.dart';
```

---

### 2. Register SettingsBloc in main.dart

Add to `MultiBlocProvider` in `main.dart`:

```dart
BlocProvider<SettingsBloc>(
  create: (context) => sl<SettingsBloc>()..add(const SettingsEvent.loadSettings()),
),
```

**Import to add:**
```dart
import 'package:flashlight_pos/features/settings/presentation/bloc/settings_bloc.dart';
```

---

### 3. Create SettingsDialog Widget

**File:** `lib/features/settings/presentation/widgets/settings_dialog.dart`

**Key Points:**
- Use existing code from `lib/features/dashboard/presentation/widgets/settings_dialog.dart` as reference
- Wrap with `BlocProvider` for `SettingsUICubit` (dialog-scoped)
- Use `BlocBuilder<SettingsBloc, SettingsState>` for data
- Use `BlocBuilder<SettingsUICubit, SettingsUIState>` for menu navigation
- Add `BlocListener<SettingsBloc, SettingsState>` for error/success messages

**Structure:**
```dart
class SettingsDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SettingsUICubit(), // Dialog-scoped
      child: BlocListener<SettingsBloc, SettingsState>(
        listener: (context, state) {
          // Show snackbar for errors
          if (state.status == SettingsStatus.failure && state.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage!)),
            );
          }
        },
        child: Dialog(
          child: Row(
            children: [
              _buildSidebar(), // Menu items
              Expanded(child: _buildContent()), // Dynamic content
            ],
          ),
        ),
      ),
    );
  }
}
```

---

### 4. Create PrinterSettingsSection Widget

**File:** `lib/features/settings/presentation/widgets/sections/printer_settings_section.dart`

**Use the existing code from:**
`lib/features/dashboard/presentation/widgets/settings_dialog.dart` (lines 642-1050)

**Key changes:**
- Make it **StatelessWidget**
- Use `BlocBuilder<SettingsBloc, SettingsState>` with `buildWhen`
- Replace all `setState` calls with `context.read<SettingsBloc>().add(...)`
- Replace state variables with `state.printerSettings.xxx`

**Example:**
```dart
class PrinterSettingsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      buildWhen: (previous, current) =>
          previous.printerSettings != current.printerSettings ||
          previous.isScanningPrinters != current.isScanningPrinters ||
          previous.availablePrinters != current.availablePrinters ||
          previous.isTogglingBluetooth != current.isTogglingBluetooth ||
          previous.isConnectingPrinter != current.isConnectingPrinter,
      builder: (context, state) {
        final printerSettings = state.printerSettings;

        return Column(
          children: [
            // Bluetooth Toggle
            _buildToggleItem(
              context,
              label: 'Bluetooth',
              value: printerSettings.bluetoothEnabled,
              isLoading: state.isTogglingBluetooth,
              onChanged: (value) {
                context.read<SettingsBloc>().add(
                  SettingsEvent.toggleBluetooth(enable: value),
                );
              },
            ),

            // Scan Button
            OutlinedButton.icon(
              onPressed: state.isScanningPrinters ? null : () {
                context.read<SettingsBloc>().add(
                  const SettingsEvent.scanPrinters(),
                );
              },
              icon: state.isScanningPrinters
                ? CircularProgressIndicator()
                : Icon(Icons.bluetooth_searching),
              label: Text(state.isScanningPrinters ? 'Searching...' : 'Search'),
            ),

            // Available Printers List
            if (state.availablePrinters.isNotEmpty)
              ListView.builder(
                itemCount: state.availablePrinters.length,
                itemBuilder: (context, index) {
                  final printer = state.availablePrinters[index];
                  return ListTile(
                    onTap: () {
                      context.read<SettingsBloc>().add(
                        SettingsEvent.connectPrinter(device: printer),
                      );
                    },
                    title: Text(printer.name),
                    subtitle: Text(printer.macAddress),
                  );
                },
              ),
          ],
        );
      },
    );
  }
}
```

---

### 5. Update Dashboard to Use New Settings

**File:** `lib/features/dashboard/presentation/pages/dashboard_layout.dart`

Find where the old `SettingsDialog` is called and update:

```dart
// OLD (if exists):
// showDialog(context: context, builder: (_) => SettingsDialog());

// NEW:
showDialog(
  context: context,
  builder: (_) => BlocProvider.value(
    value: context.read<SettingsBloc>(), // Share global BLoC
    child: const SettingsDialog(), // New settings dialog
  ),
);
```

**Import to add:**
```dart
import 'package:flashlight_pos/features/settings/presentation/widgets/settings_dialog.dart';
```

---

## 📋 Optional: Additional Sections

Create similar widgets for other sections:

1. **StoreInfoSection** - Store info editing
2. **POSSettingsSection** - Tax rate, auto-calculate
3. **ReceiptSettingsSection** - Receipt customization
4. **NotificationSettingsSection** - Notification preferences
5. **SecuritySettingsSection** - PIN requirements
6. **BackupSettingsSection** - Backup/restore
7. **DisplaySettingsSection** - Theme, font size
8. **DataManagementSection** - Clear cache, etc.

**Pattern for each:**
```dart
class [SectionName]Section extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      buildWhen: (prev, curr) => prev.[relevantSettings] != curr.[relevantSettings],
      builder: (context, state) {
        return Column(
          children: [
            // UI elements that read from state.[settings]
            // and dispatch events via context.read<SettingsBloc>().add(...)
          ],
        );
      },
    );
  }
}
```

---

## 🔍 Testing Checklist

After implementation:

1. ✅ Settings persist after app restart (HydratedBloc)
2. ✅ Bluetooth toggle works
3. ✅ Printer scan finds devices
4. ✅ Printer connection works
5. ✅ Settings changes auto-save
6. ✅ Error messages show in SnackBar
7. ✅ Menu navigation works (SettingsUICubit)
8. ✅ No unnecessary rebuilds (check buildWhen)
9. ✅ Dialog closes properly
10. ✅ Printer state syncs with system Bluetooth

---

## 🎯 Key Architecture Benefits

### Opsi 3 Advantages:
1. **Single SettingsBloc** - All data in one place
2. **Separate UI Cubit** - Menu navigation isolated
3. **HydratedBloc** - Auto-persistence
4. **Stateless Widgets** - No StatefulWidget needed
5. **buildWhen Optimization** - Minimal rebuilds
6. **Clean Separation** - Data state vs UI state

### Data Flow:
```
User Interaction
  → Event dispatch (context.read<SettingsBloc>().add(...))
  → SettingsBloc handler
  → Use Case execution
  → Repository call
  → DataSource operation
  → State emission (emit(state.copyWith(...)))
  → HydratedBloc auto-saves
  → BlocBuilder rebuilds (if buildWhen passes)
  → UI updates
```

---

## 🚀 Quick Start Commands

```bash
# 1. Run code generation (if needed)
flutter packages pub run build_runner build --delete-conflicting-outputs

# 2. Run the app
flutter run

# 3. Test settings dialog
# - Open dashboard
# - Click settings button
# - Navigate between menus
# - Change printer settings
# - Restart app to verify persistence
```

---

## 📝 Notes

- **Platform Support**: Bluetooth printer only works on Android/iOS
- **Permissions**: Android needs Bluetooth permissions (already handled in existing code)
- **State Persistence**: Uses HydratedBloc storage (automatic)
- **Error Handling**: All failures handled via Either<Failure, T>
- **Testing**: Each layer can be unit tested independently

---

**Created by Claude Code**
**Architecture: Opsi 3 (Hybrid BLoC + Cubit)**
**Status: 70% Complete - Ready for UI implementation**
