import 'package:flutter/material.dart';

class MyAlertBox extends StatelessWidget {
  final VoidCallback onSave;
  final TextEditingController controller;
  final VoidCallback onCancel;
  final String hintText;

  MyAlertBox({
    required this.controller,
    required this.onCancel,
    required this.onSave,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey[900],
      title: Text(
        "Enter Habit",
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      content: TextField(
        controller: controller,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.white70),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(8.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: onSave,
          child: Text(
            "Save",
            style: TextStyle(color: Colors.white),
          ),
        ),
        TextButton(
          onPressed: onCancel,
          child: Text(
            "Cancel",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
