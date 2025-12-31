import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'config/constans/app_const.dart';
import 'config/pages/app_pages.dart';
import 'config/themes/app_colors.dart';
import 'configs/injector/injector_config.dart';
import 'core/cache/hive_config.dart';
import 'shared/widgets/draggable_button.dart';
// import 'core/utils/app_bloc_observer.dart'; // Removed custom observer
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/theme/presentation/bloc/theme_bloc.dart';
import 'features/theme/presentation/bloc/theme_state.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

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

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<AuthBloc>()),
        BlocProvider(create: (_) => ThemeBloc()),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, themeState) {
          return ScreenUtilInit(
            designSize: AppConst.size,
            minTextAdapt: true,
            splitScreenMode: true,
            useInheritedMediaQuery: true,
            builder: (context, child) {
              return MaterialApp.router(
                title: 'Flashlight POS',
                debugShowCheckedModeBanner: false,
                themeMode: themeState.themeMode,
                theme: ThemeData(
                  colorScheme: ColorScheme.fromSeed(
                    seedColor: AppColors.backgroundGrey6,
                    brightness: Brightness.light,
                  ),
                  useMaterial3: true,
                ),
                darkTheme: ThemeData(
                  colorScheme: ColorScheme.fromSeed(
                    seedColor: AppColors.backgroundGrey6,
                    brightness: Brightness.dark,
                  ),
                  useMaterial3: true,
                ),
                routerConfig: AppPages.router,
                locale: const Locale('id', 'ID'),
                supportedLocales: const [
                  Locale('id', 'ID'),
                ],
                localizationsDelegates: const [
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                builder: (context, child) {
                  return _AppWrapper(child: child);
                },
              );
            },
          );
        },
      ),
    );
  }
}

/// App wrapper that adds flavor banners and debug button
class _AppWrapper extends StatelessWidget {
  final Widget? child;

  const _AppWrapper({this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      if (child != null) child!,
      const DebugButton(),
    ]);
  }
}
