import 'package:flutter/material.dart';

class FindStudentForm extends StatefulWidget {
  const FindStudentForm({super.key});

  @override
  State<FindStudentForm> createState() => _FindStudentFormState();
}

class _FindStudentFormState extends State<FindStudentForm> {
  final _studentIDController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _studentIDController,
      decoration: const InputDecoration(
        labelText: 'Username',
      ),
    );
  }
}
