// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_todo/pages/dialog_box.dart';
import 'package:flutter_todo/pages/todo_tile.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final _controller = TextEditingController();

  List todoList = [
    ["Fisrt item", false],
    ["Second Item", false]
  ];

  void changeItem(bool? value, int index) {
    setState(() {
      todoList[index][1] = !todoList[index][1];
    });
  }

  void onSave() {
    setState(() {
      todoList.add([_controller.text, false]);
      Navigator.of(context).pop();
      _controller.clear();
    });
  }

  void onCancle() {
    Navigator.of(context).pop();
    _controller.clear();
  }

  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
            controller: _controller, onCancle: onCancle, onSave: onSave);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Center(
          child: Text(
            "Todo App",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: todoList.length,
        itemBuilder: (BuildContext context, int index) {
          return TodoTile(
              taskName: todoList[index][0],
              onChanged: (p0) => changeItem(p0, index),
              taskCompleted: todoList[index][1]);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: Icon(Icons.add),
      ),
    );
  }
}
