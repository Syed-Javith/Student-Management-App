import 'package:flutter/material.dart';
import 'package:student/constants/constants.dart';
import 'package:student/models/user.dart';
import 'package:http/http.dart' as http;

class AddUserForm extends StatefulWidget {
  const AddUserForm({Key? key}) : super(key: key);

  @override
  State<AddUserForm> createState() => _AddUserFormState();
}

class _AddUserFormState extends State<AddUserForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();
  final TextEditingController _departmentController = TextEditingController();
  final TextEditingController _rollNumberController = TextEditingController();
  bool _isAdminController = false;

  _addUser() async {
    User data = new User(
        email: _emailController.text,
        department: _departmentController.text,
        gender: _genderController.text,
        isAdmin: _isAdminController,
        marks: (_isAdminController) ? null : [],
        name: _nameController.text,
        rollNumber: int.parse(_rollNumberController.text),
        year: int.parse(_yearController.text));

    try {
      final response = await http.post(Uri.parse('$BASE_URI/admin/register'),
          body: data.toString());
      if (response.statusCode == 200) {
        print("user added");
      } else if (response.statusCode == 400) {
        print("user already exists");
      }
      print(response.body);
    } catch (e) {
      print(e);
    } finally {}
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextField(
            controller: _nameController,
            decoration: InputDecoration(labelText: 'Name'),
          ),
          TextField(
            controller: _emailController,
            decoration: InputDecoration(labelText: 'Email'),
          ),
          TextField(
            controller: _passwordController,
            decoration: InputDecoration(labelText: 'Password'),
            obscureText: true,
          ),
          TextField(
            controller: _genderController,
            decoration: InputDecoration(labelText: 'Gender'),
          ),
          TextField(
            controller: _yearController,
            decoration: InputDecoration(labelText: 'Year'),
            keyboardType: TextInputType.number,
          ),
          TextField(
            controller: _departmentController,
            decoration: InputDecoration(labelText: 'Department'),
          ),
          TextField(
            controller: _rollNumberController,
            decoration: InputDecoration(labelText: 'Roll Number'),
            keyboardType: TextInputType.number,
          ),
          Row(
            children: [
              Checkbox(
                value: this._isAdminController,
                onChanged: (bool? value) {
                  setState(() {
                    _isAdminController = value ?? false;
                  });
                },
              ),
              Text('Is Admin'),
            ],
          ),
          ElevatedButton(
            onPressed: () {
              _addUser();
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}
