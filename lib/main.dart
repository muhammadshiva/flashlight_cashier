import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'app.dart';
import 'configs/injector/injector_config.dart';
import 'core/cache/hive_config.dart';
import 'flavors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  F.appFlavor = Flavor.values.firstWhere(
    (element) => element.name == appFlavor,
  );

  // Initialize Hive for local caching
  await HiveConfig.init();

  // Initialize HydratedBloc storage for state persistence
  final storageDirectory = await getApplicationDocumentsDirectory();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: storageDirectory,
  );

  // Initialize dependency injection
  await configureDependencies();

  // Setup BLoC observer for logging all state changes
  Bloc.observer = sl<BlocObserver>();

  runApp(const App());
}
