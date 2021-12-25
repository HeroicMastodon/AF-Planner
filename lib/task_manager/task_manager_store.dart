import 'package:flutter/material.dart';

import 'models/task_list_model.dart';

class TaskManagerStore extends ChangeNotifier {
  TaskListModel _taskList = TaskListModel();
  set taskList(TaskListModel value) {
    _taskList = value;
    notifyListeners();
  }
  TaskListModel get taskList => _taskList;
}