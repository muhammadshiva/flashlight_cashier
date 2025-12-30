import 'dart:io';

/// Abstract interface for network connectivity checking.
/// This allows repositories to check connectivity before making API calls.
abstract class NetworkInfo {
  /// Returns true if the device has an active network connection.
  Future<bool> get isConnected;
}

/// Implementation of [NetworkInfo] that checks actual network connectivity.
/// Uses a simple DNS lookup to verify internet access.
class NetworkInfoImpl implements NetworkInfo {
  NetworkInfoImpl();

  @override
  Future<bool> get isConnected async {
    try {
      // Try to lookup a reliable DNS to verify actual internet connectivity
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    } catch (_) {
      return false;
    }
  }
}

/// A mock implementation for testing purposes.
/// Always returns the configured connectivity state.
class MockNetworkInfo implements NetworkInfo {
  final bool _isConnected;

  MockNetworkInfo({bool isConnected = true}) : _isConnected = isConnected;

  @override
  Future<bool> get isConnected async => _isConnected;
}
