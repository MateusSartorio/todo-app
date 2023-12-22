import 'package:hive/hive.dart';

class TodoDatabase {
  List todoList = [];

  final _myBox = Hive.box('mybox');

  // run this method if this is the first time ever opening this app
  void createInitialData() {
    todoList = [
      ["Placeholder task", false]
    ];
  }

  // load the data from the database
  void loadData() {
    todoList = _myBox.get("TODOLIST");
  }

  // update the database
  void updateDatabase() {
    _myBox.put("TODOLIST", todoList);
  }
}
