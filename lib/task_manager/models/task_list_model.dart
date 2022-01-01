import 'package:flutter/material.dart';

import 'task_model.dart';

class TaskListModel extends ChangeNotifier {
  List<TaskModel> _tasks = [];

  List<TaskModel> get tasks => _tasks;

  set tasks(List<TaskModel> value) {
    _tasks = value;
    notifyListeners();
  }

  void updateTask(TaskModel task) =>
      tasks = [for (final item in tasks) item.id == task.id ? task : item];

  void completeTask(TaskModel task, bool complete) {
    task.isComplete = complete;

    completeChildren(task.children, complete);
  }

  void completeChildren(List<TaskModel> tasks, bool complete) {
    for (final task in tasks) {
      task.isComplete = complete;
      completeChildren(task.children, complete);
    }
  }

  void addTask(TaskModel task) => tasks = [...tasks, task];

  void removeTask(TaskModel task) => tasks = [
    for (final item in tasks)
      if (item != task) item
  ];
}