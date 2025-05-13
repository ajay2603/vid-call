import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();

  factory NotificationService() {
    return _instance;
  }

  NotificationService._internal();

  Future<void> initialize() async {
    await AwesomeNotifications().initialize(null, [
      NotificationChannel(
        channelKey: 'call_channel',
        channelName: 'Calls',
        channelDescription: 'Incoming call notifications',
        defaultColor: const Color(0xFF9D50DD),
        ledColor: Colors.white,
        importance: NotificationImportance.Max,
        channelShowBadge: true,
        locked: true,
        defaultRingtoneType: DefaultRingtoneType.Ringtone,
        playSound: true,
        criticalAlerts: true,
      ),
    ], debug: true);
  }

  Future<void> incomingCallNotification() async {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 1,
        channelKey: 'call_channel',
        title: 'Incoming Call',
        body: 'Ajay is calling you...',
        category: NotificationCategory.Call,
        wakeUpScreen: true,
        fullScreenIntent: true,
        autoDismissible: false,
        backgroundColor: Colors.green,
        locked: true,
      ),
      actionButtons: [
        NotificationActionButton(
          key: 'ACCEPT',
          label: 'Accept',
          color: Colors.green,
          autoDismissible: true,
        ),
        NotificationActionButton(
          key: 'REJECT',
          label: 'Reject',
          color: Colors.red,
          autoDismissible: true,
        ),
      ],
    );
  }
}
