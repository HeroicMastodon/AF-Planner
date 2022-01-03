import 'package:af_planner/task_manager/models/task_model.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class SectionModel extends ChangeNotifier {
  String _name = "";
  set name(String value) {
    _name = value;
    notifyListeners();
  }
  String get name => _name;

  int _position = 0;
  set position(int value) {
    _position = value;
    notifyListeners();
  }
  int get position => _position;

  bool get isDefault => position == 0;

  String _id = const Uuid().v4();
  set id(String value) {
    _id = value;
    notifyListeners();
  }
  String get id => _id;

  List<TaskModel> _tasks = [];
  set tasks(List<TaskModel> value) {
    _tasks = value;
    notifyListeners();
  }
  List<TaskModel> get tasks => _tasks;

  addTask(TaskModel task) => tasks = [...tasks, task];



}