import 'package:hive_flutter/hive_flutter.dart';

import 'adapters/user_adapter.dart';
import 'adapters/customer_adapter.dart';

/// Hive box names used throughout the application.
class HiveBoxNames {
  HiveBoxNames._();

  static const String users = 'users_box';
  static const String auth = 'auth_box';
  static const String customers = 'customers_box';
  static const String cacheTimestamps = '__cache_timestamps__';
}

/// Hive type IDs for all registered adapters.
///
/// Type IDs must be unique across all adapters (0-223).
class HiveTypeIds {
  HiveTypeIds._();

  static const int userEntity = 0;
  static const int authEntity = 1;
  static const int membership = 2;
  static const int customer = 3;
}

/// Configures Hive storage for the application.
///
/// This class handles:
/// - Hive initialization
/// - Type adapter registration
/// - Box opening
class HiveConfig {
  HiveConfig._();

  static bool _isInitialized = false;

  /// Initializes Hive and registers all type adapters.
  ///
  /// This should be called once at app startup, before runApp().
  /// Call this after WidgetsFlutterBinding.ensureInitialized().
  static Future<void> init() async {
    if (_isInitialized) return;

    // Initialize Hive with Flutter
    await Hive.initFlutter();

    // Register type adapters
    _registerAdapters();

    _isInitialized = true;
  }

  /// Registers all Hive type adapters.
  static void _registerAdapters() {
    // Auth/User adapters
    if (!Hive.isAdapterRegistered(HiveTypeIds.userEntity)) {
      Hive.registerAdapter(UserEntityAdapter());
    }
    if (!Hive.isAdapterRegistered(HiveTypeIds.authEntity)) {
      Hive.registerAdapter(AuthEntityAdapter());
    }

    // Customer adapters
    if (!Hive.isAdapterRegistered(HiveTypeIds.membership)) {
      Hive.registerAdapter(MembershipAdapter());
    }
    if (!Hive.isAdapterRegistered(HiveTypeIds.customer)) {
      Hive.registerAdapter(CustomerAdapter());
    }
  }

  /// Opens all required boxes.
  ///
  /// Call this after [init] if you want to pre-open boxes.
  static Future<void> openBoxes() async {
    await Future.wait([
      Hive.openBox(HiveBoxNames.auth),
      Hive.openBox(HiveBoxNames.users),
      Hive.openBox(HiveBoxNames.customers),
      Hive.openBox<int>(HiveBoxNames.cacheTimestamps),
    ]);
  }

  /// Closes all open boxes.
  ///
  /// Call this when the app is being disposed.
  static Future<void> closeBoxes() async {
    await Hive.close();
  }

  /// Clears all cached data.
  ///
  /// Use with caution - this will delete all local cache.
  static Future<void> clearAllCache() async {
    await Hive.deleteFromDisk();
  }

  /// Clears a specific box.
  static Future<void> clearBox(String boxName) async {
    if (Hive.isBoxOpen(boxName)) {
      final box = Hive.box(boxName);
      await box.clear();
    } else {
      final box = await Hive.openBox(boxName);
      await box.clear();
    }
  }
}
