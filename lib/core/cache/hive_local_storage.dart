import 'package:hive_flutter/hive_flutter.dart';

/// Abstract interface for Hive-based local storage operations.
///
/// This abstraction provides a generic interface for caching entities
/// with support for TTL (Time To Live) based cache expiration.
abstract class HiveLocalStorage<T> {
  /// Gets a single item by key.
  Future<T?> get(String key);

  /// Stores a single item with the given key.
  Future<void> put(String key, T value);

  /// Gets all items from the cache.
  Future<List<T>> getAll();

  /// Stores multiple items.
  Future<void> putAll(Map<String, T> items);

  /// Deletes a single item by key.
  Future<void> delete(String key);

  /// Clears all items from the cache.
  Future<void> clear();

  /// Checks if an item exists with the given key.
  Future<bool> containsKey(String key);

  /// Gets all keys in the cache.
  Future<List<String>> getKeys();

  /// Checks if the cache is valid (not expired).
  Future<bool> isCacheValid();

  /// Updates the cache timestamp to current time.
  Future<void> updateCacheTimestamp();
}

/// Implementation of [HiveLocalStorage] using Hive.
///
/// Provides local caching with TTL support for cache expiration.
class HiveLocalStorageImpl<T> implements HiveLocalStorage<T> {
  final String boxName;
  final Duration cacheDuration;

  static const String _timestampKey = '__cache_timestamp__';

  HiveLocalStorageImpl({
    required this.boxName,
    this.cacheDuration = const Duration(hours: 1),
  });

  /// Gets or opens the Hive box.
  Future<Box<T>> _getBox() async {
    if (Hive.isBoxOpen(boxName)) {
      return Hive.box<T>(boxName);
    }
    return await Hive.openBox<T>(boxName);
  }

  /// Gets the timestamp box for storing cache metadata.
  Future<Box<int>> _getTimestampBox() async {
    const timestampBoxName = '__cache_timestamps__';
    if (Hive.isBoxOpen(timestampBoxName)) {
      return Hive.box<int>(timestampBoxName);
    }
    return await Hive.openBox<int>(timestampBoxName);
  }

  @override
  Future<T?> get(String key) async {
    final box = await _getBox();
    return box.get(key);
  }

  @override
  Future<void> put(String key, T value) async {
    final box = await _getBox();
    await box.put(key, value);
  }

  @override
  Future<List<T>> getAll() async {
    final box = await _getBox();
    return box.values.toList();
  }

  @override
  Future<void> putAll(Map<String, T> items) async {
    final box = await _getBox();
    await box.putAll(items);
  }

  @override
  Future<void> delete(String key) async {
    final box = await _getBox();
    await box.delete(key);
  }

  @override
  Future<void> clear() async {
    final box = await _getBox();
    await box.clear();

    // Also clear the timestamp
    final timestampBox = await _getTimestampBox();
    await timestampBox.delete('$boxName$_timestampKey');
  }

  @override
  Future<bool> containsKey(String key) async {
    final box = await _getBox();
    return box.containsKey(key);
  }

  @override
  Future<List<String>> getKeys() async {
    final box = await _getBox();
    return box.keys.cast<String>().toList();
  }

  @override
  Future<bool> isCacheValid() async {
    final timestampBox = await _getTimestampBox();
    final timestamp = timestampBox.get('$boxName$_timestampKey');

    if (timestamp == null) {
      return false;
    }

    final cacheTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
    final now = DateTime.now();

    return now.difference(cacheTime) < cacheDuration;
  }

  @override
  Future<void> updateCacheTimestamp() async {
    final timestampBox = await _getTimestampBox();
    await timestampBox.put(
      '$boxName$_timestampKey',
      DateTime.now().millisecondsSinceEpoch,
    );
  }
}

/// A wrapper class for storing cached data with metadata.
class CachedData<T> {
  final T data;
  final DateTime cachedAt;
  final Duration validFor;

  CachedData({
    required this.data,
    required this.cachedAt,
    this.validFor = const Duration(hours: 1),
  });

  bool get isValid {
    return DateTime.now().difference(cachedAt) < validFor;
  }

  bool get isExpired => !isValid;

  factory CachedData.now(T data, {Duration validFor = const Duration(hours: 1)}) {
    return CachedData(
      data: data,
      cachedAt: DateTime.now(),
      validFor: validFor,
    );
  }
}
