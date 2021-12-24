import 'package:flutter/material.dart';

class TaskListModel extends ChangeNotifier {
  List<TaskModel> _tasks = [];
  List<TaskModel> get tasks => _tasks;
  set tasks(List<TaskModel> value) {
    _tasks = value;
    notifyListeners();
  }

  void updateTask(TaskModel task, int index) {
    _tasks[index] = task;
    tasks = [..._tasks];
    notifyListeners();
  }

  void addTask(TaskModel task) {
    _tasks.add(task);
    notifyListeners();
  }

  void removeTask(TaskModel task) {
    _tasks.remove(task);
    notifyListeners();
  }
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