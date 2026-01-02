# Flutter FCM Integration Guide

This guide provides step-by-step instructions for integrating Firebase Cloud Messaging (FCM) in your Flutter POS application to receive real-time notifications when new work orders are created from the kiosk.

## Prerequisites

- Firebase project created with service account credentials
- Backend already configured with FCM (see backend implementation)
- Flutter project set up

## 1. Add Firebase Dependencies

Add the following dependencies to your `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter

  # Firebase dependencies
  firebase_core: ^3.10.0
  firebase_messaging: ^15.1.5

  # Local notifications (for foreground notifications)
  flutter_local_notifications: ^18.0.1

  # HTTP client (for API calls)
  http: ^1.2.2
```

Then run:
```bash
flutter pub get
```

## 2. Firebase Configuration

### Android Setup

1. Download `google-services.json` from Firebase Console
2. Place it in `android/app/` directory
3. Update `android/build.gradle`:

```gradle
buildscript {
    dependencies {
        // Add this line
        classpath 'com.google.gms:google-services:4.4.0'
    }
}
```

4. Update `android/app/build.gradle`:

```gradle
// Add at the top
plugins {
    id "com.android.application"
    id "kotlin-android"
    id "dev.flutter.flutter-gradle-plugin"
    id 'com.google.gms.google-services'  // Add this
}

android {
    defaultConfig {
        // ... existing config
        minSdkVersion 21  // FCM requires min SDK 21
    }
}

dependencies {
    implementation 'com.google.firebase:firebase-messaging:23.4.0'
}
```

5. Update `android/app/src/main/AndroidManifest.xml`:

```xml
<manifest>
    <application>
        <!-- ... existing config ... -->

        <!-- FCM default channel -->
        <meta-data
            android:name="com.google.firebase.messaging.default_notification_channel_id"
            android:value="work_orders_channel" />

        <!-- FCM service -->
        <service
            android:name="com.google.firebase.messaging.FirebaseMessagingService"
            android:exported="false">
            <intent-filter>
                <action android:name="com.google.firebase.MESSAGING_EVENT" />
            </intent-filter>
        </service>
    </application>

    <!-- Permissions -->
    <uses-permission android:name="android.permission.INTERNET"/>
    <uses-permission android:name="android.permission.POST_NOTIFICATIONS"/>
</manifest>
```

### iOS Setup

1. Download `GoogleService-Info.plist` from Firebase Console
2. Place it in `ios/Runner/` directory (drag it into Xcode)
3. Add Firebase SDK in `ios/Podfile`:

```ruby
target 'Runner' do
  use_frameworks!
  use_modular_headers!

  flutter_install_all_ios_pods File.dirname(File.realpath(__FILE__))

  # Add Firebase pod
  pod 'Firebase/Messaging'
end
```

4. Run:
```bash
cd ios
pod install
```

5. Enable push notifications in Xcode:
   - Open `ios/Runner.xcworkspace`
   - Select Runner project → Signing & Capabilities
   - Click "+ Capability" and add "Push Notifications"
   - Add "Background Modes" and check "Remote notifications"

## 3. Flutter Implementation

### 3.1 Create FCM Service

Create `lib/services/fcm_service.dart`:

