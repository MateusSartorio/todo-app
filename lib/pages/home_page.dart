import 'package:flutter/material.dart';
import 'package:todo_app/tiles/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List todoList = [
    ["Make tutorial", false],
    ["To exercise", false],
  ];

  void checkboxChanged(bool? value, int index) {
    setState(() {
      todoList[index][1] = !todoList[index][1];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("TODO")),
      body: ListView.builder(
          itemCount: todoList.length,
          itemBuilder: (context, index) => TodoTile(
                taskName: todoList[index][0],
                taskCompleted: todoList[index][1],
                onChanged: (value) => checkboxChanged(value, index),
              )),
    );
  }
}
