import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class TaskListModel extends ChangeNotifier {
  TaskListModel(this.parent);
  ChangeNotifier parent;
  List<TaskModel> _tasks = [];

  List<TaskModel> get tasks => _tasks;

  set tasks(List<TaskModel> value) {
    _tasks = value;
    notifyListeners();
    parent.notifyListeners();
  }

  void updateTask(TaskModel task, int index) =>
      tasks = [for (final item in tasks) item.id == task.id ? task : item];

  void addTask(TaskModel task) => tasks = [...tasks, task];

  void removeTask(TaskModel task) => tasks = [
        for (final item in tasks)
          if (item != task) item
      ];
}

class TaskModel extends ChangeNotifier {
  String _name = "";

  set name(String value) {
    _name = value;
    notifyListeners();
  }

  String get name => _name;

  String _description = "";

  set description(String value) {
    _description = value;
    notifyListeners();
  }

  String get description => _description;

  DateTime? _dueDate;

  set dueDate(DateTime? value) {
    _dueDate = value;
    notifyListeners();
  }

  DateTime? get dueDate => _dueDate;

  int? _priority;

  set priority(int? value) {
    _priority = value;
    notifyListeners();
  }

  int? get priority => _priority;

  List<String> _labels = [];

  set labels(List<String> value) {
    _labels = value;
    notifyListeners();
  }

  List<String> get labels => _labels;

  bool _isComplete = false;

  set isComplete(bool value) {
    _isComplete = value;
    notifyListeners();
  }

  bool get isComplete => _isComplete;

  String _id = const Uuid().v4();

  set id(String value) {
    _id = value;
    notifyListeners();
  }

  String get id => _id;
// List<TaskModel> _children = [];
// set children(List<TaskModel> value) {
//   _children = value;
//   notifyListeners();
// }
// List<TaskModel> get children => _children;
// void addChild(TaskModel value) {
//   _children.add(value);
//   notifyListeners();
// }
// void removeChild(TaskModel value) {
//   _children.remove(value);
//   notifyListeners();
// }
}