```dart
import 'dart:async';
import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;

class FCMService {
  static final FCMService _instance = FCMService._internal();
  factory FCMService() => _instance;
  FCMService._internal();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  // Stream controller for work order updates
  final StreamController<Map<String, dynamic>> _workOrderController =
      StreamController<Map<String, dynamic>>.broadcast();

  Stream<Map<String, dynamic>> get workOrderStream => _workOrderController.stream;

  String? _fcmToken;
  String? get fcmToken => _fcmToken;

  // Initialize FCM
  Future<void> initialize() async {
    // Request permission (iOS)
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );

    if (settings.authorizationStatus == AuthorizationStatus.denied) {
      print('User declined FCM permissions');
      return;
    }

    // Initialize local notifications
    await _initializeLocalNotifications();

    // Get FCM token
    _fcmToken = await _firebaseMessaging.getToken();
    print('FCM Token: $_fcmToken');

    // Listen to token refresh
    _firebaseMessaging.onTokenRefresh.listen((newToken) {
      _fcmToken = newToken;
      print('FCM Token refreshed: $newToken');
      // TODO: Update token in backend
    });

    // Configure message handlers
    _configureMessageHandlers();
  }

  // Initialize local notifications
  Future<void> _initializeLocalNotifications() async {
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
    );

    const settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _localNotifications.initialize(
      settings,
      onDidReceiveNotificationResponse: _onNotificationTapped,
    );

    // Create Android notification channel
    const androidChannel = AndroidNotificationChannel(
      'work_orders_channel',
      'Work Orders',
      description: 'Notifications for new work orders',
      importance: Importance.high,
      playSound: true,
    );

    await _localNotifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(androidChannel);
  }

  // Configure FCM message handlers
  void _configureMessageHandlers() {
    // Foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Foreground message: ${message.data}');
      _handleMessage(message);
      _showLocalNotification(message);
    });

    // Background messages (when app is in background but not terminated)
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Message opened app: ${message.data}');
      _handleMessage(message);
    });

    // Check if app was opened from a terminated state
    _firebaseMessaging.getInitialMessage().then((RemoteMessage? message) {
      if (message != null) {
        print('App opened from terminated state: ${message.data}');
        _handleMessage(message);
      }
    });
  }

  // Handle incoming message
  void _handleMessage(RemoteMessage message) {
    final data = message.data;

    if (data['type'] == 'new_work_order' || data['type'] == 'work_order_update') {
      _workOrderController.add(data);
    }
  }

  // Show local notification for foreground messages
  Future<void> _showLocalNotification(RemoteMessage message) async {
    final notification = message.notification;
    final data = message.data;

    if (notification == null) return;

    const androidDetails = AndroidNotificationDetails(
      'work_orders_channel',
      'Work Orders',
      channelDescription: 'Notifications for new work orders',
      importance: Importance.high,
      priority: Priority.high,
      playSound: true,
      icon: '@mipmap/ic_launcher',
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _localNotifications.show(
      notification.hashCode,
      notification.title,
      notification.body,
      details,
      payload: jsonEncode(data),
    );
  }

  // Handle notification tap
  void _onNotificationTapped(NotificationResponse response) {
    if (response.payload != null) {
      final data = jsonDecode(response.payload!);
      _workOrderController.add(data);
    }
  }

  // Register FCM token with backend
  Future<bool> registerToken(String userId, String baseUrl) async {
    if (_fcmToken == null) {
      print('FCM token not available');
      return false;
    }

    try {
      final response = await http.put(
        Uri.parse('$baseUrl/api/users/$userId/fcm-token'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'fcmToken': _fcmToken}),
      );

      if (response.statusCode == 200) {
        print('FCM token registered successfully');
        return true;
      } else {
        print('Failed to register FCM token: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Error registering FCM token: $e');
      return false;
    }
  }

  // Dispose
  void dispose() {
    _workOrderController.close();
  }
}

// Background message handler (must be top-level function)
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Background message: ${message.data}');
}
```

### 3.2 Update Main.dart

Update your `lib/main.dart`:

```dart
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'services/fcm_service.dart';

// Background message handler
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling background message: ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp();

  // Register background message handler
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // Initialize FCM service
  await FCMService().initialize();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'POS App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(), // Your login screen
    );
  }
}
```

### 3.3 Register FCM Token After Login

In your login screen or auth service:

```dart
import 'services/fcm_service.dart';

class AuthService {
  static const String BASE_URL = 'http://your-backend-url:8080';

  Future<void> login(String username, String password) async {
    // Your existing login logic
    final response = await http.post(
      Uri.parse('$BASE_URL/api/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final userId = data['data']['user']['id'];

      // Register FCM token
      await FCMService().registerToken(userId, BASE_URL);
    }
  }
}
```

### 3.4 Listen to Work Order Notifications

In your POS screen:

```dart
import 'package:flutter/material.dart';
import 'dart:async';
import 'services/fcm_service.dart';

class POSScreen extends StatefulWidget {
  @override
  _POSScreenState createState() => _POSScreenState();
}

class _POSScreenState extends State<POSScreen> {
  StreamSubscription? _workOrderSubscription;
  List<Map<String, dynamic>> _workOrders = [];

  @override
  void initState() {
    super.initState();
    _listenToWorkOrders();
  }

  void _listenToWorkOrders() {
    _workOrderSubscription = FCMService().workOrderStream.listen((data) {
      print('New work order received: $data');

      setState(() {
        _workOrders.insert(0, data);
      });

      // Show a snackbar or dialog
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('New work order: ${data['queueNumber']}'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 5),
          action: SnackBarAction(
            label: 'View',
            textColor: Colors.white,
            onPressed: () {
              // Navigate to work order details
              _viewWorkOrder(data['workOrderId']);
            },
          ),
        ),
      );

      // Refresh work order list
      _refreshWorkOrders();
    });
  }

  Future<void> _refreshWorkOrders() async {
    // Fetch updated work orders from API
    // Your existing logic
  }

  void _viewWorkOrder(String workOrderId) {
    // Navigate to work order details screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WorkOrderDetailsScreen(workOrderId: workOrderId),
      ),
    );
  }

  @override
  void dispose() {
    _workOrderSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('POS - Work Orders'),
      ),
      body: ListView.builder(
        itemCount: _workOrders.length,
        itemBuilder: (context, index) {
          final order = _workOrders[index];
          return ListTile(
            title: Text('Queue: ${order['queueNumber']}'),
            subtitle: Text('Order: ${order['workOrderCode']}'),
            trailing: Chip(
              label: Text(order['status'] ?? 'created'),
            ),
            onTap: () => _viewWorkOrder(order['workOrderId']),
          );
        },
      ),
    );
  }
}
```

