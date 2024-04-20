import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student/models/user.dart';
import 'package:http/http.dart' as http;
import '../constants/constants.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String userID = "";
  String token = "";
  bool isPending = true;
  User user = User();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
  }

  void getUserData() async {
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    print("Request Headers: $headers");
    final response = await http.get(
      Uri.parse("$BASE_URI/student/$userID"),
      headers: headers,
    );
    if (response.statusCode == 200) {
      setState(() {
        user = User.fromJson(json.decode(response.body));
      });
      // print(user.toString());
    } else {
      // Handle error response from server
      print("Error: ${response.statusCode}");
    }
    setState(() {
      isPending = false;
    });
  }

  void getUser() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    setState(() {
      userID = sf.getString('userID') ?? "";
      token = sf.getString('TOKEN') ?? "";
      isPending = !isPending;
    });
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Container(
        child: Column(
          children: [
            Row(
              children: [Text(user.name ?? " ")],
            )
          ],
        ),
      ),
    );
  }
}
