import 'package:flutter/material.dart';
import 'package:student/widgets/add_user_form.dart';
import 'package:student/widgets/find_student_form.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  bool isAddStudent = false;
  bool isFindStudent = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Page'),
      ),
      body: Container(
        width: double.infinity,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isAddStudent = !isAddStudent;
                    });
                  },
                  child: Text('Add User')),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isFindStudent = !isFindStudent;
                    });
                  },
                  child: Text('Find Student')),
              isFindStudent ? FindStudentForm() : SizedBox(),
              isAddStudent ? AddUserForm() : SizedBox()
            ]),
      ),
    );
  }
}
