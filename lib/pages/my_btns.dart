// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';

class Btns extends StatelessWidget {
  final String btnName;
  VoidCallback onPressed;
  Btns({
    super.key,
    required this.btnName,
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: Colors.deepPurple,
      onPressed: onPressed,
      child: Text(
        btnName,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}

void logToConsole() {
  print("the bane");
}
