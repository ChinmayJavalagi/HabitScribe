import 'package:flutter/material.dart';

class MyAlertBox extends StatelessWidget {
  final VoidCallback onSave;
  final TextEditingController controller;
  final VoidCallback onCancel;

  MyAlertBox({required this.controller, required this.onCancel, required this.onSave, required hintText});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey[900],
      content: TextField(
        controller: controller,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          enabledBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          focusedBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.white))
        ),
      ),
      actions: [
        MaterialButton(
          color: Colors.black,
          onPressed: onSave,
          child: Text(
            "Save",
            style: TextStyle(color: Colors.white),
          ),
        ),
        MaterialButton(
          color: Colors.black,
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
