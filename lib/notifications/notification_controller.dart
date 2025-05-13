import 'package:awesome_notifications/awesome_notifications.dart';
import "package:mobcall/constants/navigator_key.dart";

class NotificationEvents {
  void initialize() {
    AwesomeNotifications().setListeners(
      onActionReceivedMethod: onActionReceivedMethod,
    );
  }

  Future<void> onActionReceivedMethod(ReceivedAction receivedAction) async {
    final data = receivedAction.payload;
    print("✌️ Received action");
    print("Received action: $receivedAction");
    print("Data: $data");
    if (receivedAction.buttonKeyPressed == 'ACCEPT') {
      print("📞 Call accepted");
      navigatorKey.currentState?.pushNamed('/second');
    } else if (receivedAction.buttonKeyPressed == 'REJECT') {
      print("☎️ Call rejected");
      navigatorKey.currentState?.pushNamed('/second');
    } else {
      // Notification itself was tapped (not buttons)
      print("📲 Notification tapped");
      navigatorKey.currentState?.pushNamed('/');
      // Navigate or open app screen here
    }
  }
}
