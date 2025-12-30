import 'package:hive_flutter/hive_flutter.dart';

import '../../../../core/cache/hive_config.dart';
import '../../../../core/cache/secure_local_storage.dart';
import '../../../../core/constants/app_constants.dart';
import '../../domain/entities/auth_entity.dart';

/// Abstract interface for local auth data operations.
///
/// This data source handles:
/// - Secure token storage (using flutter_secure_storage)
/// - User profile caching (using Hive)
/// - Cache validation and expiration
abstract class AuthLocalDataSource {
  /// Gets the cached auth token.
  Future<String?> getToken();

  /// Saves the auth token securely.
  Future<void> saveToken(String token);

  /// Gets the cached refresh token.
  Future<String?> getRefreshToken();

  /// Saves the refresh token securely.
  Future<void> saveRefreshToken(String token);

  /// Saves auth tokens (both access and refresh).
  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  });

  /// Clears all auth tokens.
  Future<void> clearTokens();

  /// Gets the cached user profile.
  Future<UserEntity?> getCachedUser();

  /// Caches the user profile.
  Future<void> cacheUser(UserEntity user);

  /// Clears the cached user.
  Future<void> clearCachedUser();

  /// Checks if the user cache is valid (not expired).
  Future<bool> isUserCacheValid();

  /// Clears all auth-related cache (tokens and user).
  Future<void> clearAll();

  /// Checks if user is authenticated (has valid token).
  Future<bool> isAuthenticated();
}

/// Implementation of [AuthLocalDataSource].
///
/// Uses:
/// - [SecureLocalStorage] for sensitive token storage
/// - [Hive] for user profile caching
class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SecureLocalStorage secureStorage;
  final Duration cacheValidDuration;

  static const String _userCacheKey = 'cached_user';
  static const String _cacheTimestampKey = 'auth_cache_timestamp';

  AuthLocalDataSourceImpl({
    required this.secureStorage,
    this.cacheValidDuration = const Duration(hours: 1),
  });

  /// Gets or opens the auth Hive box.
  Future<Box<dynamic>> _getAuthBox() async {
    if (Hive.isBoxOpen(HiveBoxNames.auth)) {
      return Hive.box(HiveBoxNames.auth);
    }
    return await Hive.openBox(HiveBoxNames.auth);
  }

  @override
  Future<String?> getToken() async {
    return await secureStorage.read(AppConstants.authTokenKey);
  }

  @override
  Future<void> saveToken(String token) async {
    await secureStorage.write(AppConstants.authTokenKey, token);
  }

  @override
  Future<String?> getRefreshToken() async {
    return await secureStorage.read(AppConstants.refreshTokenKey);
  }

  @override
  Future<void> saveRefreshToken(String token) async {
    await secureStorage.write(AppConstants.refreshTokenKey, token);
  }

  @override
  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    await Future.wait([
      saveToken(accessToken),
      saveRefreshToken(refreshToken),
    ]);
  }

  @override
  Future<void> clearTokens() async {
    await Future.wait([
      secureStorage.delete(AppConstants.authTokenKey),
      secureStorage.delete(AppConstants.refreshTokenKey),
    ]);
  }

  @override
  Future<UserEntity?> getCachedUser() async {
    final box = await _getAuthBox();
    return box.get(_userCacheKey) as UserEntity?;
  }

  @override
  Future<void> cacheUser(UserEntity user) async {
    final box = await _getAuthBox();
    await box.put(_userCacheKey, user);
    await _updateCacheTimestamp();
  }

  @override
  Future<void> clearCachedUser() async {
    final box = await _getAuthBox();
    await box.delete(_userCacheKey);
    await box.delete(_cacheTimestampKey);
  }

  @override
  Future<bool> isUserCacheValid() async {
    final box = await _getAuthBox();
    final timestamp = box.get(_cacheTimestampKey) as int?;

    if (timestamp == null) {
      return false;
    }

    final cachedTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
    final now = DateTime.now();

    return now.difference(cachedTime) < cacheValidDuration;
  }

  @override
  Future<void> clearAll() async {
    await Future.wait([
      clearTokens(),
      clearCachedUser(),
    ]);
  }

  @override
  Future<bool> isAuthenticated() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }

  /// Updates the cache timestamp to current time.
  Future<void> _updateCacheTimestamp() async {
    final box = await _getAuthBox();
    await box.put(_cacheTimestampKey, DateTime.now().millisecondsSinceEpoch);
  }
}

/// Mock implementation for testing.
class MockAuthLocalDataSource implements AuthLocalDataSource {
  String? _token;
  String? _refreshToken;
  UserEntity? _cachedUser;
  DateTime? _cacheTimestamp;
  final Duration _cacheValidDuration;

  MockAuthLocalDataSource({
    Duration cacheValidDuration = const Duration(hours: 1),
  }) : _cacheValidDuration = cacheValidDuration;

  @override
  Future<String?> getToken() async => _token;

  @override
  Future<void> saveToken(String token) async => _token = token;

  @override
  Future<String?> getRefreshToken() async => _refreshToken;

  @override
  Future<void> saveRefreshToken(String token) async => _refreshToken = token;

  @override
  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    _token = accessToken;
    _refreshToken = refreshToken;
  }

  @override
  Future<void> clearTokens() async {
    _token = null;
    _refreshToken = null;
  }

  @override
  Future<UserEntity?> getCachedUser() async => _cachedUser;

  @override
  Future<void> cacheUser(UserEntity user) async {
    _cachedUser = user;
    _cacheTimestamp = DateTime.now();
  }

  @override
  Future<void> clearCachedUser() async {
    _cachedUser = null;
    _cacheTimestamp = null;
  }

  @override
  Future<bool> isUserCacheValid() async {
    if (_cacheTimestamp == null) return false;
    return DateTime.now().difference(_cacheTimestamp!) < _cacheValidDuration;
  }

  @override
  Future<void> clearAll() async {
    await clearTokens();
    await clearCachedUser();
  }

  @override
  Future<bool> isAuthenticated() async {
    return _token != null && _token!.isNotEmpty;
  }
}
