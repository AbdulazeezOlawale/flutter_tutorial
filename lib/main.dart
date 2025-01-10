// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_todo/pages/TodoList.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List itemList = [
    ["First item", false],
    ["Second item", false]
  ];

  void onChanged(bool? value, int index) {
    setState(() {
      itemList[index][1] = !itemList[index][1];
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.deepPurple[200],
        body: ListView.builder(
          itemCount: 1,
          itemBuilder: (BuildContext context, int index) {
            return TodoList(taskName: itemList[index][0], taskCompleted: itemList[index][1], onChanged: (p0) => onChanged(p0, index),);
          },
        ),
      ),
    );
  }
}
