# Flutter Flavorizr Setup Guide

## Current Status

The project has been configured with `flutter_flavorizr` package and all manual flavor configurations have been set up. However, `flutter_flavorizr` requires an interactive terminal to complete the automated setup.

## What's Already Configured

### ✅ Completed Setup

1. **Package Installation**: `flutter_flavorizr: ^2.2.3` added to `pubspec.yaml`
2. **Flavorizr Configuration**: Full flavor configuration added to `pubspec.yaml` with:
   - 3 flavors: dev, staging, production
   - App names and bundle IDs for each flavor
   - VS Code IDE integration

3. **Manual Flavor Files Created**:
   - ✅ `lib/flavors.dart` - Flavor configuration class
   - ✅ `lib/main.dart` - Updated with flavor initialization and banner
   - ✅ `lib/core/network/dio_client.dart` - Using FlavorConfig for API URLs
   - ✅ Android build.gradle.kts - Product flavors configured
   - ✅ AndroidManifest.xml - Dynamic app name
   - ✅ iOS XCConfig files (6 files)
   - ✅ iOS scheme files (3 schemes)
   - ✅ iOS Info.plist - Dynamic configuration
   - ✅ .vscode/launch.json - Debug configurations

## Option 1: Run Flutter Flavorizr (Recommended)

Since you have access to a terminal, you can run `flutter_flavorizr` to automatically generate/verify all configurations:

```bash
# Navigate to project directory
cd "/Users/muhammadshiva/Work/Matariza V2/flashlight_pos"

# Run flutter_flavorizr
flutter pub run flutter_flavorizr
```

When prompted "Do you want to proceed? (Y/n)", type **Y** and press Enter.

### What flutter_flavorizr Will Do:

- ✅ Update Android configurations
- ✅ Update iOS configurations (Podfile, XCConfig, Schemes, Plists)
- ✅ Generate Flutter flavor files
- ✅ Create VS Code launch configurations
- ✅ Generate app icons per flavor (if configured)
- ✅ Update main.dart with flavor support

**Note**: flutter_flavorizr may overwrite the manually created files, which is expected and desired.

## Option 2: Use Existing Manual Setup

The manual setup is already complete and functional. You can start using flavors immediately:

### Running Different Flavors

#### Command Line:
```bash
# Development
flutter run --flavor dev --dart-define=FLAVOR=dev

# Staging
flutter run --flavor staging --dart-define=FLAVOR=staging

# Production
flutter run --flavor production --dart-define=FLAVOR=production
```

#### VS Code:
1. Go to **Run and Debug** panel (Cmd+Shift+D)
2. Select from dropdown:
   - "dev Debug"
   - "staging Debug"
   - "production Debug"
3. Press F5 or click the green play button

### Building for Release

```bash
# Android APK
flutter build apk --flavor dev --dart-define=FLAVOR=dev
flutter build apk --flavor staging --dart-define=FLAVOR=staging
flutter build apk --flavor production --dart-define=FLAVOR=production

# Android App Bundle
flutter build appbundle --flavor production --dart-define=FLAVOR=production

# iOS
flutter build ios --flavor dev --dart-define=FLAVOR=dev
flutter build ios --flavor production --dart-define=FLAVOR=production
```

## iOS Xcode Setup

After running flutter_flavorizr OR if using manual setup, you need to configure Xcode:

1. Open `ios/Runner.xcodeproj` in Xcode
2. Select **Runner** project in left panel
3. Go to **Info** tab
4. Under **Configurations**, click the **+** button to add:
   - `Debug-dev` (based on Debug)
   - `Release-dev` (based on Release)
   - `Debug-staging` (based on Debug)
   - `Release-staging` (based on Release)
   - `Debug-production` (based on Debug)
   - `Release-production` (based on Release)

5. For each configuration, set the **Based on configuration file**:
   - `Debug-dev` → `Dev-Debug.xcconfig`
   - `Release-dev` → `Dev-Release.xcconfig`
   - `Debug-staging` → `Staging-Debug.xcconfig`
   - `Release-staging` → `Staging-Release.xcconfig`
   - `Debug-production` → `Production-Debug.xcconfig`
   - `Release-production` → `Production-Release.xcconfig`

6. Select **Pods** project → Repeat steps 3-5 for Pods target

7. Run CocoaPods:
   ```bash
   cd ios && pod install && cd ..
   ```

## Customizing API URLs

Update `lib/flavors.dart` to set different API URLs for each flavor:

```dart
switch (flavorString) {
  case 'dev':
    _flavor = Flavor.dev;
    _baseUrl = 'https://dev-api.matariza.com/api'; // Dev API
    _bannerColor = Colors.green;
    break;
  case 'staging':
    _flavor = Flavor.staging;
    _baseUrl = 'https://staging-api.matariza.com/api'; // Staging API
    _bannerColor = Colors.orange;
    break;
  case 'production':
  default:
    _flavor = Flavor.production;
    _baseUrl = 'https://api.matariza.com/api'; // Production API
    _bannerColor = Colors.red;
    break;
}
```

## Adding App Icons Per Flavor

To add custom app icons for each flavor:

1. Add icon files to `pubspec.yaml` under flavorizr configuration:

```yaml
flavorizr:
  app:
    android:
      flavorDimensions: "flavor-type"
    ios:
      buildSettings:
        VERSIONING_SYSTEM: "apple-generic"

  flavors:
    dev:
      app:
        name: "Flashlight Kiosk Dev"
      android:
        applicationId: "id.flashlight.dev"
        icon: "assets/icons/dev_icon.png"  # Add this
      ios:
        bundleId: "id.flashlight.dev"
        icon: "assets/icons/dev_icon.png"  # Add this
```

2. Run `flutter pub run flutter_flavorizr` again to generate icons

## Troubleshooting

### Issue: "No flavor dimension specified"
**Solution**: Ensure you're using the `--flavor` flag when running:
```bash
flutter run --flavor dev --dart-define=FLAVOR=dev
```

### Issue: iOS build fails with "No such module"
**Solution**: Run pod install:
```bash
cd ios && pod deintegrate && pod install && cd ..
```

### Issue: Wrong flavor is running
**Solution**: Clean and rebuild:
```bash
flutter clean
flutter pub get
cd ios && pod install && cd ..
flutter run --flavor dev --dart-define=FLAVOR=dev
```

### Issue: Flavor banner not showing
**Solution**: Check that:
1. FlavorConfig is initialized in main.dart
2. `--dart-define=FLAVOR=dev` is passed (not production)
3. `FlavorConfig.instance.showBanner` returns true

## Verification

To verify your flavor setup is working:

1. Run the dev flavor:
   ```bash
   flutter run --flavor dev --dart-define=FLAVOR=dev
   ```

2. You should see:
   - A green "DEV" banner in the top-right corner
   - App name: "Flashlight Kiosk Dev"
   - Bundle ID: `id.flashlight.dev` (Android/iOS)

3. Check the logs to confirm the correct API URL is being used

## Next Steps

1. ✅ Run `flutter pub run flutter_flavorizr` (if desired)
2. ✅ Configure Xcode build configurations
3. ✅ Run `pod install` in iOS folder
4. ✅ Update API URLs in `lib/flavors.dart`
5. ✅ Test each flavor on Android and iOS
6. ✅ (Optional) Add custom app icons per flavor
7. ✅ Update FLUTTER_SETUP.md documentation with flavor instructions
