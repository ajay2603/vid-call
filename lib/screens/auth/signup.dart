import "dart:convert";

import "package:flutter/material.dart";
import "package:mobcall/constants.dart";
import "package:http/http.dart" as http;

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  // Variables to hold the email and password
  String _email = "";
  String _password = "";
  String _rePassword = "";
  String _name = "";

  Future<void> _signup() async {
    if (_email.isEmpty ||
        _password.isEmpty ||
        _rePassword.isEmpty ||
        _name.isEmpty) {
      displayDialog(context, "Invalid", "Please fill in all fields.");
      return;
    }

    if (_password != _rePassword) {
      displayDialog(context, "Invalid", "Passwords do not match.");
      return;
    }

    try {
      final response = await http.post(
        Uri.parse("$serverURI/auth/signup"),
        body: <String, String>{
          'email': _email,
          'password': _password,
          'name': _name,
        },
      );

      if (response.statusCode == 201) {
        // Handle successful signup
        print("👍 Signup successful");
        Navigator.pushReplacementNamed(context, "/signin");
        // Navigate to the next screen or show a success message
      } else {
        final responseData = jsonDecode(response.body);
        print("👎 Signup failed");
        displayDialog(
          context,
          "Failed",
          responseData['message'] ?? "Trouble signing up\n Try again!",
        );
      }
    } catch (e) {
      print("❌ Error: $e");
      displayDialog(
        context,
        "Error",
        "An error occurred while signing up. Please try again.",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sign Up")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: "Name",
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _name = value;
                });
              },
            ),
            const SizedBox(height: 20),
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
            const SizedBox(height: 20),
            TextFormField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                border: const OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _password = value;
                });
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Re-Enter Password',
                border: const OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _rePassword = value;
                });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Handle sign up logic here
                print("✒️");
                print("Email: $_email");
                print("Password: $_password");
                print("Re-Password: $_rePassword");
                print("Name: $_name");

                _signup();
                print("After signup");
              },
              child: const Text("Sign Up"),
            ),
            const SizedBox(height: 30),
            TextButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, "/signin");
              },
              child: const Text(
                "Already have an account? Sign In",
                style: TextStyle(color: Colors.blueAccent),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void displayDialog(BuildContext context, String title, String message) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("OK"),
          ),
        ],
      );
    },
  );
}