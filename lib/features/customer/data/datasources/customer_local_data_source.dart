import 'package:hive_flutter/hive_flutter.dart';

import '../../../../core/cache/hive_config.dart';
import '../../domain/entities/customer.dart';

/// Abstract interface for local customer data operations.
///
/// This data source handles customer caching using Hive.
/// Supports cache validation with TTL-based expiration.
abstract class CustomerLocalDataSource {
  /// Gets all cached customers.
  Future<List<Customer>> getCachedCustomers();

  /// Gets a single cached customer by ID.
  Future<Customer?> getCachedCustomer(String id);

  /// Caches a list of customers.
  Future<void> cacheCustomers(List<Customer> customers);

  /// Caches a single customer.
  Future<void> cacheCustomer(Customer customer);

  /// Removes a customer from cache.
  Future<void> removeCustomer(String id);

  /// Clears all cached customers.
  Future<void> clearCache();

  /// Checks if the customer cache is valid (not expired).
  Future<bool> isCacheValid();

  /// Updates the cache timestamp.
  Future<void> updateCacheTimestamp();

  /// Gets the last cache update timestamp.
  Future<DateTime?> getLastCacheTime();
}

/// Implementation of [CustomerLocalDataSource] using Hive.
///
/// Provides local caching for customers with TTL support.
class CustomerLocalDataSourceImpl implements CustomerLocalDataSource {
  final Duration cacheValidDuration;

  static const String _cacheTimestampKey = 'customers_cache_timestamp';

  CustomerLocalDataSourceImpl({
    this.cacheValidDuration = const Duration(hours: 1),
  });

  /// Gets or opens the customers Hive box.
  Future<Box<Customer>> _getCustomersBox() async {
    if (Hive.isBoxOpen(HiveBoxNames.customers)) {
      return Hive.box<Customer>(HiveBoxNames.customers);
    }
    return await Hive.openBox<Customer>(HiveBoxNames.customers);
  }

  /// Gets the timestamp box for cache metadata.
  Future<Box<int>> _getTimestampBox() async {
    if (Hive.isBoxOpen(HiveBoxNames.cacheTimestamps)) {
      return Hive.box<int>(HiveBoxNames.cacheTimestamps);
    }
    return await Hive.openBox<int>(HiveBoxNames.cacheTimestamps);
  }

  @override
  Future<List<Customer>> getCachedCustomers() async {
    final box = await _getCustomersBox();
    return box.values.toList();
  }

  @override
  Future<Customer?> getCachedCustomer(String id) async {
    final box = await _getCustomersBox();
    return box.get(id);
  }

  @override
  Future<void> cacheCustomers(List<Customer> customers) async {
    final box = await _getCustomersBox();

    // Create a map of customer ID to customer
    final customerMap = <String, Customer>{
      for (final customer in customers) customer.id: customer
    };

    await box.putAll(customerMap);
    await updateCacheTimestamp();
  }

  @override
  Future<void> cacheCustomer(Customer customer) async {
    final box = await _getCustomersBox();
    await box.put(customer.id, customer);
  }

  @override
  Future<void> removeCustomer(String id) async {
    final box = await _getCustomersBox();
    await box.delete(id);
  }

  @override
  Future<void> clearCache() async {
    final box = await _getCustomersBox();
    await box.clear();

    // Also clear the timestamp
    final timestampBox = await _getTimestampBox();
    await timestampBox.delete(_cacheTimestampKey);
  }

  @override
  Future<bool> isCacheValid() async {
    final lastCacheTime = await getLastCacheTime();

    if (lastCacheTime == null) {
      return false;
    }

    final now = DateTime.now();
    return now.difference(lastCacheTime) < cacheValidDuration;
  }

  @override
  Future<void> updateCacheTimestamp() async {
    final timestampBox = await _getTimestampBox();
    await timestampBox.put(
      _cacheTimestampKey,
      DateTime.now().millisecondsSinceEpoch,
    );
  }

  @override
  Future<DateTime?> getLastCacheTime() async {
    final timestampBox = await _getTimestampBox();
    final timestamp = timestampBox.get(_cacheTimestampKey);

    if (timestamp == null) {
      return null;
    }

    return DateTime.fromMillisecondsSinceEpoch(timestamp);
  }
}

/// Mock implementation for testing.
class MockCustomerLocalDataSource implements CustomerLocalDataSource {
  final Map<String, Customer> _cache = {};
  DateTime? _cacheTimestamp;
  final Duration _cacheValidDuration;

  MockCustomerLocalDataSource({
    Duration cacheValidDuration = const Duration(hours: 1),
  }) : _cacheValidDuration = cacheValidDuration;

  @override
  Future<List<Customer>> getCachedCustomers() async {
    return _cache.values.toList();
  }

  @override
  Future<Customer?> getCachedCustomer(String id) async {
    return _cache[id];
  }

  @override
  Future<void> cacheCustomers(List<Customer> customers) async {
    for (final customer in customers) {
      _cache[customer.id] = customer;
    }
    _cacheTimestamp = DateTime.now();
  }

  @override
  Future<void> cacheCustomer(Customer customer) async {
    _cache[customer.id] = customer;
  }

  @override
  Future<void> removeCustomer(String id) async {
    _cache.remove(id);
  }

  @override
  Future<void> clearCache() async {
    _cache.clear();
    _cacheTimestamp = null;
  }

  @override
  Future<bool> isCacheValid() async {
    if (_cacheTimestamp == null) return false;
    return DateTime.now().difference(_cacheTimestamp!) < _cacheValidDuration;
  }

  @override
  Future<void> updateCacheTimestamp() async {
    _cacheTimestamp = DateTime.now();
  }

  @override
  Future<DateTime?> getLastCacheTime() async {
    return _cacheTimestamp;
  }
}
