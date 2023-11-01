import 'package:flutter/material.dart';

class MyFloatingActionButton extends StatelessWidget {

  final Function()? onPressed;
  MyFloatingActionButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(onPressed: onPressed,
      child: Icon(Icons.add),
    );
  }
}
