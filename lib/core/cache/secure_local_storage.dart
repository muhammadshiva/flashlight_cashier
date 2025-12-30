import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Abstract interface for secure storage operations.
///
/// This abstraction allows for easy mocking in tests and
/// potential replacement of the underlying storage implementation.
abstract class SecureLocalStorage {
  /// Reads a value from secure storage.
  Future<String?> read(String key);

  /// Writes a value to secure storage.
  Future<void> write(String key, String value);

  /// Deletes a value from secure storage.
  Future<void> delete(String key);

  /// Deletes all values from secure storage.
  Future<void> deleteAll();

  /// Checks if a key exists in secure storage.
  Future<bool> containsKey(String key);

  /// Reads all key-value pairs from secure storage.
  Future<Map<String, String>> readAll();
}

/// Implementation of [SecureLocalStorage] using flutter_secure_storage.
///
/// This implementation stores sensitive data (like auth tokens) in platform-specific
/// secure storage:
/// - iOS: Keychain
/// - Android: EncryptedSharedPreferences (or Keystore on older devices)
/// - macOS: Keychain
/// - Linux: libsecret
/// - Windows: Windows Credentials Manager
class SecureLocalStorageImpl implements SecureLocalStorage {
  final FlutterSecureStorage _storage;

  SecureLocalStorageImpl({FlutterSecureStorage? storage})
      : _storage = storage ?? _createStorage();

  /// Creates a FlutterSecureStorage instance with recommended options.
  static FlutterSecureStorage _createStorage() {
    // Android options for better security
    const androidOptions = AndroidOptions(
      encryptedSharedPreferences: true,
    );

    // iOS options
    const iosOptions = IOSOptions(
      accessibility: KeychainAccessibility.first_unlock_this_device,
    );

    return const FlutterSecureStorage(
      aOptions: androidOptions,
      iOptions: iosOptions,
    );
  }

  @override
  Future<String?> read(String key) async {
    try {
      return await _storage.read(key: key);
    } catch (e) {
      // Log error but don't crash - return null as if key doesn't exist
      return null;
    }
  }

  @override
  Future<void> write(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  @override
  Future<void> delete(String key) async {
    await _storage.delete(key: key);
  }

  @override
  Future<void> deleteAll() async {
    await _storage.deleteAll();
  }

  @override
  Future<bool> containsKey(String key) async {
    return await _storage.containsKey(key: key);
  }

  @override
  Future<Map<String, String>> readAll() async {
    return await _storage.readAll();
  }
}

/// Mock implementation of [SecureLocalStorage] for testing.
class MockSecureLocalStorage implements SecureLocalStorage {
  final Map<String, String> _storage = {};

  @override
  Future<String?> read(String key) async {
    return _storage[key];
  }

  @override
  Future<void> write(String key, String value) async {
    _storage[key] = value;
  }

  @override
  Future<void> delete(String key) async {
    _storage.remove(key);
  }

  @override
  Future<void> deleteAll() async {
    _storage.clear();
  }

  @override
  Future<bool> containsKey(String key) async {
    return _storage.containsKey(key);
  }

  @override
  Future<Map<String, String>> readAll() async {
    return Map.from(_storage);
  }
}
