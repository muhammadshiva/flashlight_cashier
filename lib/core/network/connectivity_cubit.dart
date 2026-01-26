import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum ConnectivityStatus { connected, disconnected }

class ConnectivityCubit extends Cubit<ConnectivityStatus> {
  final Connectivity _connectivity;
  StreamSubscription<List<ConnectivityResult>>? _subscription;

  ConnectivityCubit({Connectivity? connectivity})
      : _connectivity = connectivity ?? Connectivity(),
        super(ConnectivityStatus.connected) {
    _init();
  }

  Future<void> _init() async {
    // Check initial connectivity first
    try {
      final results = await _connectivity.checkConnectivity();
      _updateStatus(results);
    } catch (_) {
      // Keep connected state on error (optimistic)
    }

    // Then subscribe to connectivity changes
    _subscription = _connectivity.onConnectivityChanged.listen(_updateStatus);
  }

  void _updateStatus(List<ConnectivityResult> results) {
    // Only consider disconnected if explicitly [ConnectivityResult.none]
    final isDisconnected = results.isNotEmpty &&
        results.length == 1 &&
        results.first == ConnectivityResult.none;

    if (isDisconnected) {
      emit(ConnectivityStatus.disconnected);
    } else if (results.any((r) => r != ConnectivityResult.none)) {
      emit(ConnectivityStatus.connected);
    }
    // If results is empty, keep current state (don't change)
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
