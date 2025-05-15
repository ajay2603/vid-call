import "dart:convert";

import "package:flutter/material.dart";
import "package:http/http.dart" as http;
import "package:mobcall/constants.dart";
import "package:mobcall/utils/secure_storage.dart";
import "package:mobcall/utils/dialogs/display_dialog.dart";

class SingInScreen extends StatefulWidget {
  const SingInScreen({super.key});

  @override
  State<SingInScreen> createState() => _SingInScreenState();
}

class _SingInScreenState extends State<SingInScreen> {
  // Variables to hold the email and password
  String _email = "";
  String _password = "";

  bool _obscure = true;

  Future<void> _signin() async {
    if (_email.isEmpty || _password.isEmpty) {
      displayDialog(context, "Invalid", "Please fill in all fields.");
      return;
    }

    try {
      final response = await http.post(
        Uri.parse("$serverURI/auth/signin"),
        body: <String, String>{'email': _email, 'password': _password},
      );

      if (response.statusCode == 200) {
        // Handle successful sign-in
        print("✒️ Sign-in successful");
        final responseData = jsonDecode(response.body);
        final token = responseData['token'];
        print("🗝️ Token: $token");
        SecureStorage.writeSecureData("token", token);
        Navigator.pushReplacementNamed(context, "/");
      } else {
        // Handle error
        displayDialog(context, "Error", "Invalid email or password.");
      }
    } catch (e) {
      displayDialog(context, "Error", "An error occurred. Please try again.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sign In")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) {
                setState(() {
                  _email = value;
                });
              },
            ),
            SizedBox(height: 20),
            TextFormField(
              obscureText: _obscure,
              decoration: InputDecoration(
                labelText: 'Password',
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscure ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscure = !_obscure;
                    });
                  },
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _password = value;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Handle sign in logic here
                print("✒️");
                print("Email: $_email");
                print("Password: $_password");

                _signin();
              },
              child: const Text("Sign In"),
            ),
            const SizedBox(height: 30),
            TextButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, "/signup");
              },
              child: const Text(
                "New User? Sign Up",
                style: TextStyle(color: Colors.blueAccent),
              ),
            ),
          ],
        ),
      ),
    );
  }
}