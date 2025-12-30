import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// A [BlocObserver] that logs all BLoC lifecycle events and state changes.
///
/// This observer provides comprehensive logging for debugging purposes:
/// - BLoC creation and disposal
/// - Event dispatching
/// - State transitions
/// - Errors
///
/// Only logs in debug mode to avoid performance overhead in production.
class AppBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    _log('onCreate', bloc.runtimeType.toString());
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    _log('onEvent', '${bloc.runtimeType} | Event: ${event.runtimeType}');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    _log(
      'onChange',
      '${bloc.runtimeType}\n'
          '  Current State: ${change.currentState.runtimeType}\n'
          '  Next State: ${change.nextState.runtimeType}',
    );
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    _log(
      'onTransition',
      '${bloc.runtimeType}\n'
          '  Event: ${transition.event.runtimeType}\n'
          '  Current State: ${transition.currentState.runtimeType}\n'
          '  Next State: ${transition.nextState.runtimeType}',
    );
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    _logError('onError', '${bloc.runtimeType}', error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    _log('onClose', bloc.runtimeType.toString());
  }

  void _log(String event, String message) {
    if (kDebugMode) {
      debugPrint('[BLoC] $event: $message');
    }
  }

  void _logError(
    String event,
    String blocType,
    Object error,
    StackTrace stackTrace,
  ) {
    if (kDebugMode) {
      debugPrint('[BLoC ERROR] $event: $blocType');
      debugPrint('  Error: $error');
      debugPrint('  StackTrace:\n$stackTrace');
    }
  }
}
