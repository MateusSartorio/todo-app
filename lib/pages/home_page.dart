import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo_app/data/database.dart';
import 'package:todo_app/tiles/create_task_dialog_box.dart';
import 'package:todo_app/tiles/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _myBox = Hive.box('mybox');
  TodoDatabase db = TodoDatabase();

  final TextEditingController _controller = TextEditingController();

  // Loads data from local storage
  @override
  void initState() {
    // if this is the first time ever opening the app, create default data
    if (_myBox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }

    super.initState();
  }

  // Saves new task to local storage
  void saveNewTask() {
    setState(() {
      db.todoList.add([_controller.text, false]);
      db.updateDatabase();
      _controller.clear();
    });

    Navigator.of(context).pop();
  }

  // Checks or unchecks task box
  void checkboxChanged(bool? value, int index) {
    setState(() {
      db.todoList[index][1] = !db.todoList[index][1];
    });

    db.updateDatabase();
  }

  // Creates new task dialog
  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return CreateTaskDialogBox(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: () => {_controller.clear(), Navigator.of(context).pop()},
        );
      },
    );
  }

  // Deletes a task from the local storage
  void deleteTask(int index) {
    setState(() {
      db.todoList.removeAt(index);
    });

    db.updateDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("TODOS"), centerTitle: true),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
          itemCount: db.todoList.length,
          itemBuilder: (context, index) => TodoTile(
                taskName: db.todoList[index][0],
                taskCompleted: db.todoList[index][1],
                onChanged: (value) => checkboxChanged(value, index),
                deleteFunction: (context) => deleteTask(index),
              )),
    );
  }
}
