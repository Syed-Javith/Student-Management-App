// ignore_for_file: unnecessary_null_comparison
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:student/constants/constants.dart';
import 'package:student/widgets/mark.dart';
// import 'package:student/models/user.dart';
import 'package:student/models/user.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String userID = "";
  String token = "";
  bool isPending = true;
  User user = User();
  @override
  void initState() {
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
        title: Text("Home"),
      ),
      body: Container(
        child: isPending
            ? Text("Loading...")
            : user != null
                ? Container(
                    child: Column(children: [
                      Text(user.name ?? "No user"),
                      // Mark(code: "CODE", subject: "SUBJECT", mark: 90) as Widget,
                      if (user.marks != null)
                        ...user.marks!.map((mark) => MarkWidget(
                            code: mark.code.toString(),
                            subject: mark.subject.toString(),
                            mark: mark.mark.toString())),
                    ]),
                  )
                : const CircularProgressIndicator(),
      ),
    );
  }
}
