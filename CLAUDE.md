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
- **Navigation**: `go_router` configured in `lib/config/routes.dart`
- **HTTP Client**: Custom `DioClient` with authentication interceptors
- **Error Handling**: Custom failure types in `lib/core/error/failures.dart`

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

- `lib/injection_container.dart`: Dependency injection setup
- `lib/core/network/dio_client.dart`: HTTP client configuration
- `lib/config/routes.dart`: Navigation routing configuration
- `pubspec.yaml`: Dependencies and project configuration
- `analysis_options.yaml`: Linting rules and code standards

## API Integration

- **Base URL**: `https://369820dfc74d.ngrok-free.app/api`
- **Authentication**: Bearer token-based with automatic injection
- **HTTP Client**: Dio with 15-second timeouts and error interceptors
- **Local Storage**: SharedPreferences for tokens and caching

## Features

The POS system includes modules for:
- Authentication (`auth/`)
- Customer management (`customer/`)
- Memberships (`membership/`)
- Vehicle management (`vehicle/`)
- Service catalog (`service/`)
- Product catalog (`product/`)
- Work orders and POS (`work_order/`)
- Dashboard (`work_order/presentation/pages/pos_page.dart`)

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

## Development Notes

- When adding new models, run code generation after creating the class
- All BLoCs should be registered in the injection container
- API calls should use the DioClient for consistent error handling
- Navigation should use the GoRouter configuration
- Follow the established clean architecture layering for new features