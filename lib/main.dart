import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mobcall/myapp.dart';
import 'package:mobcall/firebase_options.dart';
import 'package:mobcall/notifications/fcm_notification_service.dart';
import 'package:mobcall/notifications/notification.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FCMNotificationService.initialize();
  await NotificationService().initialize();
  runApp(const MyApp());
}
