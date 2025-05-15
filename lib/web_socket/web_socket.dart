import 'package:socket_io_client/socket_io_client.dart' as IO;
import "package:mobcall/constants.dart";
import "package:mobcall/utils/secure_storage.dart";

class WebSocket {
  static late IO.Socket _socket;

  static void initialize() async {
    String token = await SecureStorage.readSecureData("token") ?? "";

    _socket = IO.io(serverURI, <String, dynamic>{
      'transports': ['websocket'],
      'auth': {'authorization': token},
    });

    _socket.onConnect((_) {
      print('✅ Connected to server');
    });

    _socket.onDisconnect((_) {
      print('❌ Disconnected from server');
    });

    _socket.onConnectError((err) {
      print('⚠️ Connection Error: $err');
    });

    _socket.onError((err) {
      print('❗ Error: $err');
    });

    _socket.on('server_message', (data) {
      print('📩 Message from server: $data');
    });
  }

  static IO.Socket getSocket() {
    return _socket;
  }

  static void sendMessage(String event, dynamic data) {
    _socket.emit(event, data);
  }

  static void disconnect() {
    _socket.disconnect();
  }
}