## 4. Backend Setup

### 4.1 Place Firebase Credentials

1. Download your Firebase Admin SDK private key from Firebase Console:
   - Go to Project Settings → Service Accounts
   - Click "Generate New Private Key"
   - Save as `firebase-credentials.json`

2. Place the file in your backend project root:
   ```
   flashlight-project/
   ├── firebase-credentials.json  ← Place here
   ├── main.go
   ├── .env
   └── ...
   ```

3. Get your Firebase Project ID:
   - Go to Firebase Console → Project Settings
   - Copy the "Project ID" (e.g., `flashlight-project-12345`)

4. Update `.env` with Firebase configuration:
   ```env
   # Firebase Configuration
   FIREBASE_CREDENTIALS_PATH=./firebase-credentials.json
   FIREBASE_PROJECT_ID=your-firebase-project-id
   ```

   Replace `your-firebase-project-id` with your actual Firebase Project ID.

### 4.2 Add to .gitignore

Add to your `.gitignore`:
```
firebase-credentials.json
```

## 5. Testing

### Test FCM Token Registration

1. Run your Flutter app
2. Login with a cashier or admin account
3. Check backend logs for:
   ```
   ✓ Firebase Cloud Messaging initialized successfully
   ```
4. Check Flutter logs for:
   ```
   FCM Token: [your-token]
   FCM token registered successfully
   ```

### Test Notifications

1. Create a work order from kiosk app or Postman
2. Check backend logs:
   ```
   Successfully sent notification to N POS devices
   ```
3. Flutter app should:
   - Show local notification (if in foreground)
   - Update work order list
   - Show snackbar with new order info

### Test with Postman

You can manually test FCM by calling:

**Endpoint:** `PUT http://localhost:8080/api/users/:userId/fcm-token`

**Headers:**
```
Content-Type: application/json
```

**Body:**
```json
{
  "fcmToken": "your-test-token-here"
}
```

## 6. Troubleshooting

### Android Issues

1. **Notifications not showing in foreground:**
   - Ensure `flutter_local_notifications` is properly configured
   - Check notification channel is created

2. **No FCM token:**
   - Check `google-services.json` is in correct location
   - Verify `minSdkVersion` is at least 21
   - Check internet permission in AndroidManifest

3. **Background notifications not working:**
   - Ensure background message handler is registered before `runApp()`
   - Check battery optimization settings on device

### iOS Issues

1. **No notifications:**
   - Verify push notification capability is enabled in Xcode
   - Check `GoogleService-Info.plist` is in correct location
   - Request permission with proper settings

2. **Token not generated:**
   - Test on real device (simulator doesn't support APNS)
   - Check APNS certificate in Firebase Console

### Backend Issues

1. **FCM initialization failed:**
   - Verify `firebase-credentials.json` path is correct
   - Check file has proper JSON format
   - Ensure file has read permissions

2. **Notifications not sent:**
   - Check users have FCM tokens in database
   - Verify token hasn't expired (refresh token periodically)
   - Check Firebase project has FCM API enabled

## 7. Best Practices

1. **Handle token refresh:**
   - Update backend when token refreshes
   - Implement retry logic for failed updates

2. **Notification channels:**
   - Use different channels for different notification types
   - Allow users to customize notification preferences

3. **Battery optimization:**
   - Inform users to disable battery optimization for your app
   - Use topics for broadcast messages instead of individual tokens

4. **Security:**
   - Never commit `firebase-credentials.json` to version control
   - Use environment variables for sensitive config
   - Validate FCM tokens before storing

5. **Error handling:**
   - Log all FCM errors for debugging
   - Implement graceful degradation if FCM is unavailable
   - Show fallback UI for non-real-time updates

## 8. Additional Features

### Subscribe to Topics

For broadcasting to all POS devices:

```dart
// Subscribe to topic
await FirebaseMessaging.instance.subscribeToTopic('pos_notifications');

// Backend - send to topic
err := services.SendNotificationToTopic(
    "pos_notifications",
    "System Update",
    "New features available",
    map[string]string{"type": "system_update"},
)
```

### Custom Notification Sound

1. Add sound file to `android/app/src/main/res/raw/notification.mp3`
2. Update notification:

```dart
const androidDetails = AndroidNotificationDetails(
  'work_orders_channel',
  'Work Orders',
  sound: RawResourceAndroidNotificationSound('notification'),
);
```

### Badge Count (iOS)

```dart
await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
  alert: true,
  badge: true,
  sound: true,
);
```

## Summary

You now have a complete FCM implementation that:
- ✓ Sends real-time notifications from backend to Flutter POS app
- ✓ Handles foreground, background, and terminated states
- ✓ Shows local notifications with custom UI
- ✓ Manages FCM token registration and refresh
- ✓ Supports both Android and iOS

The POS app will now receive instant notifications whenever a new work order is created from the kiosk!
