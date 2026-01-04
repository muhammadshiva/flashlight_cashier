import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'config/constans/app_const.dart';
import 'config/pages/app_pages.dart';
import 'config/themes/app_colors.dart';
import 'configs/injector/injector_config.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/settings/presentation/bloc/settings_bloc.dart';
import 'features/theme/presentation/bloc/theme_bloc.dart';
import 'features/theme/presentation/bloc/theme_state.dart';
import 'flavors.dart';
import 'shared/widgets/draggable_button.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<AuthBloc>()),
        BlocProvider(create: (_) => ThemeBloc()),
        BlocProvider(
          create: (_) => sl<SettingsBloc>()..add(const LoadSettings()),
        ),
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
                title: F.title,
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
      if (kDebugMode) // Only show banner in debug mode if needed, utilizing F.name
        Banner(
          message: F.name,
          location: BannerLocation.topEnd,
          color: Colors.red.withValues(alpha: 0.6), // Adjust color as needed
          child: child ?? const SizedBox.shrink(),
        )
      else if (child != null)
        child!,
      const DebugButton(),
    ]);
  }
}
