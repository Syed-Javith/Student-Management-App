import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:student/constants/constants.dart';
import 'package:student/pages/adminpage.dart';
import 'package:student/pages/homepage.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLoading = false;
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  void _login() async {
    try {
      setState(() {
        isLoading = true;
      });
      final result = await http.post(Uri.parse("$BASE_URI/auth/login"), body: {
        "email": _usernameController.text,
        "password": _passwordController.text
      });
      print(result);

      final Map<String, dynamic> responseData = json.decode(result.body);
      if (responseData['user']['_id'] != null) {
        SharedPreferences sf = await SharedPreferences.getInstance();
        sf.setString('userID', responseData['user']['_id']);
        sf.setString('TOKEN', responseData['token']);
        if (responseData['user']['isAdmin'] == true)
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AdminPage()));
        else
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const HomePage()));
      }
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Column(
        children: [
          TextField(
            controller: _usernameController,
            decoration: const InputDecoration(
              labelText: 'Username',
            ),
          ),
          const SizedBox(height: 20.0),
          TextField(
            controller: _passwordController,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'Password',
            ),
          ),
          const SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () {
              if (isLoading) return;
              _login();
            },
            child: Text(isLoading ? 'Loading...' : 'Login'),
          ),
        ],
      ),
    );
  }
}
