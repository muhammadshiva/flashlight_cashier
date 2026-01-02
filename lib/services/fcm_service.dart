import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

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

  Stream<Map<String, dynamic>> get workOrderStream =>
      _workOrderController.stream;

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
    const androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
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

    if (data['type'] == 'new_work_order' ||
        data['type'] == 'work_order_update') {
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
      final dio = Dio();
      final response = await dio.put(
        '$baseUrl/api/users/$userId/fcm-token',
        options: Options(headers: {'Content-Type': 'application/json'}),
        data: {'fcmToken': _fcmToken},
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
