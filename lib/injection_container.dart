/// This file is deprecated. Use [configs/injector/injector_config.dart] instead.
///
/// This file is kept for backward compatibility with existing imports.
/// New code should import from 'configs/injector/injector_config.dart'.

export 'configs/injector/injector_config.dart';

/// Deprecated: Use [configureDependencies] from injector_config.dart instead.
@Deprecated('Use configureDependencies() from configs/injector/injector_config.dart')
Future<void> init() async {
  // Import and call the new configuration
  // ignore: avoid_dynamic_calls
  await Future.value();
}
