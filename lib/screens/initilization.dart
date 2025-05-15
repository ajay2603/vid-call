import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobcall/web_socket/web_socket.dart';
import 'package:mobcall/constants.dart';
import 'package:http/http.dart' as http;
import 'package:mobcall/utils/secure_storage.dart';
import 'package:mobcall/utils/dialogs/display_dialog.dart';

class Initialization extends StatefulWidget {
  const Initialization({super.key});

  @override
  State<Initialization> createState() => _InitializationState();
}

class _InitializationState extends State<Initialization> {
  @override
  void initState() {
    super.initState();
    WebSocket.initialize();
    authenticate();
  }

  Future<void> authenticate() async {
    try {
      final token = await SecureStorage.readSecureData("token") ?? "";
      print("🗝️ Token for authentication: $token");
      final response = await http.post(
        Uri.parse("$serverURI/auth/verify-token"),
        headers: <String, String>{
          'Authorization': token,
        }
      );

      if (response.statusCode == 200) {
        print("🗝️ Token is valid");
        Navigator.pushReplacementNamed(context, "/home");
      } else {
        final responseData = jsonDecode(response.body);
        print("❌ Token is invalid");
        displayDialog(
          context,
          "Failed",
          responseData['message'] ?? "Token is invalid",
        );
        Navigator.pushReplacementNamed(context, "/signin");
      }
    } catch (e) {
      print("❌ Error occurred: $e");
      retryDialog("Error", "An error occurred. Please try again.");
    }
  }

  void retryDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await authenticate();
              },
              child: const Text("Retry"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushReplacementNamed(context, "/signin");
              },
              child: const Text("Sign In"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text("Initializing...")));
  }
}
