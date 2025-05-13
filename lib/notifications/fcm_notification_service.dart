import 'package:firebase_messaging/firebase_messaging.dart';
import "package:mobcall/notifications/notification.dart";

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // This is the background message handler
  print("🔴 Handling a background message: ${message.messageId}");
  NotificationService().incomingCallNotification({
    "callId": "Hello",
    "callerName": message.data["callerName"],
    "callerNumber": {
      "number": "number",
      "countryCode": "countryCode",
    },
    "callerImage": message.data["callerImage"],
  });
}

class FCMNotificationService {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  static Future<void> initialize() async {
    // Request permission on iOS
    await _messaging.requestPermission();

    // Get token
    String? token = await _messaging.getToken();
    print("🔑 FCM Token: $token");

    // Handle foreground and background messages
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // Foreground message handling
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('🟢 Foreground message: ${message.notification?.title}');
    });

    // App opened from background
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('🟡 App opened from background: ${message.notification?.title}');
    });

    // App opened from terminated state
    RemoteMessage? initialMessage = await _messaging.getInitialMessage();
    if (initialMessage != null) {
      print(
        '🔵 App opened from terminated state: ${initialMessage.notification?.title}',
      );
    }
  }
}
