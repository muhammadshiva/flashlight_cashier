# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

**flashlight_pos** is a Flutter-based Point of Sale (POS) application built with clean architecture patterns. The application supports cross-platform deployment (Android, iOS, Web, macOS, Linux, Windows) and implements modern Flutter development practices with BLoC state management.

## Development Commands

### Flutter Development
```bash
# Run the app
flutter run                    # Run on connected device/emulator
flutter run -d chrome          # Run on web
flutter run -d macos           # Run on macOS
flutter run -d android         # Run on Android
flutter run -d ios             # Run on iOS

# Build for production
flutter build apk             # Build Android APK
flutter build appbundle       # Build Android App Bundle
flutter build ios             # Build iOS
flutter build web             # Build for web
```

### Code Generation
```bash
# Generate code (freezed, json_serializable)
flutter packages pub run build_runner build
flutter packages pub run build_runner build --delete-conflicting-outputs  # Clean build
```

### Testing & Quality
```bash
flutter test                 # Run all tests
flutter test --coverage      # Run tests with coverage
flutter analyze              # Analyze code for issues
dart format .                # Format all code
```

## Architecture

### Clean Architecture Pattern
The project follows clean architecture with three distinct layers:

1. **Domain Layer** (`lib/features/*/domain/`): Business entities, use cases, repository interfaces
2. **Data Layer** (`lib/features/*/data/`): Repository implementations, data sources, models
3. **Presentation Layer** (`lib/features/*/presentation/`): BLoCs, pages, widgets

### Key Architecture Components
- **State Management**: BLoC pattern using `flutter_bloc`
- **Dependency Injection**: `get_it` service locator in `lib/injection_container.dart`
- **Navigation**: `go_router` configured in `lib/config/pages/app_pages.dart` with route constants in `lib/config/routes/app_routes.dart`
- **HTTP Client**: Custom `DioClient` in `lib/core/network/dio_client.dart` with Bearer token authentication interceptors
- **Error Handling**: Either monad (`dartz`) with custom failure types (`ServerFailure`, `CacheFailure`) in `lib/core/error/failures.dart`
- **Use Cases**: Abstract `UseCase<Type, Params>` base class in `lib/core/usecase/usecase.dart` returns `Either<Failure, Type>`
- **Screen Sizing**: `flutter_screenutil` with design size 1440x832 (configured in `lib/config/constans/app_const.dart`)

### Feature Structure
Each feature follows this pattern:
```
lib/features/feature_name/
├── domain/
│   ├── entities/
│   ├── usecases/
│   └── repositories/
├── data/
│   ├── models/
│   ├── datasources/
│   └── repositories/
└── presentation/
    ├── bloc/
    ├── pages/
    └── widgets/
```

## Key Files & Configuration

- `lib/injection_container.dart`: Dependency injection setup - register all BLoCs, use cases, repositories, and data sources here
- `lib/main.dart`: App entry point with `MaterialApp.router`, Indonesian localization, and global BLoC providers
- `lib/core/network/dio_client.dart`: HTTP client with automatic Bearer token injection from SharedPreferences
- `lib/config/pages/app_pages.dart`: GoRouter configuration with ShellRoute for persistent dashboard layout
- `lib/config/routes/app_routes.dart`: Centralized route path constants (use helper methods for parameterized routes)
- `lib/config/themes/`: Theme configuration including `app_colors.dart`
- `lib/core/usecase/usecase.dart`: Base use case abstraction
- `lib/core/widgets/session_timeout_listener.dart`: Global session timeout handling
- `pubspec.yaml`: Dependencies and asset configuration

## API Integration

- **Base URL**: `https://369820dfc74d.ngrok-free.app/api`
- **Authentication**: Bearer token-based with automatic injection
- **HTTP Client**: Dio with 15-second timeouts and error interceptors
- **Local Storage**: SharedPreferences for tokens and caching

## Features

The POS system includes modules for:
- **Authentication** (`auth/`): Login with token storage
- **Customer Management** (`customer/`): CRUD operations for customers
- **Memberships** (`membership/`): Customer membership tiers
- **Vehicle Management** (`vehicle/`): Vehicle registration and tracking
- **Service Catalog** (`service/`): Service offerings management
- **Product Catalog** (`product/`): Product inventory management
- **User Management** (`user/`): System user administration
- **Work Orders** (`work_order/`): Order processing and tracking
- **Dashboard** (`dashboard/`): Main dashboard with stats and work order overview
- **History** (`history/`): Work order history with BLoC pattern
- **Reports** (`report/`): Business analytics and reporting
- **POS** (`work_order/presentation/pages/pos_page.dart`): Point of sale interface

## Code Generation

This project uses code generation for:
- **Data Classes**: `freezed` for immutable models
- **JSON Serialization**: `json_serializable` for API serialization
- **Build Command**: `flutter packages pub run build_runner build`

## Testing

- **Framework**: Flutter Test framework
- **Structure**: Test files co-located with source files
- **Coverage**: Available via `flutter test --coverage`
- **Types**: Unit tests, widget tests, and integration tests

## Dependency Injection Pattern

When adding a new feature, follow this registration order in `lib/injection_container.dart`:

1. **BLoC** - Register as factory: `sl.registerFactory(() => FeatureBloc(...))`
2. **Use Cases** - Register as lazy singleton: `sl.registerLazySingleton(() => FeatureUseCase(sl()))`
3. **Repository** - Register interface as lazy singleton: `sl.registerLazySingleton<FeatureRepository>(() => FeatureRepositoryImpl(...))`
4. **Data Source** - Register as lazy singleton: `sl.registerLazySingleton<FeatureRemoteDataSource>(() => FeatureRemoteDataSourceImpl(dio: sl<DioClient>().dio))`

Note: Access the Dio instance via `sl<DioClient>().dio`, not `sl<Dio>()`.

## Navigation Patterns

The app uses GoRouter with two routing patterns:

1. **Shell Routes**: Dashboard and feature pages use `ShellRoute` for persistent `DashboardLayout` with sidebar navigation
2. **Standalone Routes**: Login and POS pages are outside the shell (full-screen)

When adding routes:
- Define path constants in `lib/config/routes/app_routes.dart`
- Configure routes in `lib/config/pages/app_pages.dart`
- Use `AppRoutes.routeName` for navigation: `context.go(AppRoutes.customers)`
- For parameterized routes, use helper methods: `context.go(AppRoutes.workOrderDetail('123'))`
- For passing complex objects, use `extra` parameter in GoRouter state

## BLoC Registration in Routes

Some pages need BLoC providers at the route level (not globally):
- **HistoryBloc**: Registered at `/work-orders` route with `LoadHistory()` event
- **DashboardBloc**: Registered at ShellRoute level with `LoadDashboardStats()` event
- **WorkOrderDetailBloc**: For work order detail pages

Global BLoCs (registered in `main.dart`):
- **AuthBloc**: Available throughout the app

## Development Notes

- **Code Generation**: Run after creating/modifying Freezed models or JSON serializable classes
- **API Integration**: All data sources should use `sl<DioClient>().dio` for automatic auth token injection
- **Use Cases**: Always return `Either<Failure, Type>` using the `dartz` package
- **BLoC Events**: Dispatch initial load events when creating BLoC providers in routes
- **Localization**: App is configured for Indonesian locale (`id_ID`)
- **Session Management**: `SessionTimeoutListener` wraps the dashboard shell to handle token expiration